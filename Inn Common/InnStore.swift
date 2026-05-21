import Foundation
import SwiftUI

// MARK: - InnGameState decoder with defaults (resilient against future schema)

extension InnGameState {
    enum CodingKeys: String, CodingKey {
        case version, day, year, weather, coins, foodStock, drinkStock, extras
        case rooms, tables, menu, staff, guests, roster, capturedRumors, settlements
        case arcs, unlockedUpgradeIds, achievements, quests, pendingEvent, eventLog
        case ledger, lifetimeRevenue, rumorsSold, prestigeTier, flags, buyerInterestSeed
        case todayActionToken
    }
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        self.version           = (try? c.decodeIfPresent(Int.self, forKey: .version)) ?? 1
        self.day               = (try? c.decodeIfPresent(Int.self, forKey: .day)) ?? 1
        self.year              = (try? c.decodeIfPresent(Int.self, forKey: .year)) ?? 1
        self.weather           = (try? c.decodeIfPresent(InnWeather.self, forKey: .weather)) ?? .clear
        self.coins             = (try? c.decodeIfPresent(Int.self, forKey: .coins)) ?? 80
        self.foodStock         = (try? c.decodeIfPresent(InnFoodStock.self, forKey: .foodStock)) ?? InnFoodStock()
        self.drinkStock        = (try? c.decodeIfPresent(InnDrinkStock.self, forKey: .drinkStock)) ?? InnDrinkStock()
        self.extras            = (try? c.decodeIfPresent(InnExtras.self, forKey: .extras)) ?? InnExtras()
        self.rooms             = (try? c.decodeIfPresent([InnRoom].self, forKey: .rooms)) ?? []
        self.tables            = (try? c.decodeIfPresent([InnTable].self, forKey: .tables)) ?? []
        self.menu              = (try? c.decodeIfPresent([Int].self, forKey: .menu)) ?? []
        self.staff             = (try? c.decodeIfPresent([StaffMember].self, forKey: .staff)) ?? []
        self.guests            = (try? c.decodeIfPresent([InnGuest].self, forKey: .guests)) ?? []
        self.roster            = (try? c.decodeIfPresent([InnGuest].self, forKey: .roster)) ?? []
        self.capturedRumors    = (try? c.decodeIfPresent([CapturedRumor].self, forKey: .capturedRumors)) ?? []
        self.settlements       = (try? c.decodeIfPresent([Settlement].self, forKey: .settlements)) ?? []
        self.arcs              = (try? c.decodeIfPresent([ArcProgress].self, forKey: .arcs)) ?? []
        self.unlockedUpgradeIds = (try? c.decodeIfPresent([Int].self, forKey: .unlockedUpgradeIds)) ?? []
        self.achievements      = (try? c.decodeIfPresent([InnAchievement].self, forKey: .achievements)) ?? []
        self.quests            = (try? c.decodeIfPresent([InnQuest].self, forKey: .quests)) ?? []
        self.pendingEvent      = (try? c.decodeIfPresent(ActiveEventState.self, forKey: .pendingEvent)) ?? nil
        self.eventLog          = (try? c.decodeIfPresent([String].self, forKey: .eventLog)) ?? []
        self.ledger            = (try? c.decodeIfPresent([InnLedgerEntry].self, forKey: .ledger)) ?? []
        self.lifetimeRevenue   = (try? c.decodeIfPresent(Int.self, forKey: .lifetimeRevenue)) ?? 0
        self.rumorsSold        = (try? c.decodeIfPresent(Int.self, forKey: .rumorsSold)) ?? 0
        self.prestigeTier      = (try? c.decodeIfPresent(Int.self, forKey: .prestigeTier)) ?? 0
        self.flags             = (try? c.decodeIfPresent([String: Int].self, forKey: .flags)) ?? [:]
        self.buyerInterestSeed = (try? c.decodeIfPresent(Int.self, forKey: .buyerInterestSeed)) ?? 0
        self.todayActionToken  = (try? c.decodeIfPresent(Int.self, forKey: .todayActionToken)) ?? 1
    }
}

// MARK: - Store

final class InnStore: ObservableObject {

    static let storeKey = "icr.state.v1"

    @Published var state: InnGameState = InnGameState()

    init() {
        if let loaded = Self.loadFromDefaults() {
            self.state = loaded
        } else {
            self.state = Self.makeFreshState()
            save()
        }
    }

    // MARK: - Persistence

    static func loadFromDefaults() -> InnGameState? {
        guard let data = UserDefaults.standard.data(forKey: storeKey) else { return nil }
        do {
            return try JSONDecoder().decode(InnGameState.self, from: data)
        } catch {
            return nil
        }
    }

    func save() {
        do {
            let data = try JSONEncoder().encode(state)
            UserDefaults.standard.set(data, forKey: Self.storeKey)
        } catch {
            // swallow — local persistence only
        }
    }

    // MARK: - Fresh state

    static func makeFreshState() -> InnGameState {
        var s = InnGameState()
        s.rooms = (0..<8).map { InnRoom(id: $0, tier: .cot, occupiedByGuest: nil) }
        s.tables = (0..<6).map { InnTable(id: $0, tier: .plain) }
        s.menu = [1, 4, 5, 17, 18, 21]  // Stew, Cheese, Bread, Strong Ale, Ale, Cider
        s.settlements = InnCatalog.settlementSeeds
        s.arcs = ArcKind.allCases.map { ArcProgress(kind: $0) }
        s.achievements = InnCatalog.achievementsSeed
        s.quests = InnCatalog.questsSeed
        s.weather = InnEngine.rollWeather(year: 1, day: 1)
        s.roster = InnEngine.rollRoster(year: 1, day: 1, weather: s.weather,
                                        settlements: s.settlements, lifetimeRevenue: 0)
        return s
    }

    // MARK: - Reset progress (every derived field returns to defaults)

    func resetProgress() {
        objectWillChange.send()
        state = Self.makeFreshState()
        save()
    }

    // MARK: - Lookups

    var archetypeById: [Int: InnArchetype] {
        Dictionary(uniqueKeysWithValues: InnCatalog.archetypes.map { ($0.id, $0) })
    }

    func archetype(forGuest g: InnGuest) -> InnArchetype {
        InnCatalog.archetype(g.archetypeId)
    }

    // MARK: - Day advance

    func advanceDay() {
        objectWillChange.send()
        var s = state

        // Pay nightly bills for staff every 7 days
        if s.day % 7 == 0 {
            let wages = s.staff.reduce(0) { $0 + $1.role.weeklyWage }
            if wages > 0 {
                s.coins -= wages
                s.ledger.append(InnLedgerEntry(day: s.day, delta: -wages, memo: "Weekly wages"))
                s.eventLog.insert("Day \(s.day): paid \(wages) in wages.", at: 0)
            }
        }

        // Resolve overnight stays: guests pay if they have a room and are content; nights tick down.
        var newGuests: [InnGuest] = []
        for var g in s.guests {
            let arch = InnCatalog.archetype(g.archetypeId)
            if let _ = g.roomIndex {
                let nightlyRate = s.rooms.first(where: { $0.id == g.roomIndex })?.tier.nightlyRate ?? 0
                let pay = max(2, nightlyRate + (g.happiness / 25))
                s.coins += pay
                s.lifetimeRevenue += pay
                s.ledger.append(InnLedgerEntry(day: s.day, delta: pay, memo: "Lodging: \(arch.name)"))
                g.hasPaid = true
            }
            // Decay needs
            g.hunger = max(0, g.hunger - 18)
            g.thirst = max(0, g.thirst - 22)
            g.sleep = max(0, g.sleep - 12)
            g.nightsRemaining -= 1
            if g.nightsRemaining <= 0 {
                // Guest departs (no longer occupies a room next morning)
                if let rIdx = g.roomIndex, let idx = s.rooms.firstIndex(where: { $0.id == rIdx }) {
                    s.rooms[idx].occupiedByGuest = nil
                }
            } else {
                newGuests.append(g)
            }
        }
        s.guests = newGuests

        // Tick weather/roster for the NEW day
        s.day += 1
        if s.day > 365 { s.day = 1; s.year += 1 }

        s.weather = InnEngine.rollWeather(year: s.year, day: s.day)
        s.roster = InnEngine.rollRoster(year: s.year, day: s.day, weather: s.weather,
                                        settlements: s.settlements,
                                        lifetimeRevenue: s.lifetimeRevenue)
        // Maybe an event
        if let ev = InnEngine.rollEvent(year: s.year, day: s.day, weather: s.weather,
                                        eventCatalog: InnCatalog.events) {
            s.pendingEvent = ActiveEventState(eventId: ev.id, resolved: false, optionPicked: nil)
        } else {
            s.pendingEvent = nil
        }

        // Reset daily action token (1 chat capture attempt per guest per day handled separately)
        s.todayActionToken = 1

        // Update prestige
        s.prestigeTier = InnEngine.prestigeTier(lifetimeRevenue: s.lifetimeRevenue,
                                                rumorsSold: s.rumorsSold)

        // Quest check by lifetime revenue gates (simple unlock; completion is event-driven elsewhere)
        for i in 0..<s.quests.count {
            if !s.quests[i].completed && s.lifetimeRevenue >= s.quests[i].prereqLifetimeRevenue {
                // Quests still flagged completed only by player-driven checks; leave for now.
            }
        }

        // Achievement: First Night
        unlock(&s, achievementId: 1)
        if s.day > 100 { unlock(&s, achievementId: 27) }

        state = s
        save()
    }

    private func unlock(_ s: inout InnGameState, achievementId: Int) {
        guard let idx = s.achievements.firstIndex(where: { $0.id == achievementId }) else { return }
        if !s.achievements[idx].unlocked {
            s.achievements[idx].unlocked = true
            s.eventLog.insert("Day \(s.day): unlocked “\(s.achievements[idx].name)”.", at: 0)
        }
    }

    // MARK: - Roster actions

    func acceptGuest(_ g: InnGuest) {
        objectWillChange.send()
        var s = state
        // assign first free room
        if let freeIdx = s.rooms.firstIndex(where: { $0.occupiedByGuest == nil }) {
            s.rooms[freeIdx].occupiedByGuest = g.id
            var ng = g
            ng.roomIndex = s.rooms[freeIdx].id
            s.guests.append(ng)
            s.roster.removeAll { $0.id == g.id }
            s.eventLog.insert("Day \(s.day): accepted \(InnCatalog.archetype(g.archetypeId).name) to room \(freeIdx + 1).", at: 0)

            // Quest 4 - First Guest
            if let qIdx = s.quests.firstIndex(where: { $0.id == 4 }) {
                if !s.quests[qIdx].completed {
                    s.quests[qIdx].completed = true
                    s.coins += s.quests[qIdx].rewardCoin
                    s.ledger.append(InnLedgerEntry(day: s.day, delta: s.quests[qIdx].rewardCoin, memo: "Quest: The First Guest"))
                }
            }

            // Achievement 24 - Full House
            if s.rooms.allSatisfy({ $0.occupiedByGuest != nil }) {
                unlock(&s, achievementId: 24)
            }
        } else {
            // No room — accept to bench (no room assigned)
            var ng = g
            ng.roomIndex = nil
            s.guests.append(ng)
            s.roster.removeAll { $0.id == g.id }
            s.eventLog.insert("Day \(s.day): accepted \(InnCatalog.archetype(g.archetypeId).name) — no room available.", at: 0)
        }
        state = s
        save()
    }

    func refuseGuest(_ g: InnGuest) {
        objectWillChange.send()
        var s = state
        s.roster.removeAll { $0.id == g.id }
        s.eventLog.insert("Day \(s.day): refused \(InnCatalog.archetype(g.archetypeId).name).", at: 0)
        // Small reputation hit to source settlement
        if let sIdx = s.settlements.firstIndex(where: {
            $0.primaryGuestArchetypeIds.contains(g.archetypeId)
        }) {
            s.settlements[sIdx].reputation = max(-50, s.settlements[sIdx].reputation - 2)
        }
        state = s
        save()
    }

    // MARK: - Serve meal (action-token guard, decrements stock, fills hunger)

    func serveMeal(to guest: InnGuest, itemId: Int) -> Bool {
        guard let item = InnCatalog.menuItem(itemId) else { return false }
        objectWillChange.send()
        var s = state
        // Action-token guard
        if s.todayActionToken <= 0 { state = s; save(); return false }
        // Stock check / decrement — we use a coarse mapping: stew/meat -> meat, bread -> bread, etc.
        if !consumeStockFor(item: item, in: &s) { state = s; save(); return false }
        // Token spent BEFORE state mutation completes externally — guarded above.
        s.todayActionToken -= 1
        s.coins += item.sellPrice
        s.lifetimeRevenue += item.sellPrice
        s.ledger.append(InnLedgerEntry(day: s.day, delta: item.sellPrice, memo: "\(item.name) → \(InnCatalog.archetype(guest.archetypeId).name)"))
        // Update guest needs
        if let idx = s.guests.firstIndex(where: { $0.id == guest.id }) {
            if item.kind == "food" {
                s.guests[idx].hunger = min(100, s.guests[idx].hunger + 30)
            } else {
                s.guests[idx].thirst = min(100, s.guests[idx].thirst + 30)
            }
            let bonus = (item.popularity[guest.archetypeId] ?? 0)
            s.guests[idx].happiness = min(100, s.guests[idx].happiness + 4 + bonus)
            s.guests[idx].chatLevel = min(5, s.guests[idx].chatLevel + 1)
        }
        s.flags["mealsServed", default: 0] += 1
        if (s.flags["mealsServed"] ?? 0) >= 25 { unlock(&s, achievementId: 8) }
        state = s
        save()
        return true
    }

    private func consumeStockFor(item: MenuItem, in s: inout InnGameState) -> Bool {
        // Very coarse mapping: each "food" deducts 1 across one bucket
        if item.kind == "food" {
            let n = item.name.lowercased()
            if n.contains("bread") || n.contains("oats") || n.contains("crow-bean") || n.contains("apple") {
                if s.foodStock.bread <= 0 { return false }
                s.foodStock.bread -= 1
            } else if n.contains("beef") || n.contains("lamb") || n.contains("liver") || n.contains("pork") {
                if s.foodStock.meat <= 0 { return false }
                s.foodStock.meat -= 1
            } else if n.contains("cheese") {
                if s.foodStock.cheese <= 0 { return false }
                s.foodStock.cheese -= 1
            } else if n.contains("fish") || n.contains("trout") {
                if s.foodStock.fish <= 0 { return false }
                s.foodStock.fish -= 1
            } else if n.contains("herb") {
                if s.foodStock.herbs <= 0 { return false }
                s.foodStock.herbs -= 1
            } else if n.contains("root") || n.contains("hash") {
                if s.foodStock.roots <= 0 { return false }
                s.foodStock.roots -= 1
            } else if n.contains("pie") || n.contains("tart") || n.contains("pottage") || n.contains("pudding") || n.contains("venison") {
                if s.foodStock.pies <= 0 { return false }
                s.foodStock.pies -= 1
            } else {
                if s.foodStock.bread <= 0 { return false }
                s.foodStock.bread -= 1
            }
        } else {
            let n = item.name.lowercased()
            if n.contains("strong ale") {
                if s.drinkStock.ale <= 0 { return false }
                s.drinkStock.ale -= 1
            } else if n.contains("ale") {
                if s.drinkStock.ale <= 0 { return false }
                s.drinkStock.ale -= 1
            } else if n.contains("wine") || n.contains("heatherwine") {
                if s.drinkStock.wine <= 0 { return false }
                s.drinkStock.wine -= 1
            } else if n.contains("mead") {
                if s.drinkStock.mead <= 0 { return false }
                s.drinkStock.mead -= 1
            } else if n.contains("cider") {
                if s.drinkStock.cider <= 0 { return false }
                s.drinkStock.cider -= 1
            } else if n.contains("brandy") {
                if s.drinkStock.brandy <= 0 { return false }
                s.drinkStock.brandy -= 1
            } else if n.contains("water") || n.contains("buttermilk") || n.contains("garlic") {
                if s.drinkStock.water <= 0 { return false }
                s.drinkStock.water -= 1
            } else {
                if s.drinkStock.ale <= 0 { return false }
                s.drinkStock.ale -= 1
            }
        }
        return true
    }

    func restockBread(amount: Int = 4, cost: Int = 8) {
        objectWillChange.send()
        var s = state
        if s.coins < cost { return }
        s.coins -= cost
        s.foodStock.bread += amount
        s.ledger.append(InnLedgerEntry(day: s.day, delta: -cost, memo: "Restocked bread × \(amount)"))
        state = s; save()
    }

    func restockMeat(amount: Int = 3, cost: Int = 12) {
        objectWillChange.send()
        var s = state
        if s.coins < cost { return }
        s.coins -= cost
        s.foodStock.meat += amount
        s.ledger.append(InnLedgerEntry(day: s.day, delta: -cost, memo: "Restocked meat × \(amount)"))
        state = s; save()
    }

    func restockGeneric(food: WritableKeyPath<InnFoodStock, Int>, amount: Int, cost: Int, memo: String) {
        objectWillChange.send()
        var s = state
        if s.coins < cost { return }
        s.coins -= cost
        s.foodStock[keyPath: food] += amount
        s.ledger.append(InnLedgerEntry(day: s.day, delta: -cost, memo: memo))
        state = s; save()
    }

    func restockDrink(_ kp: WritableKeyPath<InnDrinkStock, Int>, amount: Int, cost: Int, memo: String) {
        objectWillChange.send()
        var s = state
        if s.coins < cost { return }
        s.coins -= cost
        s.drinkStock[keyPath: kp] += amount
        s.ledger.append(InnLedgerEntry(day: s.day, delta: -cost, memo: memo))
        state = s; save()
    }

    // MARK: - Rumor capture

    func attemptCapture(guestId: UUID, action: ChatAction) -> (success: Bool, rumorId: Int?) {
        objectWillChange.send()
        var s = state
        guard let gIdx = s.guests.firstIndex(where: { $0.id == guestId }) else { return (false, nil) }
        let arch = InnCatalog.archetype(s.guests[gIdx].archetypeId)
        let hasBartender = s.staff.contains(where: { $0.role == .bartender })

        // Cost guard for pourMore (must have an ale to pour)
        if action == .pourMore {
            if s.drinkStock.ale > 0 {
                s.drinkStock.ale -= 1
            } else if s.drinkStock.cider > 0 {
                s.drinkStock.cider -= 1
            } else {
                state = s; save(); return (false, nil)
            }
        }

        let chance = InnEngine.rumorCaptureChance(archetype: arch, action: action,
                                                  hasBartender: hasBartender,
                                                  currentChat: s.guests[gIdx].chatLevel)
        // Deterministic per day/guest/action chain
        let salt = UInt64(s.guests[gIdx].chatLevel + 1) &* 17 &+ UInt64(action.rawValue.count)
        var rng = InnSeededRNG(seed: InnEngine.dailySeed(year: s.year, day: s.day, salt: salt) &+ UInt64(s.guests[gIdx].archetypeId))
        let roll = rng.roll(100)
        s.guests[gIdx].chatLevel = min(5, s.guests[gIdx].chatLevel + 1)
        if action == .pressGently {
            s.guests[gIdx].happiness = max(0, s.guests[gIdx].happiness - 4)
        }
        if action == .befriend {
            s.guests[gIdx].happiness = min(100, s.guests[gIdx].happiness + 4)
        }

        if roll < chance {
            let excluded = s.guests[gIdx].dropped + s.capturedRumors.map { $0.rumorId }
            if let rid = InnEngine.pickRumorForArchetype(year: s.year, day: s.day,
                                                        slot: roll,
                                                        archetype: arch,
                                                        excludedIds: excluded),
               let rumor = InnCatalog.rumor(rid) {
                s.guests[gIdx].dropped.append(rid)
                // Add or corroborate
                if let cIdx = s.capturedRumors.firstIndex(where: { $0.rumorId == rid }) {
                    s.capturedRumors[cIdx].corroborationCount += 1
                    if !s.capturedRumors[cIdx].sourceArchetypeIds.contains(arch.id) {
                        s.capturedRumors[cIdx].sourceArchetypeIds.append(arch.id)
                    }
                    if s.capturedRumors[cIdx].corroborationCount >= 2 {
                        s.capturedRumors[cIdx].discoveredTruth = rumor.actualTruth
                    }
                    if s.capturedRumors[cIdx].corroborationCount >= 3 {
                        unlock(&s, achievementId: 32)
                    }
                } else {
                    let cap = CapturedRumor(id: UUID(), rumorId: rid,
                                            category: rumor.category, tier: rumor.tier,
                                            corroborationCount: 1,
                                            sourceArchetypeIds: [arch.id],
                                            discoveredTruth: .unknown,
                                            dayCaught: s.day,
                                            soldTo: nil,
                                            notes: "")
                    s.capturedRumors.append(cap)
                    // Quest 5 - first rumor
                    if let qIdx = s.quests.firstIndex(where: { $0.id == 5 }), !s.quests[qIdx].completed {
                        s.quests[qIdx].completed = true
                        s.coins += s.quests[qIdx].rewardCoin
                        s.ledger.append(InnLedgerEntry(day: s.day, delta: s.quests[qIdx].rewardCoin, memo: "Quest: A Whisper Heard"))
                    }
                }
                // Advance arc tag count
                if let arc = rumor.arcAffinity, let aIdx = s.arcs.firstIndex(where: { $0.kind == arc }) {
                    s.arcs[aIdx].rumorTagCount += 1
                    let thresholds = arc.milestoneThresholds
                    if s.arcs[aIdx].milestonesUnlocked < thresholds.count {
                        let nextT = thresholds[s.arcs[aIdx].milestonesUnlocked]
                        if s.arcs[aIdx].rumorTagCount >= nextT {
                            s.arcs[aIdx].milestonesUnlocked += 1
                            s.eventLog.insert("Day \(s.day): \(arc.label) — milestone \(s.arcs[aIdx].milestonesUnlocked) unlocked.", at: 0)
                        }
                    }
                }
                // Rumor count achievements
                if s.capturedRumors.count >= 20 { unlock(&s, achievementId: 11) }
                if s.capturedRumors.count >= 50 { unlock(&s, achievementId: 12) }
                state = s; save()
                return (true, rid)
            }
        }
        state = s; save()
        return (false, nil)
    }

    // MARK: - Sell rumor

    func sellRumor(capturedId: UUID, to buyer: BuyerKind) -> Int {
        objectWillChange.send()
        var s = state
        guard let cIdx = s.capturedRumors.firstIndex(where: { $0.id == capturedId }) else { return 0 }
        if s.capturedRumors[cIdx].soldTo != nil { return 0 }
        // Token guard: in shop, action token is not the per-day chat token; we use a separate flag flag
        // for "sold today" max. For simplicity, allow N per day = 3.
        let soldToday = s.flags["soldToday-\(s.day)"] ?? 0
        if soldToday >= 3 { return 0 }
        let price = InnEngine.priceForBuyer(buyer, rumor: s.capturedRumors[cIdx], lifetimeRevenue: s.lifetimeRevenue)
        // Token spent BEFORE mutation completes
        s.flags["soldToday-\(s.day)"] = soldToday + 1
        s.coins += price
        s.lifetimeRevenue += price
        s.rumorsSold += 1
        s.capturedRumors[cIdx].soldTo = buyer.label
        s.ledger.append(InnLedgerEntry(day: s.day, delta: price, memo: "Sold \(s.capturedRumors[cIdx].tier.label) to \(buyer.label)"))
        if s.rumorsSold >= 10 { unlock(&s, achievementId: 13) }
        if s.rumorsSold >= 50 { unlock(&s, achievementId: 14) }
        if s.rumorsSold >= 1 {
            if let qIdx = s.quests.firstIndex(where: { $0.id == 6 }), !s.quests[qIdx].completed {
                s.quests[qIdx].completed = true
                s.coins += s.quests[qIdx].rewardCoin
                s.ledger.append(InnLedgerEntry(day: s.day, delta: s.quests[qIdx].rewardCoin, memo: "Quest: Bargain Struck"))
            }
        }
        state = s; save()
        return price
    }

    // MARK: - Room upgrade

    func upgradeRoom(roomId: Int) {
        objectWillChange.send()
        var s = state
        guard let idx = s.rooms.firstIndex(where: { $0.id == roomId }) else { return }
        let cost = s.rooms[idx].tier.upgradeCost
        if cost == 0 || s.coins < cost { return }
        s.coins -= cost
        let nextRaw = s.rooms[idx].tier.rawValue + 1
        if let nextTier = RoomTier(rawValue: nextRaw) {
            s.rooms[idx].tier = nextTier
            s.ledger.append(InnLedgerEntry(day: s.day, delta: -cost, memo: "Upgraded room \(idx + 1) to \(nextTier.label)"))
            if nextTier == .featherbed {
                if let qIdx = s.quests.firstIndex(where: { $0.id == 12 }), !s.quests[qIdx].completed {
                    s.quests[qIdx].completed = true
                    s.coins += s.quests[qIdx].rewardCoin
                    s.ledger.append(InnLedgerEntry(day: s.day, delta: s.quests[qIdx].rewardCoin, memo: "Quest: Featherbed"))
                }
            }
        }
        state = s; save()
    }

    func upgradeTable(tableId: Int) {
        objectWillChange.send()
        var s = state
        guard let idx = s.tables.firstIndex(where: { $0.id == tableId }) else { return }
        let cost = s.tables[idx].tier.upgradeCost
        if cost == 0 || s.coins < cost { return }
        s.coins -= cost
        let nextRaw = s.tables[idx].tier.rawValue + 1
        if let nextTier = TableTier(rawValue: nextRaw) {
            s.tables[idx].tier = nextTier
            s.ledger.append(InnLedgerEntry(day: s.day, delta: -cost, memo: "Upgraded table \(idx + 1) to \(nextTier.label)"))
            if let qIdx = s.quests.firstIndex(where: { $0.id == 11 }), !s.quests[qIdx].completed {
                s.quests[qIdx].completed = true
                s.coins += s.quests[qIdx].rewardCoin
                s.ledger.append(InnLedgerEntry(day: s.day, delta: s.quests[qIdx].rewardCoin, memo: "Quest: A Better Bar"))
            }
        }
        state = s; save()
    }

    // MARK: - Hire / fire

    func hireStaff(role: StaffRole) {
        objectWillChange.send()
        var s = state
        let hireFee = role.weeklyWage  // signing fee equal to a week's wage
        if s.coins < hireFee { return }
        s.coins -= hireFee
        let first = InnCatalog.staffFirstNames.randomElement() ?? "Alric"
        let sur = InnCatalog.staffSurnames.randomElement() ?? "of the Hollow"
        let m = StaffMember(id: UUID(), role: role, name: "\(first) \(sur)")
        s.staff.append(m)
        s.ledger.append(InnLedgerEntry(day: s.day, delta: -hireFee, memo: "Hired \(role.label) (signing)"))
        s.eventLog.insert("Day \(s.day): hired a \(role.label).", at: 0)
        // Quest flags
        switch role {
        case .maid:        completeQuest(&s, id: 8)
        case .stableboy:   completeQuest(&s, id: 9)
        case .bouncer:     completeQuest(&s, id: 21)
        case .bardForHire: completeQuest(&s, id: 22)
        case .letterCarrier: completeQuest(&s, id: 23)
        case .lookout:     completeQuest(&s, id: 24)
        default: break
        }
        state = s; save()
    }

    func dismissStaff(staffId: UUID) {
        objectWillChange.send()
        var s = state
        s.staff.removeAll { $0.id == staffId }
        s.eventLog.insert("Day \(s.day): dismissed a staff member.", at: 0)
        state = s; save()
    }

    private func completeQuest(_ s: inout InnGameState, id: Int) {
        guard let qIdx = s.quests.firstIndex(where: { $0.id == id }), !s.quests[qIdx].completed else { return }
        s.quests[qIdx].completed = true
        s.coins += s.quests[qIdx].rewardCoin
        s.ledger.append(InnLedgerEntry(day: s.day, delta: s.quests[qIdx].rewardCoin, memo: "Quest: \(s.quests[qIdx].title)"))
    }

    // MARK: - Menu

    func toggleMenuItem(_ itemId: Int) {
        objectWillChange.send()
        var s = state
        if s.menu.contains(itemId) {
            s.menu.removeAll { $0 == itemId }
        } else if s.menu.count < 6 {
            s.menu.append(itemId)
            if itemId == 1 { completeQuest(&s, id: 2) } // First Stew quest
        }
        state = s; save()
    }

    // MARK: - Upgrades

    func purchaseUpgrade(_ upg: InnUpgrade) {
        objectWillChange.send()
        var s = state
        if s.unlockedUpgradeIds.contains(upg.id) { return }
        if s.lifetimeRevenue < upg.prereqRevenue { return }
        if s.coins < upg.cost { return }
        s.coins -= upg.cost
        s.unlockedUpgradeIds.append(upg.id)
        s.ledger.append(InnLedgerEntry(day: s.day, delta: -upg.cost, memo: "Upgrade: \(upg.name)"))
        s.eventLog.insert("Day \(s.day): purchased upgrade — \(upg.name).", at: 0)
        if upg.id == 6 { completeQuest(&s, id: 14) }
        if upg.id == 2 { completeQuest(&s, id: 13) }
        if upg.id == 20 {
            completeQuest(&s, id: 25)
            unlock(&s, achievementId: 31)
        }
        state = s; save()
    }

    // MARK: - Event resolution

    func resolveEvent(option idx: Int) {
        objectWillChange.send()
        var s = state
        guard let pending = s.pendingEvent,
              let event = InnCatalog.events.first(where: { $0.id == pending.eventId }),
              idx >= 0 && idx < event.options.count else { return }
        let opt = event.options[idx]
        s.coins += opt.coinDelta
        if opt.coinDelta != 0 {
            s.ledger.append(InnLedgerEntry(day: s.day, delta: opt.coinDelta, memo: "Event: \(event.title)"))
            if opt.coinDelta > 0 { s.lifetimeRevenue += opt.coinDelta }
        }
        for (sid, delta) in opt.reputationDelta {
            if let sIdx = s.settlements.firstIndex(where: { $0.id == sid }) {
                s.settlements[sIdx].reputation = max(-50, min(100, s.settlements[sIdx].reputation + delta))
            }
        }
        if let rid = opt.rumorIdReward, let rumor = InnCatalog.rumor(rid) {
            if !s.capturedRumors.contains(where: { $0.rumorId == rid }) {
                let cap = CapturedRumor(id: UUID(), rumorId: rid,
                                        category: rumor.category, tier: rumor.tier,
                                        corroborationCount: 1, sourceArchetypeIds: [],
                                        discoveredTruth: .unknown,
                                        dayCaught: s.day, soldTo: nil, notes: "Event")
                s.capturedRumors.append(cap)
                if let arc = rumor.arcAffinity, let aIdx = s.arcs.firstIndex(where: { $0.kind == arc }) {
                    s.arcs[aIdx].rumorTagCount += 1
                }
            }
        }
        if let f = opt.setFlag { s.flags[f, default: 0] += 1 }
        s.eventLog.insert("Day \(s.day): \(event.title) — \(opt.consequence)", at: 0)
        // Specific flag achievement
        if s.flags["refusedScoutBribe"] != nil { unlock(&s, achievementId: 17) }
        if s.flags["savedFromBounty"] != nil { unlock(&s, achievementId: 29) }
        s.pendingEvent = nil
        state = s; save()
    }

    // MARK: - Arc decisions

    func resolveArc(_ arc: ArcKind, kind: ArcEndingKind) {
        objectWillChange.send()
        var s = state
        guard let idx = s.arcs.firstIndex(where: { $0.kind == arc }) else { return }
        if s.arcs[idx].resolved { return }
        s.arcs[idx].resolved = true
        s.arcs[idx].endingKind = kind
        s.arcs[idx].endingText = InnCatalog.endingText(for: arc, kind: kind)
        s.eventLog.insert("Day \(s.day): \(arc.label) resolved — \(kind.label).", at: 0)
        // Reward
        if kind == .success {
            let reward = 80
            s.coins += reward
            s.lifetimeRevenue += reward
            s.ledger.append(InnLedgerEntry(day: s.day, delta: reward, memo: "Arc resolved: \(arc.label)"))
            switch arc {
            case .lordsBastard:     unlock(&s, achievementId: 18)
            case .smugglersMap:     unlock(&s, achievementId: 19)
            case .mendicantProphet: unlock(&s, achievementId: 20)
            case .northernRoadWar:  unlock(&s, achievementId: 21)
            case .wolfwoodBeast:    unlock(&s, achievementId: 22)
            }
            completeQuest(&s, id: 26)
        }
        state = s; save()
    }
}
