import Foundation
import SwiftUI

// MARK: - Enums

enum InnWeather: String, Codable, CaseIterable {
    case clear, overcast, drizzle, rain, fog, snow, blizzard, gale

    var label: String {
        switch self {
        case .clear: return "Clear Sky"
        case .overcast: return "Overcast"
        case .drizzle: return "Light Drizzle"
        case .rain: return "Heavy Rain"
        case .fog: return "Thick Fog"
        case .snow: return "Snowfall"
        case .blizzard: return "Blizzard"
        case .gale: return "Howling Gale"
        }
    }

    var trafficMultiplier: Double {
        switch self {
        case .clear: return 1.2
        case .overcast: return 1.0
        case .drizzle: return 0.95
        case .rain: return 0.80
        case .fog: return 0.85
        case .snow: return 0.75
        case .blizzard: return 0.40
        case .gale: return 0.55
        }
    }
}

enum RumorCategory: String, Codable, CaseIterable {
    case political, trade, personal, mystical, criminal, local
    var label: String {
        switch self {
        case .political: return "Political"
        case .trade: return "Trade"
        case .personal: return "Personal"
        case .mystical: return "Mystical"
        case .criminal: return "Criminal"
        case .local: return "Local"
        }
    }
    var swatch: Color {
        switch self {
        case .political: return InnTheme.emberRed.opacity(0.30)
        case .trade: return InnTheme.hearthGold.opacity(0.32)
        case .personal: return InnTheme.mossyStone.opacity(0.32)
        case .mystical: return Color(red: 0.50, green: 0.40, blue: 0.62).opacity(0.30)
        case .criminal: return InnTheme.oakBrownDark.opacity(0.30)
        case .local: return InnTheme.mossyStoneSoft.opacity(0.38)
        }
    }
}

enum RumorTier: String, Codable, CaseIterable {
    case whisper, hearsay, fact
    var label: String {
        switch self {
        case .whisper: return "Whisper"
        case .hearsay: return "Hearsay"
        case .fact: return "Fact"
        }
    }
    var basePrice: Int {
        switch self {
        case .whisper: return 6
        case .hearsay: return 14
        case .fact: return 32
        }
    }
}

enum RumorTruth: String, Codable {
    case unknown, falseRumor, partial, trueRumor
    var label: String {
        switch self {
        case .unknown: return "Uncorroborated"
        case .falseRumor: return "False"
        case .partial: return "Partial"
        case .trueRumor: return "True"
        }
    }
}

enum RoomTier: Int, Codable, CaseIterable {
    case cot = 0, bed = 1, featherbed = 2, suite = 3
    var label: String {
        switch self {
        case .cot: return "Cot"
        case .bed: return "Bed"
        case .featherbed: return "Featherbed"
        case .suite: return "Suite"
        }
    }
    var nightlyRate: Int {
        switch self {
        case .cot: return 4
        case .bed: return 10
        case .featherbed: return 22
        case .suite: return 48
        }
    }
    var upgradeCost: Int {
        switch self {
        case .cot: return 60
        case .bed: return 140
        case .featherbed: return 320
        case .suite: return 0
        }
    }
    var happinessBase: Int {
        switch self {
        case .cot: return 35
        case .bed: return 55
        case .featherbed: return 75
        case .suite: return 92
        }
    }
}

enum TableTier: Int, Codable, CaseIterable {
    case plain = 0, polished = 1, carved = 2, velvet = 3
    var label: String {
        switch self {
        case .plain: return "Plain"
        case .polished: return "Polished"
        case .carved: return "Carved"
        case .velvet: return "Velvet"
        }
    }
    var moodBonus: Int { rawValue * 5 }
    var upgradeCost: Int {
        switch self {
        case .plain: return 40
        case .polished: return 110
        case .carved: return 240
        case .velvet: return 0
        }
    }
}

enum BuyerKind: String, Codable, CaseIterable {
    case marshal, spyHandler, courtHerald, undergroundBroker, chronicler, foreignEmbassy

    var label: String {
        switch self {
        case .marshal: return "The Marshal"
        case .spyHandler: return "Spy Network Handler"
        case .courtHerald: return "Court Herald"
        case .undergroundBroker: return "Underground Broker"
        case .chronicler: return "Itinerant Chronicler"
        case .foreignEmbassy: return "Foreign Embassy"
        }
    }

    var preferredCategories: [RumorCategory] {
        switch self {
        case .marshal: return [.criminal, .political]
        case .spyHandler: return [.political, .trade]
        case .courtHerald: return [.personal, .political]
        case .undergroundBroker: return [.criminal, .trade]
        case .chronicler: return [.local, .mystical, .personal]
        case .foreignEmbassy: return [.political, .trade, .mystical]
        }
    }

    var priceMultiplier: Double {
        switch self {
        case .marshal: return 1.1
        case .spyHandler: return 1.4
        case .courtHerald: return 1.15
        case .undergroundBroker: return 1.5
        case .chronicler: return 0.85
        case .foreignEmbassy: return 1.6
        }
    }
}

enum ArcKind: String, Codable, CaseIterable {
    case lordsBastard, smugglersMap, mendicantProphet, northernRoadWar, wolfwoodBeast

    var label: String {
        switch self {
        case .lordsBastard: return "The Lord's Bastard"
        case .smugglersMap: return "Smuggler's Map"
        case .mendicantProphet: return "The Mendicant Prophet"
        case .northernRoadWar: return "The Northern Road War"
        case .wolfwoodBeast: return "The Wolfwood Beast"
        }
    }

    var blurb: String {
        switch self {
        case .lordsBastard: return "A missing heir is hidden somewhere in the region. Personal and political whispers point the way."
        case .smugglersMap: return "Pieces of a treasure map drift among visiting outlaws and merchants."
        case .mendicantProphet: return "A wandering preacher gathers followers — and may unseat the local lord."
        case .northernRoadWar: return "Two duchies tighten their grip. The road grows tense, the tolls strange."
        case .wolfwoodBeast: return "Something stalks the Wolfwood. Hunters arrive nightly with new theories."
        }
    }

    var relevantCategories: [RumorCategory] {
        switch self {
        case .lordsBastard: return [.personal, .political]
        case .smugglersMap: return [.trade, .criminal]
        case .mendicantProphet: return [.mystical, .personal]
        case .northernRoadWar: return [.political, .trade]
        case .wolfwoodBeast: return [.mystical, .local]
        }
    }

    var milestoneThresholds: [Int] { [4, 9, 16] }
    var deadlineDay: Int { 90 }
}

enum ArcEndingKind: String, Codable {
    case success, partial, failure
    var label: String {
        switch self {
        case .success: return "Resolution"
        case .partial: return "Partial Outcome"
        case .failure: return "Lost Thread"
        }
    }
}

enum StaffRole: String, Codable, CaseIterable {
    case bartender, cook, maid, stableboy, bouncer, bardForHire, lookout, letterCarrier

    var label: String {
        switch self {
        case .bartender: return "Bartender"
        case .cook: return "Cook"
        case .maid: return "Maid"
        case .stableboy: return "Stableboy"
        case .bouncer: return "Bouncer"
        case .bardForHire: return "Bard for Hire"
        case .lookout: return "Lookout"
        case .letterCarrier: return "Letter Carrier"
        }
    }

    var weeklyWage: Int {
        switch self {
        case .bartender: return 18
        case .cook: return 24
        case .maid: return 14
        case .stableboy: return 12
        case .bouncer: return 22
        case .bardForHire: return 26
        case .lookout: return 20
        case .letterCarrier: return 16
        }
    }

    var ability: String {
        switch self {
        case .bartender: return "Loosens tongues — +12% rumor capture on Pour More."
        case .cook: return "Sharpens recipes — meals satisfy 15% more hunger."
        case .maid: return "Tidy rooms — +8 happiness for all guests staying overnight."
        case .stableboy: return "Quick stalls — couriers and royal scouts stay one extra day."
        case .bouncer: return "Cools brawls — events of conflict type easier to defuse."
        case .bardForHire: return "Draws crowds — +1 guest in the daily roster."
        case .lookout: return "Spots trouble — events previewed with one extra clue."
        case .letterCarrier: return "Carries news — +1 corroboration source per rumor sold."
        }
    }
}

// MARK: - Codable structs

struct InnArchetype: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let title: String           // shown under name
    let temperament: Int        // 1-10  (low = mild, high = volatile)
    let generosity: Int         // 1-10
    let gossipLevel: Int        // 1-10
    let suspicion: Int          // 1-10
    let favoriteFood: String
    let favoriteDrink: String
    let preferredRoom: RoomTier
    let rumorTags: [RumorCategory]
    let cloakHue: Int           // 0-359 for portrait variation
    let hatStyle: Int           // 0-4
}

struct InnRumor: Codable, Identifiable, Hashable {
    let id: Int
    let summary: String
    let category: RumorCategory
    let tier: RumorTier
    let actualTruth: RumorTruth   // discovered through corroboration
    let arcAffinity: ArcKind?     // nil for incidental rumors
}

struct CapturedRumor: Codable, Identifiable, Hashable {
    var id: UUID
    let rumorId: Int
    let category: RumorCategory
    let tier: RumorTier
    var corroborationCount: Int
    var sourceArchetypeIds: [Int]
    var discoveredTruth: RumorTruth
    let dayCaught: Int
    var soldTo: String?
    var notes: String
}

struct InnGuest: Codable, Identifiable, Hashable {
    var id: UUID
    let archetypeId: Int
    var hunger: Int = 70
    var thirst: Int = 70
    var sleep: Int = 70
    var chatLevel: Int = 0
    var happiness: Int = 60
    var roomIndex: Int? = nil
    var dayArrived: Int
    var nightsRemaining: Int
    var dropped: [Int] = []     // rumor ids already dropped to player
    var hasPaid: Bool = false
    var refused: Bool = false
}

struct InnRoom: Codable, Identifiable, Hashable {
    let id: Int
    var tier: RoomTier
    var occupiedByGuest: UUID?
}

struct InnTable: Codable, Identifiable, Hashable {
    let id: Int
    var tier: TableTier
}

struct MenuItem: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let kind: String           // "food" | "drink"
    let costToMake: Int
    let sellPrice: Int
    let popularity: [Int: Int] // archetypeId -> bonus 0..5
}

struct Settlement: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let blurb: String
    var reputation: Int        // -50 ... 100
    let primaryGuestArchetypeIds: [Int]
    let dangerFactor: Int      // affects suspicion/criminal traffic
}

struct InnEventOption: Codable, Hashable {
    let label: String
    let consequence: String
    let coinDelta: Int
    let reputationDelta: [Int: Int]   // settlement id -> delta
    let rumorIdReward: Int?           // optional rumor to add to captured ledger
    let setFlag: String?
}

struct InnEvent: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let body: String
    let category: String          // "weather"|"social"|"trade"|"danger"|"royal"
    let options: [InnEventOption]
    let weight: Int
}

struct InnUpgrade: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let blurb: String
    let cost: Int
    let prereqRevenue: Int        // lifetime revenue gate
}

struct InnAchievement: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let blurb: String
    var unlocked: Bool = false
}

struct InnQuest: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let body: String
    let rewardCoin: Int
    let prereqLifetimeRevenue: Int
    var completed: Bool = false
}

struct StaffMember: Codable, Identifiable, Hashable {
    var id: UUID
    let role: StaffRole
    let name: String
    var weeksEmployed: Int = 0
}

struct InnFoodStock: Codable, Hashable {
    var bread: Int = 6
    var meat: Int = 4
    var cheese: Int = 3
    var fish: Int = 2
    var herbs: Int = 3
    var roots: Int = 5
    var fruit: Int = 2
    var pies: Int = 1
}

struct InnDrinkStock: Codable, Hashable {
    var ale: Int = 8
    var wine: Int = 4
    var mead: Int = 3
    var cider: Int = 4
    var brandy: Int = 1
    var water: Int = 12
}

struct InnExtras: Codable, Hashable {
    var firewood: Int = 6
    var salt: Int = 4
    var candles: Int = 5
}

struct ArcProgress: Codable, Hashable {
    var kind: ArcKind
    var rumorTagCount: Int = 0
    var milestonesUnlocked: Int = 0
    var resolved: Bool = false
    var endingKind: ArcEndingKind? = nil
    var endingText: String = ""
    var choicesMade: [String] = []
}

struct ActiveEventState: Codable, Hashable {
    let eventId: Int
    var resolved: Bool = false
    var optionPicked: Int? = nil
}

struct InnLedgerEntry: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    let day: Int
    let delta: Int
    let memo: String
}

// MARK: - Top-level state

struct InnGameState: Codable {
    var version: Int = 1
    var day: Int = 1
    var year: Int = 1
    var weather: InnWeather = .clear
    var coins: Int = 80
    var foodStock: InnFoodStock = InnFoodStock()
    var drinkStock: InnDrinkStock = InnDrinkStock()
    var extras: InnExtras = InnExtras()
    var rooms: [InnRoom] = []
    var tables: [InnTable] = []
    var menu: [Int] = []                 // menu item ids active today (<=6)
    var staff: [StaffMember] = []
    var guests: [InnGuest] = []
    var roster: [InnGuest] = []          // today's arriving (not yet accepted)
    var capturedRumors: [CapturedRumor] = []
    var settlements: [Settlement] = []
    var arcs: [ArcProgress] = []
    var unlockedUpgradeIds: [Int] = []
    var achievements: [InnAchievement] = []
    var quests: [InnQuest] = []
    var pendingEvent: ActiveEventState? = nil
    var eventLog: [String] = []
    var ledger: [InnLedgerEntry] = []
    var lifetimeRevenue: Int = 0
    var rumorsSold: Int = 0
    var prestigeTier: Int = 0
    var flags: [String: Int] = [:]       // generic counters / booleans
    var buyerInterestSeed: Int = 0
    var todayActionToken: Int = 1        // resets each day, prevents double-spend
}
