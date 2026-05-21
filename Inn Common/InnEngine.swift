import Foundation

// MARK: - Deterministic seeded RNG

struct InnSeededRNG: RandomNumberGenerator {
    private var state: UInt64
    init(seed: UInt64) {
        // SplitMix64 init guard against zero seed
        self.state = seed == 0 ? 0xA5A5_A5A5_DEAD_BEEF : seed
    }
    mutating func next() -> UInt64 {
        state = state &+ 0x9E3779B97F4A7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58476D1CE4E5B9
        z = (z ^ (z >> 27)) &* 0x94D049BB133111EB
        return z ^ (z >> 31)
    }
}

extension InnSeededRNG {
    mutating func roll(_ upperExclusive: Int) -> Int {
        guard upperExclusive > 0 else { return 0 }
        return Int(next() % UInt64(upperExclusive))
    }
    mutating func roll(in range: ClosedRange<Int>) -> Int {
        let span = range.upperBound - range.lowerBound + 1
        return range.lowerBound + roll(span)
    }
    mutating func chance(_ percent: Int) -> Bool {
        return roll(100) < percent
    }
    mutating func pick<T>(_ array: [T]) -> T? {
        guard !array.isEmpty else { return nil }
        return array[roll(array.count)]
    }
}

// MARK: - Engine (pure functions, no Published, no side effects)

enum InnEngine {

    static func dailySeed(year: Int, day: Int, salt: UInt64) -> UInt64 {
        let base = UInt64(year) &* 365 &+ UInt64(day)
        return base &* 0x100000001B3 &+ salt
    }

    static func rollWeather(year: Int, day: Int) -> InnWeather {
        var rng = InnSeededRNG(seed: dailySeed(year: year, day: day, salt: 11))
        let all = InnWeather.allCases
        // Weight clear/overcast higher
        let weights: [InnWeather: Int] = [
            .clear: 22, .overcast: 18, .drizzle: 12, .rain: 12,
            .fog: 10, .snow: 10, .blizzard: 6, .gale: 10
        ]
        let total = weights.values.reduce(0, +)
        let r = rng.roll(total)
        var acc = 0
        for w in all {
            acc += weights[w] ?? 0
            if r < acc { return w }
        }
        return .clear
    }

    static func rollRoster(year: Int, day: Int, weather: InnWeather,
                           settlements: [Settlement], lifetimeRevenue: Int) -> [InnGuest] {
        var rng = InnSeededRNG(seed: dailySeed(year: year, day: day, salt: 47))
        // Determine size 3-6 weighted by weather + best settlement
        let weatherMul = weather.trafficMultiplier
        let bestRep = settlements.map { $0.reputation }.max() ?? 20
        let baseSize: Int = {
            if bestRep > 70 { return 5 }
            if bestRep > 50 { return 4 }
            if bestRep > 30 { return 4 }
            return 3
        }()
        let bonus = lifetimeRevenue > 300 ? 1 : 0
        let raw = Double(baseSize + bonus) * weatherMul
        var size = min(6, max(3, Int(raw.rounded())))
        // Tiny jitter
        if rng.chance(35) { size = max(3, min(6, size + (rng.chance(50) ? 1 : -1))) }

        // Compute settlement weights (higher rep => more guests from there)
        let settlementWeights: [Int] = settlements.map { max(2, $0.reputation + 30) }
        let totalSW = settlementWeights.reduce(0, +)

        var guests: [InnGuest] = []
        var usedArchIds = Set<Int>()
        for i in 0..<size {
            let pick = rng.roll(totalSW)
            var acc = 0
            var settleIdx = 0
            for (idx, w) in settlementWeights.enumerated() {
                acc += w
                if pick < acc { settleIdx = idx; break }
            }
            let s = settlements[settleIdx]
            // Pick an archetype from the settlement; avoid same-day duplicates
            var pool = s.primaryGuestArchetypeIds.filter { !usedArchIds.contains($0) }
            if pool.isEmpty { pool = s.primaryGuestArchetypeIds }
            let chosenArchId = pool[rng.roll(pool.count)]
            usedArchIds.insert(chosenArchId)
            let arch = InnCatalog.archetype(chosenArchId)
            let nights = rng.roll(in: 1...3) + (arch.preferredRoom.rawValue / 2)
            let guest = InnGuest(
                id: UUID(),
                archetypeId: chosenArchId,
                hunger: 60 + rng.roll(15),
                thirst: 60 + rng.roll(20),
                sleep: 55 + rng.roll(20),
                chatLevel: 0,
                happiness: 55 + rng.roll(10),
                roomIndex: nil,
                dayArrived: day + i,  // arrival jitter ignored — they all arrive today
                nightsRemaining: nights,
                dropped: [],
                hasPaid: false,
                refused: false
            )
            guests.append(guest)
        }
        // Reset dayArrived to today (cleaner)
        guests = guests.map { var g = $0; g = InnGuest(id: g.id, archetypeId: g.archetypeId,
                                                       hunger: g.hunger, thirst: g.thirst,
                                                       sleep: g.sleep, chatLevel: 0,
                                                       happiness: g.happiness,
                                                       roomIndex: nil, dayArrived: day,
                                                       nightsRemaining: g.nightsRemaining,
                                                       dropped: [], hasPaid: false,
                                                       refused: false); return g }
        return guests
    }

    static func rollEvent(year: Int, day: Int, weather: InnWeather, eventCatalog: [InnEvent]) -> InnEvent? {
        var rng = InnSeededRNG(seed: dailySeed(year: year, day: day, salt: 73))
        // 60% chance of one event
        guard rng.chance(60) else { return nil }
        let totalW = eventCatalog.reduce(0) { $0 + $1.weight }
        let pick = rng.roll(totalW)
        var acc = 0
        for e in eventCatalog {
            acc += e.weight
            if pick < acc { return e }
        }
        return eventCatalog.first
    }

    // Probability a guest drops a rumor given an action.
    static func rumorCaptureChance(archetype: InnArchetype, action: ChatAction,
                                   hasBartender: Bool, currentChat: Int) -> Int {
        let gossip = archetype.gossipLevel
        let suspicion = archetype.suspicion
        let temperament = archetype.temperament
        var base = gossip * 8 - suspicion * 4
        switch action {
        case .listen:
            base += 6
        case .pourMore:
            base += 14 + (hasBartender ? 12 : 0)
            base -= temperament   // volatile drinkers spill less reliably
        case .pressGently:
            base += 9 - suspicion * 2
        case .befriend:
            base += 18 - temperament
        }
        base += currentChat * 3
        return max(5, min(94, base))
    }

    // Pick a rumor id this archetype could drop (weighted by their tag set, not yet dropped).
    static func pickRumorForArchetype(year: Int, day: Int, slot: Int,
                                      archetype: InnArchetype,
                                      excludedIds: [Int]) -> Int? {
        let pool = InnCatalog.rumors.filter {
            archetype.rumorTags.contains($0.category) && !excludedIds.contains($0.id)
        }
        guard !pool.isEmpty else { return nil }
        var rng = InnSeededRNG(seed: dailySeed(year: year, day: day, salt: UInt64(slot) &+ UInt64(archetype.id) &* 31))
        return pool[rng.roll(pool.count)].id
    }

    // Compute a base buyer offer for a captured rumor.
    static func priceForBuyer(_ buyer: BuyerKind, rumor: CapturedRumor, lifetimeRevenue: Int) -> Int {
        let base = rumor.tier.basePrice
        var mult = buyer.priceMultiplier
        if buyer.preferredCategories.contains(rumor.category) {
            mult += 0.3
        }
        // Corroboration boost
        mult += Double(min(3, rumor.corroborationCount)) * 0.10
        // Truth gives a small uplift
        switch rumor.discoveredTruth {
        case .trueRumor: mult += 0.10
        case .partial:   mult += 0.05
        case .falseRumor: mult -= 0.15
        case .unknown: break
        }
        // Prestige scales the floor
        let prestigeAdd = lifetimeRevenue / 80
        let raw = Double(base + prestigeAdd) * mult
        return max(2, Int(raw.rounded()))
    }

    static func prestigeTier(lifetimeRevenue: Int, rumorsSold: Int) -> Int {
        let r = lifetimeRevenue, s = rumorsSold
        if r >= 1200 && s >= 80 { return 6 }
        if r >= 800 && s >= 50 { return 5 }
        if r >= 500 && s >= 30 { return 4 }
        if r >= 280 && s >= 15 { return 3 }
        if r >= 130 && s >= 6 { return 2 }
        if r >= 40 { return 1 }
        return 0
    }

    static func prestigeLabel(_ tier: Int) -> String {
        switch tier {
        case 0: return "Roadside Shack"
        case 1: return "Tap House"
        case 2: return "Wayhouse"
        case 3: return "Crossroads Inn"
        case 4: return "Notable Inn"
        case 5: return "Renowned Estate"
        case 6: return "Legend of the Road"
        default: return "Roadside Shack"
        }
    }
}

enum ChatAction: String, Codable {
    case listen, pourMore, pressGently, befriend
    var label: String {
        switch self {
        case .listen: return "Listen"
        case .pourMore: return "Pour More"
        case .pressGently: return "Press Gently"
        case .befriend: return "Befriend"
        }
    }
}
