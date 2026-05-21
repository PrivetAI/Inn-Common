import Foundation

enum InnCatalog {

    // MARK: - 40 Archetypes
    static let archetypes: [InnArchetype] = [
        InnArchetype(id: 1,  name: "Wandering Bard",      title: "Ballads-for-Bread",
                     temperament: 4, generosity: 6, gossipLevel: 9, suspicion: 2,
                     favoriteFood: "Cheese Plate", favoriteDrink: "Mulled Wine",
                     preferredRoom: .bed, rumorTags: [.personal, .political, .local], cloakHue: 285, hatStyle: 1),
        InnArchetype(id: 2,  name: "Caravan Merchant",    title: "Silk Road Trader",
                     temperament: 3, generosity: 5, gossipLevel: 7, suspicion: 4,
                     favoriteFood: "Roast Lamb", favoriteDrink: "Spiced Cider",
                     preferredRoom: .featherbed, rumorTags: [.trade, .local], cloakHue: 30, hatStyle: 2),
        InnArchetype(id: 3,  name: "Hardened Mercenary",  title: "Two-Coin Captain",
                     temperament: 8, generosity: 3, gossipLevel: 4, suspicion: 7,
                     favoriteFood: "Beef Stew", favoriteDrink: "Strong Ale",
                     preferredRoom: .bed, rumorTags: [.criminal, .political], cloakHue: 0, hatStyle: 3),
        InnArchetype(id: 4,  name: "Reverent Pilgrim",    title: "Long-Robed",
                     temperament: 2, generosity: 7, gossipLevel: 5, suspicion: 3,
                     favoriteFood: "Bread & Butter", favoriteDrink: "Water",
                     preferredRoom: .cot, rumorTags: [.mystical, .local], cloakHue: 60, hatStyle: 0),
        InnArchetype(id: 5,  name: "Veiled Spy",          title: "Quiet at the End Table",
                     temperament: 5, generosity: 5, gossipLevel: 8, suspicion: 9,
                     favoriteFood: "Soft Cheese", favoriteDrink: "Brandy",
                     preferredRoom: .featherbed, rumorTags: [.political, .criminal, .trade], cloakHue: 240, hatStyle: 4),
        InnArchetype(id: 6,  name: "Woodland Hunter",     title: "Bow-and-Tally",
                     temperament: 4, generosity: 5, gossipLevel: 6, suspicion: 4,
                     favoriteFood: "Venison Pie", favoriteDrink: "Cider",
                     preferredRoom: .bed, rumorTags: [.mystical, .local], cloakHue: 110, hatStyle: 1),
        InnArchetype(id: 7,  name: "Royal Courier",       title: "Sealed-Sleeve",
                     temperament: 3, generosity: 4, gossipLevel: 7, suspicion: 6,
                     favoriteFood: "Roast Capon", favoriteDrink: "Wine",
                     preferredRoom: .featherbed, rumorTags: [.political, .trade], cloakHue: 220, hatStyle: 2),
        InnArchetype(id: 8,  name: "Cloistered Monk",     title: "Of the Inkwell",
                     temperament: 1, generosity: 8, gossipLevel: 7, suspicion: 2,
                     favoriteFood: "Honeyed Oats", favoriteDrink: "Water",
                     preferredRoom: .cot, rumorTags: [.mystical, .personal, .local], cloakHue: 25, hatStyle: 0),
        InnArchetype(id: 9,  name: "Royal Scout",         title: "Eyes of the Crown",
                     temperament: 4, generosity: 4, gossipLevel: 6, suspicion: 8,
                     favoriteFood: "Roast Lamb", favoriteDrink: "Brandy",
                     preferredRoom: .suite, rumorTags: [.political, .trade], cloakHue: 210, hatStyle: 3),
        InnArchetype(id: 10, name: "Drifting Sellsword",  title: "Cheap Steel",
                     temperament: 7, generosity: 2, gossipLevel: 5, suspicion: 6,
                     favoriteFood: "Stew", favoriteDrink: "Ale",
                     preferredRoom: .cot, rumorTags: [.criminal, .local], cloakHue: 350, hatStyle: 1),
        InnArchetype(id: 11, name: "Map Cartographer",    title: "Compass and Quill",
                     temperament: 2, generosity: 6, gossipLevel: 6, suspicion: 3,
                     favoriteFood: "Soft Cheese", favoriteDrink: "Cider",
                     preferredRoom: .bed, rumorTags: [.trade, .local, .mystical], cloakHue: 200, hatStyle: 2),
        InnArchetype(id: 12, name: "Tavern-Sour Lord",    title: "Down on Coin",
                     temperament: 6, generosity: 7, gossipLevel: 8, suspicion: 3,
                     favoriteFood: "Roast Capon", favoriteDrink: "Mulled Wine",
                     preferredRoom: .featherbed, rumorTags: [.political, .personal], cloakHue: 320, hatStyle: 3),
        InnArchetype(id: 13, name: "Folk Healer",         title: "Of Herbs and Knots",
                     temperament: 3, generosity: 6, gossipLevel: 7, suspicion: 3,
                     favoriteFood: "Herb Soup", favoriteDrink: "Mead",
                     preferredRoom: .cot, rumorTags: [.mystical, .personal, .local], cloakHue: 95, hatStyle: 0),
        InnArchetype(id: 14, name: "River Bargeman",      title: "Tideborn",
                     temperament: 5, generosity: 5, gossipLevel: 6, suspicion: 3,
                     favoriteFood: "Pickled Fish", favoriteDrink: "Ale",
                     preferredRoom: .cot, rumorTags: [.trade, .local], cloakHue: 195, hatStyle: 1),
        InnArchetype(id: 15, name: "Town Crier",          title: "Bell-Tongued",
                     temperament: 4, generosity: 4, gossipLevel: 9, suspicion: 2,
                     favoriteFood: "Pie", favoriteDrink: "Cider",
                     preferredRoom: .bed, rumorTags: [.local, .political, .personal], cloakHue: 10, hatStyle: 4),
        InnArchetype(id: 16, name: "Coin-Counting Clerk", title: "Of the Counting House",
                     temperament: 2, generosity: 3, gossipLevel: 5, suspicion: 5,
                     favoriteFood: "Bread & Butter", favoriteDrink: "Wine",
                     preferredRoom: .featherbed, rumorTags: [.trade, .political], cloakHue: 235, hatStyle: 2),
        InnArchetype(id: 17, name: "Highway Bandit",      title: "Hood Down",
                     temperament: 8, generosity: 4, gossipLevel: 5, suspicion: 8,
                     favoriteFood: "Stew", favoriteDrink: "Strong Ale",
                     preferredRoom: .cot, rumorTags: [.criminal, .trade], cloakHue: 0, hatStyle: 3),
        InnArchetype(id: 18, name: "Inn-Bound Astronomer",title: "Star-Eyed",
                     temperament: 2, generosity: 5, gossipLevel: 6, suspicion: 3,
                     favoriteFood: "Honeyed Oats", favoriteDrink: "Brandy",
                     preferredRoom: .featherbed, rumorTags: [.mystical, .personal], cloakHue: 250, hatStyle: 4),
        InnArchetype(id: 19, name: "Beleaguered Bailiff", title: "Of the Borough",
                     temperament: 5, generosity: 3, gossipLevel: 6, suspicion: 6,
                     favoriteFood: "Roast Lamb", favoriteDrink: "Wine",
                     preferredRoom: .featherbed, rumorTags: [.criminal, .political, .local], cloakHue: 220, hatStyle: 2),
        InnArchetype(id: 20, name: "Wayfaring Tinker",    title: "Of Pots and Notes",
                     temperament: 3, generosity: 5, gossipLevel: 7, suspicion: 3,
                     favoriteFood: "Cheese Plate", favoriteDrink: "Cider",
                     preferredRoom: .cot, rumorTags: [.trade, .local, .personal], cloakHue: 80, hatStyle: 1),
        InnArchetype(id: 21, name: "Itinerant Friar",     title: "Bell-and-Bowl",
                     temperament: 2, generosity: 7, gossipLevel: 6, suspicion: 2,
                     favoriteFood: "Bread & Butter", favoriteDrink: "Mead",
                     preferredRoom: .cot, rumorTags: [.mystical, .local], cloakHue: 40, hatStyle: 0),
        InnArchetype(id: 22, name: "Wolf-Hunter",         title: "Of the Northern Trail",
                     temperament: 6, generosity: 4, gossipLevel: 5, suspicion: 5,
                     favoriteFood: "Venison Pie", favoriteDrink: "Strong Ale",
                     preferredRoom: .bed, rumorTags: [.mystical, .local], cloakHue: 15, hatStyle: 3),
        InnArchetype(id: 23, name: "Mournful Widow",      title: "Black-Veiled",
                     temperament: 4, generosity: 6, gossipLevel: 6, suspicion: 3,
                     favoriteFood: "Pie", favoriteDrink: "Mulled Wine",
                     preferredRoom: .featherbed, rumorTags: [.personal, .local], cloakHue: 275, hatStyle: 4),
        InnArchetype(id: 24, name: "Apothecary",          title: "Of the Tincture Trade",
                     temperament: 3, generosity: 5, gossipLevel: 7, suspicion: 4,
                     favoriteFood: "Herb Soup", favoriteDrink: "Brandy",
                     preferredRoom: .bed, rumorTags: [.mystical, .trade], cloakHue: 130, hatStyle: 2),
        InnArchetype(id: 25, name: "Tax-Sworn Reeve",     title: "Of the Tally Stick",
                     temperament: 4, generosity: 2, gossipLevel: 5, suspicion: 7,
                     favoriteFood: "Roast Capon", favoriteDrink: "Wine",
                     preferredRoom: .featherbed, rumorTags: [.political, .trade], cloakHue: 215, hatStyle: 2),
        InnArchetype(id: 26, name: "Soft-Spoken Heretic", title: "Whispers Forbidden Verses",
                     temperament: 3, generosity: 4, gossipLevel: 8, suspicion: 6,
                     favoriteFood: "Bread & Butter", favoriteDrink: "Mead",
                     preferredRoom: .cot, rumorTags: [.mystical, .political], cloakHue: 290, hatStyle: 0),
        InnArchetype(id: 27, name: "Wandering Smith",     title: "Of the Roaming Forge",
                     temperament: 5, generosity: 5, gossipLevel: 5, suspicion: 3,
                     favoriteFood: "Beef Stew", favoriteDrink: "Strong Ale",
                     preferredRoom: .bed, rumorTags: [.trade, .local], cloakHue: 20, hatStyle: 1),
        InnArchetype(id: 28, name: "Coin-Shaver",         title: "Forger's Apprentice",
                     temperament: 4, generosity: 3, gossipLevel: 6, suspicion: 8,
                     favoriteFood: "Cheese Plate", favoriteDrink: "Cider",
                     preferredRoom: .cot, rumorTags: [.criminal, .trade], cloakHue: 5, hatStyle: 3),
        InnArchetype(id: 29, name: "Letter-Writer",       title: "For Hire by the Page",
                     temperament: 2, generosity: 5, gossipLevel: 7, suspicion: 3,
                     favoriteFood: "Pie", favoriteDrink: "Wine",
                     preferredRoom: .bed, rumorTags: [.personal, .political], cloakHue: 50, hatStyle: 2),
        InnArchetype(id: 30, name: "Squire-of-Errand",    title: "Boots Out of Polish",
                     temperament: 3, generosity: 4, gossipLevel: 6, suspicion: 4,
                     favoriteFood: "Stew", favoriteDrink: "Ale",
                     preferredRoom: .cot, rumorTags: [.political, .personal], cloakHue: 200, hatStyle: 1),
        InnArchetype(id: 31, name: "Foreign Envoy",       title: "Far-Sea Tongue",
                     temperament: 3, generosity: 6, gossipLevel: 6, suspicion: 5,
                     favoriteFood: "Pickled Fish", favoriteDrink: "Wine",
                     preferredRoom: .suite, rumorTags: [.political, .trade, .mystical], cloakHue: 175, hatStyle: 4),
        InnArchetype(id: 32, name: "Failed Magus",        title: "Sleeves Stained with Sulphur",
                     temperament: 5, generosity: 4, gossipLevel: 7, suspicion: 6,
                     favoriteFood: "Soft Cheese", favoriteDrink: "Brandy",
                     preferredRoom: .featherbed, rumorTags: [.mystical, .personal], cloakHue: 270, hatStyle: 4),
        InnArchetype(id: 33, name: "Drover",              title: "Of the Long Path",
                     temperament: 5, generosity: 5, gossipLevel: 5, suspicion: 3,
                     favoriteFood: "Stew", favoriteDrink: "Ale",
                     preferredRoom: .cot, rumorTags: [.local, .trade], cloakHue: 70, hatStyle: 1),
        InnArchetype(id: 34, name: "Off-Duty Constable",  title: "Cap Loose, Cup Full",
                     temperament: 6, generosity: 3, gossipLevel: 7, suspicion: 5,
                     favoriteFood: "Roast Lamb", favoriteDrink: "Strong Ale",
                     preferredRoom: .bed, rumorTags: [.criminal, .local], cloakHue: 220, hatStyle: 2),
        InnArchetype(id: 35, name: "Bounty-Hunter",       title: "Sealed Warrant",
                     temperament: 7, generosity: 3, gossipLevel: 5, suspicion: 7,
                     favoriteFood: "Beef Stew", favoriteDrink: "Strong Ale",
                     preferredRoom: .bed, rumorTags: [.criminal, .political], cloakHue: 0, hatStyle: 3),
        InnArchetype(id: 36, name: "Estranged Sister",    title: "Of the Old Manor",
                     temperament: 4, generosity: 6, gossipLevel: 7, suspicion: 4,
                     favoriteFood: "Pie", favoriteDrink: "Mulled Wine",
                     preferredRoom: .featherbed, rumorTags: [.personal, .political], cloakHue: 305, hatStyle: 4),
        InnArchetype(id: 37, name: "Songless Bard",       title: "Searching for a Voice",
                     temperament: 4, generosity: 5, gossipLevel: 8, suspicion: 2,
                     favoriteFood: "Bread & Butter", favoriteDrink: "Wine",
                     preferredRoom: .cot, rumorTags: [.personal, .local, .mystical], cloakHue: 260, hatStyle: 0),
        InnArchetype(id: 38, name: "Shepherd's Boy",      title: "Eyes on Strange Trails",
                     temperament: 2, generosity: 4, gossipLevel: 6, suspicion: 2,
                     favoriteFood: "Bread & Butter", favoriteDrink: "Cider",
                     preferredRoom: .cot, rumorTags: [.local, .mystical], cloakHue: 85, hatStyle: 1),
        InnArchetype(id: 39, name: "Saltwater Captain",   title: "Of a Sunken Charter",
                     temperament: 6, generosity: 6, gossipLevel: 7, suspicion: 4,
                     favoriteFood: "Pickled Fish", favoriteDrink: "Brandy",
                     preferredRoom: .featherbed, rumorTags: [.trade, .mystical, .personal], cloakHue: 195, hatStyle: 4),
        InnArchetype(id: 40, name: "Hermit of the Wolfwood", title: "Out of the Trees",
                     temperament: 6, generosity: 4, gossipLevel: 8, suspicion: 4,
                     favoriteFood: "Venison Pie", favoriteDrink: "Mead",
                     preferredRoom: .cot, rumorTags: [.mystical, .local, .personal], cloakHue: 100, hatStyle: 0),
    ]

    static func archetype(_ id: Int) -> InnArchetype {
        archetypes.first(where: { $0.id == id }) ?? archetypes[0]
    }

    // MARK: - 120 Rumors

    static let rumors: [InnRumor] = makeRumors()

    private static func makeRumors() -> [InnRumor] {
        var list: [InnRumor] = []
        // Helper to keep things compact:
        func r(_ id: Int, _ summary: String, _ cat: RumorCategory, _ tier: RumorTier, _ truth: RumorTruth, _ arc: ArcKind?) {
            list.append(InnRumor(id: id, summary: summary, category: cat, tier: tier, actualTruth: truth, arcAffinity: arc))
        }

        // POLITICAL (20)
        r(1,   "The Marshal of Tellveric drafts crossroad tariffs in secret.",                          .political, .hearsay, .partial, .northernRoadWar)
        r(2,   "Duke Halran sent envoys north — under flagless cloaks.",                                .political, .whisper, .trueRumor, .northernRoadWar)
        r(3,   "The royal seneschal twice canceled the autumn tax progress.",                          .political, .hearsay, .partial, nil)
        r(4,   "An assassin lodged at Far Bell pretended to be a tinker.",                              .political, .whisper, .falseRumor, nil)
        r(5,   "Greyhollow's reeve sells writs of toll without record.",                                .political, .hearsay, .trueRumor, .smugglersMap)
        r(6,   "The Lord of the Cinderhall sired a child in secret — a daughter.",                     .political, .fact,    .trueRumor, .lordsBastard)
        r(7,   "Two banners were sewn in haste at the chapel of Sundown Cross.",                       .political, .whisper, .partial, .northernRoadWar)
        r(8,   "The Queen's third herald never reached Tellveric.",                                    .political, .hearsay, .trueRumor, nil)
        r(9,   "Old Cinder's mayor accepted a foreign chest at midnight.",                             .political, .whisper, .partial, .northernRoadWar)
        r(10,  "A peace treaty was sketched between the duchies, then thrown to fire.",                .political, .fact,    .falseRumor, .northernRoadWar)
        r(11,  "Royal scouts mark inns with a chalk crescent — ours bears one.",                       .political, .whisper, .trueRumor, nil)
        r(12,  "The Duke of the Hollow has not been seen for three weeks.",                            .political, .hearsay, .partial, .lordsBastard)
        r(13,  "Tellveric's barracks bought five hundred arrows last fortnight.",                      .political, .fact,    .trueRumor, .northernRoadWar)
        r(14,  "The constable of Marsh Reach hides a writ of attainder.",                              .political, .whisper, .partial, nil)
        r(15,  "Wickbrook's lord struck a bargain with a foreign embassy.",                            .political, .hearsay, .trueRumor, nil)
        r(16,  "A royal scout was poisoned at Three Stones — quietly.",                                .political, .whisper, .falseRumor, nil)
        r(17,  "The chancellor's signet ring is in a courier's saddlebag.",                            .political, .hearsay, .partial, nil)
        r(18,  "An old crown writ names a bastard heir to be sought.",                                 .political, .fact,    .trueRumor, .lordsBastard)
        r(19,  "The Northern Road tolls have doubled overnight.",                                      .political, .fact,    .trueRumor, .northernRoadWar)
        r(20,  "Foreign embassies trade lordly favors for navigation charts.",                         .political, .hearsay, .partial, .smugglersMap)

        // TRADE (20)
        r(21,  "A salt caravan was diverted around Far Bell — no one knows why.",                      .trade, .hearsay, .trueRumor, .smugglersMap)
        r(22,  "The Tinker's Guild quietly raised brass to twice its weight.",                         .trade, .fact,    .trueRumor, nil)
        r(23,  "Smugglers cut a new path through the Wolfwood at the gore.",                           .trade, .whisper, .partial, .wolfwoodBeast)
        r(24,  "A counterfeit silver mark circulates in Sundown Cross.",                               .trade, .hearsay, .trueRumor, nil)
        r(25,  "A cartographer sold a map of the smuggler caches for two cups of wine.",               .trade, .whisper, .partial, .smugglersMap)
        r(26,  "Foreign silks moved by night through Old Cinder.",                                     .trade, .hearsay, .trueRumor, .smugglersMap)
        r(27,  "Greyhollow's millers stockpile grain — they expect a siege.",                          .trade, .whisper, .partial, .northernRoadWar)
        r(28,  "A Tellveric trader collects scrolls bearing a wolf-and-moon sigil.",                   .trade, .hearsay, .trueRumor, .wolfwoodBeast)
        r(29,  "Three caravans agreed in secret to refuse the duchy's tolls.",                         .trade, .hearsay, .partial, .northernRoadWar)
        r(30,  "A merchant boasted of buying a map drawn on three torn parchments.",                   .trade, .fact,    .trueRumor, .smugglersMap)
        r(31,  "The Letter-Carrier's guild was paid in foreign coin.",                                 .trade, .whisper, .partial, nil)
        r(32,  "A drover was paid in rumor instead of silver — at Three Stones.",                      .trade, .hearsay, .partial, nil)
        r(33,  "Two crates of salt fell from a barge upriver of Marsh Reach.",                         .trade, .fact,    .trueRumor, nil)
        r(34,  "Pewter trade has tripled — they don't drink that much.",                               .trade, .hearsay, .partial, nil)
        r(35,  "A new toll-bridge is to be built at the Cinderford crossing.",                         .trade, .fact,    .trueRumor, nil)
        r(36,  "A foreign merchant pays double for crow-feather pens.",                                .trade, .whisper, .falseRumor, nil)
        r(37,  "The bargemen's ledgers show ghost cargoes — paid, not shipped.",                       .trade, .hearsay, .trueRumor, .smugglersMap)
        r(38,  "Salt has gone scarce in Tellveric. Bread is sour with cheap sea-rock.",                .trade, .fact,    .trueRumor, nil)
        r(39,  "Wagons crossed the river at midnight — no toll man on duty.",                          .trade, .whisper, .partial, .smugglersMap)
        r(40,  "A guild seal was stolen and used to sign three writs.",                                .trade, .hearsay, .partial, .smugglersMap)

        // PERSONAL (20)
        r(41,  "The reeve's wife meets the herald in the back of the chapel.",                         .personal, .whisper, .partial, nil)
        r(42,  "A bastard child was raised in the abbey kitchen of Wickbrook.",                        .personal, .hearsay, .trueRumor, .lordsBastard)
        r(43,  "The widow of Old Cinder writes letters to the seneschal each fortnight.",              .personal, .whisper, .trueRumor, nil)
        r(44,  "The Lord's elder daughter wears the same cloak as a stableboy.",                       .personal, .hearsay, .partial, .lordsBastard)
        r(45,  "A man at Marsh Reach refused his own name when asked.",                                .personal, .whisper, .partial, .lordsBastard)
        r(46,  "An estranged sister returns to claim the manor of Black Holt.",                        .personal, .fact,    .trueRumor, nil)
        r(47,  "The mendicant prophet's mother died at our well, years ago.",                          .personal, .hearsay, .trueRumor, .mendicantProphet)
        r(48,  "A scribe wept while copying a marriage record.",                                       .personal, .whisper, .partial, nil)
        r(49,  "Two squires share a wax-sealed letter they will not open.",                            .personal, .whisper, .partial, nil)
        r(50,  "A traveler asked after a girl named Lyset — three times in two days.",                 .personal, .hearsay, .trueRumor, .lordsBastard)
        r(51,  "The reeve has a younger brother no one has met.",                                      .personal, .whisper, .partial, .lordsBastard)
        r(52,  "A monk admitted he buried more than a pauper in the orchard.",                         .personal, .hearsay, .trueRumor, nil)
        r(53,  "A widow's mourning was cut short by an unlooked-for inheritance.",                     .personal, .fact,    .trueRumor, nil)
        r(54,  "A cooper's wife bears a ring of foreign make.",                                        .personal, .whisper, .partial, nil)
        r(55,  "An apothecary sells a tincture only one family of nobles buys.",                       .personal, .hearsay, .trueRumor, .lordsBastard)
        r(56,  "A young man at table three has the Lord's chin and his stutter.",                      .personal, .whisper, .trueRumor, .lordsBastard)
        r(57,  "The marshal's daughter slipped away with a foreign envoy.",                            .personal, .hearsay, .partial, nil)
        r(58,  "The friar prays nightly for a name he will not speak.",                                .personal, .whisper, .trueRumor, .mendicantProphet)
        r(59,  "A confessional grew quiet too often in the last week.",                                .personal, .whisper, .partial, nil)
        r(60,  "A bard composed a ballad about a hidden heir and burned it.",                         .personal, .fact,    .partial, .lordsBastard)

        // MYSTICAL (20)
        r(61,  "Lights drift over the Wolfwood at the third bell.",                                    .mystical, .hearsay, .trueRumor, .wolfwoodBeast)
        r(62,  "A monk dreams of a wolf with a coin between its teeth.",                               .mystical, .whisper, .partial, .wolfwoodBeast)
        r(63,  "The mendicant prophet healed a lame ox by the well of Old Cinder.",                    .mystical, .hearsay, .partial, .mendicantProphet)
        r(64,  "A comet hovered over the chapel of Wickbrook for an hour.",                            .mystical, .whisper, .falseRumor, nil)
        r(65,  "A child at Three Stones recalls a life she could not have lived.",                     .mystical, .whisper, .partial, nil)
        r(66,  "An old pilgrim road sings underfoot in the rain.",                                     .mystical, .hearsay, .trueRumor, nil)
        r(67,  "The Wolfwood Beast leaves a print only on one moon a year.",                           .mystical, .whisper, .partial, .wolfwoodBeast)
        r(68,  "A hermit prays in a tongue not used since the Cinder Wars.",                           .mystical, .hearsay, .trueRumor, .wolfwoodBeast)
        r(69,  "A statue at Marsh Reach has begun to sweat salt.",                                     .mystical, .whisper, .falseRumor, nil)
        r(70,  "An astronomer sketched a star not on any chart.",                                      .mystical, .hearsay, .partial, nil)
        r(71,  "The prophet preaches that no lord shall hold the Cinderhall by year's end.",          .mystical, .fact,    .partial, .mendicantProphet)
        r(72,  "A whip-thin man heals at the wells then leaves no footprint.",                         .mystical, .hearsay, .partial, .mendicantProphet)
        r(73,  "A magus saw a beast pass through Wickbrook gates as a cat.",                           .mystical, .whisper, .falseRumor, .wolfwoodBeast)
        r(74,  "A hunter dreamed of his own death three nights running.",                              .mystical, .whisper, .partial, .wolfwoodBeast)
        r(75,  "A child found a stone at Far Bell that hums at sunrise.",                              .mystical, .hearsay, .partial, nil)
        r(76,  "Crows of three settlements gather only here, on the rooftop.",                         .mystical, .fact,    .trueRumor, nil)
        r(77,  "A friar saw a man without breath confess and walk away.",                              .mystical, .whisper, .partial, .mendicantProphet)
        r(78,  "An apothecary's vials warmed when the prophet passed by.",                             .mystical, .hearsay, .partial, .mendicantProphet)
        r(79,  "The hermit speaks of a beast that takes the shape of regret.",                         .mystical, .whisper, .trueRumor, .wolfwoodBeast)
        r(80,  "Songs the bard never wrote return to him at dawn.",                                    .mystical, .hearsay, .partial, nil)

        // CRIMINAL (20)
        r(81,  "A hood-down highwayman bragged of three caches in the Wolfwood gore.",                 .criminal, .hearsay, .trueRumor, .smugglersMap)
        r(82,  "Counterfeit royal seals were ground in a backroom of Sundown Cross.",                  .criminal, .fact,    .trueRumor, nil)
        r(83,  "A bounty was set on the prophet — and quietly revoked.",                               .criminal, .whisper, .partial, .mendicantProphet)
        r(84,  "Coin-shavers test their work at the inn of Greyhollow.",                               .criminal, .hearsay, .trueRumor, nil)
        r(85,  "A bargeman threw a body over the rails at the Cinderford bend.",                       .criminal, .whisper, .partial, nil)
        r(86,  "A man called Korr sells stolen writs at the back of the carter's yard.",               .criminal, .hearsay, .trueRumor, .smugglersMap)
        r(87,  "A bounty hunter holds two warrants, but only one is sealed.",                          .criminal, .whisper, .partial, nil)
        r(88,  "Three foreign coins were used to pay a man to drop a name.",                           .criminal, .hearsay, .partial, nil)
        r(89,  "A blade marked with the Cinder sigil was found in Marsh Reach mud.",                   .criminal, .fact,    .trueRumor, nil)
        r(90,  "A constable accepts a flask each Friday from a man he should arrest.",                 .criminal, .hearsay, .trueRumor, nil)
        r(91,  "The map fragment of the third cache was lost in a game of dice.",                      .criminal, .hearsay, .partial, .smugglersMap)
        r(92,  "Bandits have begun to pay villagers in salt, not silver.",                             .criminal, .whisper, .partial, .smugglersMap)
        r(93,  "A tax-cart was robbed within sight of Tellveric's gates.",                             .criminal, .fact,    .trueRumor, .northernRoadWar)
        r(94,  "An off-duty constable named two of his own captains as smugglers.",                    .criminal, .whisper, .trueRumor, .smugglersMap)
        r(95,  "Wax seals have been recut to imitate the royal hand.",                                 .criminal, .hearsay, .trueRumor, nil)
        r(96,  "A poisoner's vial was bought, paid, and never collected.",                             .criminal, .whisper, .partial, nil)
        r(97,  "A thief left a wolf-tooth charm on the marshal's pillow.",                             .criminal, .hearsay, .partial, .wolfwoodBeast)
        r(98,  "A man waits at our well at midnight, four nights running.",                            .criminal, .whisper, .partial, nil)
        r(99,  "Bandits have begun to sing the prophet's verses on the road.",                         .criminal, .hearsay, .trueRumor, .mendicantProphet)
        r(100, "A messenger carried a forged writ as far as Far Bell before it failed.",               .criminal, .fact,    .trueRumor, nil)

        // LOCAL (20)
        r(101, "Our chapel bell rang itself at first light yesterday.",                                .local, .whisper, .falseRumor, nil)
        r(102, "Two stags walked into Wickbrook market and stood as if listening.",                    .local, .hearsay, .partial, .wolfwoodBeast)
        r(103, "The well at Three Stones tasted of iron for a week, then was sweet again.",            .local, .fact,    .trueRumor, nil)
        r(104, "Sundown Cross has a new innkeeper — and his accent is a stranger's.",                  .local, .hearsay, .trueRumor, nil)
        r(105, "Marsh Reach posted a watch — though no one will say what they watch.",                 .local, .whisper, .partial, .wolfwoodBeast)
        r(106, "Old Cinder's smith refuses to forge any blade longer than a hand.",                    .local, .hearsay, .partial, nil)
        r(107, "The yew at the Three Stones crossroads bears fresh chalk marks.",                      .local, .whisper, .trueRumor, .lordsBastard)
        r(108, "The Wolfwood Beast was glimpsed near Far Bell pasture two nights running.",            .local, .hearsay, .partial, .wolfwoodBeast)
        r(109, "Wickbrook's miller has hired three new hands and built a hidden granary.",             .local, .hearsay, .partial, .northernRoadWar)
        r(110, "Greyhollow's children sing a new rhyme about a Beast and a Bastard.",                  .local, .hearsay, .partial, .lordsBastard)
        r(111, "The carter from Tellveric refuses to cross the Wolfwood after sunset.",                .local, .whisper, .trueRumor, .wolfwoodBeast)
        r(112, "Sundown Cross posted a writ at the chapel — about the prophet.",                       .local, .hearsay, .partial, .mendicantProphet)
        r(113, "An old well at Far Bell was sealed in the night.",                                     .local, .whisper, .partial, nil)
        r(114, "A travelling fair set up at the gore of the Wolfwood without permit.",                 .local, .hearsay, .partial, nil)
        r(115, "The marshal posted two coppers reward for any wolf-tooth charm turned in.",            .local, .fact,    .trueRumor, .wolfwoodBeast)
        r(116, "The smith of Wickbrook found a chest at the bottom of the carter's well.",             .local, .whisper, .partial, .smugglersMap)
        r(117, "Marsh Reach lost two herds to wolves with chalk-white pelts.",                         .local, .hearsay, .partial, .wolfwoodBeast)
        r(118, "Old Cinder's chapel posted a list of those forbidden to enter.",                       .local, .whisper, .partial, .mendicantProphet)
        r(119, "Greyhollow's market burned itself out twice in a week — same stall.",                  .local, .hearsay, .partial, nil)
        r(120, "Far Bell's reeve has begun travelling armed, even to chapel.",                         .local, .whisper, .partial, .northernRoadWar)

        return list
    }

    static func rumor(_ id: Int) -> InnRumor? {
        rumors.first(where: { $0.id == id })
    }

    // MARK: - Menu Items (32)
    static let menuItems: [MenuItem] = [
        // foods
        MenuItem(id: 1,  name: "Beef Stew",        kind: "food", costToMake: 3, sellPrice: 7,  popularity: [3:5, 10:4, 14:3, 22:5]),
        MenuItem(id: 2,  name: "Roast Lamb",       kind: "food", costToMake: 5, sellPrice: 11, popularity: [2:5, 9:5, 19:4, 34:4]),
        MenuItem(id: 3,  name: "Venison Pie",      kind: "food", costToMake: 5, sellPrice: 12, popularity: [6:5, 22:5, 40:5]),
        MenuItem(id: 4,  name: "Cheese Plate",     kind: "food", costToMake: 2, sellPrice: 6,  popularity: [1:5, 5:3, 11:4, 20:5]),
        MenuItem(id: 5,  name: "Bread & Butter",   kind: "food", costToMake: 1, sellPrice: 3,  popularity: [4:5, 8:3, 21:5, 37:4]),
        MenuItem(id: 6,  name: "Herb Soup",        kind: "food", costToMake: 2, sellPrice: 5,  popularity: [13:5, 24:5]),
        MenuItem(id: 7,  name: "Pickled Fish",     kind: "food", costToMake: 2, sellPrice: 5,  popularity: [14:5, 31:4, 39:5]),
        MenuItem(id: 8,  name: "Soft Cheese",      kind: "food", costToMake: 2, sellPrice: 5,  popularity: [5:5, 11:4, 18:3, 32:5]),
        MenuItem(id: 9,  name: "Roast Capon",      kind: "food", costToMake: 4, sellPrice: 9,  popularity: [7:5, 12:4, 16:3, 25:5]),
        MenuItem(id: 10, name: "Honeyed Oats",     kind: "food", costToMake: 1, sellPrice: 3,  popularity: [8:5, 18:4]),
        MenuItem(id: 11, name: "Pie",              kind: "food", costToMake: 2, sellPrice: 5,  popularity: [15:5, 23:5, 29:4, 36:5]),
        MenuItem(id: 12, name: "Salted Pork",      kind: "food", costToMake: 3, sellPrice: 7,  popularity: [10:4, 17:3, 27:5, 33:5]),
        MenuItem(id: 13, name: "Black Pudding",    kind: "food", costToMake: 2, sellPrice: 5,  popularity: [3:4, 22:3, 35:5]),
        MenuItem(id: 14, name: "Crow-Bean Stew",   kind: "food", costToMake: 1, sellPrice: 3,  popularity: [4:4, 21:5, 38:4]),
        MenuItem(id: 15, name: "Plum Tart",        kind: "food", costToMake: 3, sellPrice: 7,  popularity: [1:3, 23:5, 36:4]),
        MenuItem(id: 16, name: "Onion & Liver",    kind: "food", costToMake: 2, sellPrice: 5,  popularity: [3:4, 33:4, 35:3]),
        // drinks
        MenuItem(id: 17, name: "Strong Ale",       kind: "drink", costToMake: 1, sellPrice: 4, popularity: [3:5, 10:5, 17:5, 22:5, 27:4, 34:5]),
        MenuItem(id: 18, name: "Ale",              kind: "drink", costToMake: 1, sellPrice: 3, popularity: [10:3, 14:4, 30:4, 33:4]),
        MenuItem(id: 19, name: "Mulled Wine",      kind: "drink", costToMake: 2, sellPrice: 6, popularity: [1:5, 12:5, 23:5, 36:5]),
        MenuItem(id: 20, name: "Mead",             kind: "drink", costToMake: 2, sellPrice: 5, popularity: [13:5, 21:4, 26:5, 40:5]),
        MenuItem(id: 21, name: "Spiced Cider",     kind: "drink", costToMake: 1, sellPrice: 4, popularity: [2:5, 4:4, 6:4, 11:5, 20:5, 21:4, 28:4, 38:5]),
        MenuItem(id: 22, name: "Wine",             kind: "drink", costToMake: 3, sellPrice: 7, popularity: [7:5, 16:4, 19:3, 22:0, 25:5, 29:4, 31:5, 37:5]),
        MenuItem(id: 23, name: "Brandy",           kind: "drink", costToMake: 3, sellPrice: 8, popularity: [5:5, 9:5, 18:4, 24:4, 32:5, 39:5]),
        MenuItem(id: 24, name: "Water",            kind: "drink", costToMake: 0, sellPrice: 1, popularity: [4:3, 8:3]),
        MenuItem(id: 25, name: "Heatherwine",      kind: "drink", costToMake: 3, sellPrice: 7, popularity: [12:4, 19:3, 31:4]),
        MenuItem(id: 26, name: "Buttermilk",       kind: "drink", costToMake: 1, sellPrice: 2, popularity: [8:3, 13:3, 38:3]),
        // specialty / sides
        MenuItem(id: 27, name: "Sailor's Hash",    kind: "food", costToMake: 2, sellPrice: 5, popularity: [14:4, 39:5]),
        MenuItem(id: 28, name: "Roasted Roots",    kind: "food", costToMake: 1, sellPrice: 3, popularity: [33:4, 21:3]),
        MenuItem(id: 29, name: "Apple Pottage",    kind: "food", costToMake: 1, sellPrice: 3, popularity: [4:4, 20:4]),
        MenuItem(id: 30, name: "Smoked Trout",     kind: "food", costToMake: 3, sellPrice: 6, popularity: [11:3, 14:5, 39:5]),
        MenuItem(id: 31, name: "Pepper Pie",       kind: "food", costToMake: 3, sellPrice: 8, popularity: [12:4, 16:4, 25:5]),
        MenuItem(id: 32, name: "Garlic Brew",      kind: "drink", costToMake: 1, sellPrice: 3, popularity: [13:4, 24:5, 32:3]),
    ]

    static func menuItem(_ id: Int) -> MenuItem? {
        menuItems.first(where: { $0.id == id })
    }

    // MARK: - 8 Settlements

    static let settlementSeeds: [Settlement] = [
        Settlement(id: 1, name: "Greyhollow",    blurb: "A milling town that hates the cold and the lord in equal measure.",
                   reputation: 30, primaryGuestArchetypeIds: [2, 14, 19, 27, 33, 38], dangerFactor: 2),
        Settlement(id: 2, name: "Sundown Cross", blurb: "A market crossroads where preachers and pickpockets share a porch.",
                   reputation: 40, primaryGuestArchetypeIds: [1, 4, 15, 20, 21, 37], dangerFactor: 3),
        Settlement(id: 3, name: "Three Stones",  blurb: "Three plinths, a tavern older than the road, and an unblinking constable.",
                   reputation: 25, primaryGuestArchetypeIds: [10, 17, 34, 35, 28], dangerFactor: 4),
        Settlement(id: 4, name: "Tellveric",     blurb: "Walled, well-watered, well-watched. The duchy keeps its accounts here.",
                   reputation: 35, primaryGuestArchetypeIds: [7, 9, 16, 25, 30, 31], dangerFactor: 2),
        Settlement(id: 5, name: "Old Cinder",    blurb: "Burned twice; rebuilt twice. The stones remember.",
                   reputation: 20, primaryGuestArchetypeIds: [3, 12, 23, 26, 32], dangerFactor: 5),
        Settlement(id: 6, name: "Wickbrook",     blurb: "A pilgrim stop. The friars insist the well is holy. The drovers insist it is cold.",
                   reputation: 45, primaryGuestArchetypeIds: [8, 13, 21, 24, 29, 36], dangerFactor: 1),
        Settlement(id: 7, name: "Marsh Reach",   blurb: "Flat reed country. Smoke hangs low. Rumors sit even lower.",
                   reputation: 22, primaryGuestArchetypeIds: [5, 11, 17, 18, 39], dangerFactor: 4),
        Settlement(id: 8, name: "Far Bell",      blurb: "The end of the bell-line. Beyond it, only the Wolfwood and whatever it carries.",
                   reputation: 18, primaryGuestArchetypeIds: [6, 22, 40, 38, 35], dangerFactor: 5),
    ]

    // MARK: - 42 Events
    static let events: [InnEvent] = [
        InnEvent(id: 1, title: "Blizzard at Dusk",
                 body: "The wind takes the lanterns off the porch. Two travelers stumble out of the dark.",
                 category: "weather",
                 options: [
                    InnEventOption(label: "Take them in. Hot stew on the house.",
                                   consequence: "You shelter them. Word will travel — quietly.",
                                   coinDelta: -6, reputationDelta: [1: 4, 6: 4], rumorIdReward: 67, setFlag: nil),
                    InnEventOption(label: "Charge full rate for a cot.",
                                   consequence: "Coin in hand, but the bar grumbles.",
                                   coinDelta: 8, reputationDelta: [1: -2, 6: -2], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Refuse — too many strangers tonight.",
                                   consequence: "They sleep in the stable. Reputation falls.",
                                   coinDelta: 0, reputationDelta: [1: -4, 6: -3], rumorIdReward: nil, setFlag: nil)
                 ], weight: 6),
        InnEvent(id: 2, title: "Brawl in the Common Room",
                 body: "Two mercenaries argue over the count of last week's silver. A chair flies.",
                 category: "danger",
                 options: [
                    InnEventOption(label: "Step between them. Buy a round.",
                                   consequence: "Peace, at the cost of one keg.",
                                   coinDelta: -5, reputationDelta: [3: 2], rumorIdReward: 3, setFlag: nil),
                    InnEventOption(label: "Have your bouncer (if any) eject them.",
                                   consequence: "Strong arms. They will remember.",
                                   coinDelta: 0, reputationDelta: [5: -3, 3: -1], rumorIdReward: nil, setFlag: "brawlsEjected"),
                    InnEventOption(label: "Let them sort it out.",
                                   consequence: "A table breaks. So does some furniture.",
                                   coinDelta: -10, reputationDelta: [2: -2], rumorIdReward: 81, setFlag: nil)
                 ], weight: 8),
        InnEvent(id: 3, title: "Royal Inspection",
                 body: "A scout in a crown-stamped cloak asks for your records, your menu, and your guest list.",
                 category: "royal",
                 options: [
                    InnEventOption(label: "Comply. Every page.",
                                   consequence: "She nods and goes. Reputation rises with the crown.",
                                   coinDelta: -2, reputationDelta: [4: 5], rumorIdReward: 11, setFlag: nil),
                    InnEventOption(label: "Refuse the bribe she discreetly offers.",
                                   consequence: "She narrows her eyes. Brave or foolish.",
                                   coinDelta: 0, reputationDelta: [4: 3], rumorIdReward: nil, setFlag: "refusedScoutBribe"),
                    InnEventOption(label: "Hand her a careful copy that omits the spy.",
                                   consequence: "Risky. But discreet.",
                                   coinDelta: 0, reputationDelta: [4: -2, 5: 3], rumorIdReward: 5, setFlag: nil)
                 ], weight: 5),
        InnEvent(id: 4, title: "Bandit Raid",
                 body: "Hooded riders at the gate. They want stabling, no questions asked.",
                 category: "danger",
                 options: [
                    InnEventOption(label: "Refuse. Bar the gate.",
                                   consequence: "They ride on. The stable boy looks ill.",
                                   coinDelta: 0, reputationDelta: [3: -3, 4: 4], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Take their coin. Ask no names.",
                                   consequence: "A heavy purse, paid in foreign silver.",
                                   coinDelta: 22, reputationDelta: [4: -4, 3: -2], rumorIdReward: 86, setFlag: nil),
                    InnEventOption(label: "Send the stable boy to the constable.",
                                   consequence: "A scuffle. One of them slips away into the Wolfwood.",
                                   coinDelta: 4, reputationDelta: [4: 2, 8: -2], rumorIdReward: nil, setFlag: nil)
                 ], weight: 5),
        InnEvent(id: 5, title: "Wedding Party Overflow",
                 body: "A wedding at Wickbrook turned into a procession. Half of it ends up at your door.",
                 category: "social",
                 options: [
                    InnEventOption(label: "Open all tables. Music until dawn.",
                                   consequence: "Coin in coin out, and a great deal of merry chaos.",
                                   coinDelta: 24, reputationDelta: [6: 4, 2: 2], rumorIdReward: 41, setFlag: nil),
                    InnEventOption(label: "Charge a procession fee.",
                                   consequence: "They pay. They grumble.",
                                   coinDelta: 14, reputationDelta: [6: -2], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Send them along to Sundown Cross.",
                                   consequence: "Less profit. A quieter night.",
                                   coinDelta: 4, reputationDelta: [6: -1, 2: 2], rumorIdReward: nil, setFlag: nil)
                 ], weight: 5),
        InnEvent(id: 6, title: "Debt Collector",
                 body: "A polite man with a ledger arrives. He produces a writ. It bears your mark.",
                 category: "trade",
                 options: [
                    InnEventOption(label: "Pay in full.",
                                   consequence: "Lighter purse, clear ledger.",
                                   coinDelta: -25, reputationDelta: [:], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Negotiate — half now, half in three weeks.",
                                   consequence: "He agrees and leaves a stamp behind.",
                                   coinDelta: -14, reputationDelta: [1: -1], rumorIdReward: nil, setFlag: "debtHalf"),
                    InnEventOption(label: "Tell him the writ is forged.",
                                   consequence: "He flinches. The writ was forged.",
                                   coinDelta: 0, reputationDelta: [:], rumorIdReward: 95, setFlag: nil)
                 ], weight: 4),
        InnEvent(id: 7, title: "Wandering Minstrel Contest",
                 body: "Three bards take the corner of the room. They want a prize for the best new song.",
                 category: "social",
                 options: [
                    InnEventOption(label: "Put up a small purse. Take an entry fee.",
                                   consequence: "Crowd, song, and a fair night's purse.",
                                   coinDelta: 12, reputationDelta: [2: 3, 6: 2], rumorIdReward: 60, setFlag: nil),
                    InnEventOption(label: "Let them play. Pass the hat for them.",
                                   consequence: "A quiet kindness. A bard will remember.",
                                   coinDelta: -3, reputationDelta: [2: 4], rumorIdReward: 1, setFlag: nil),
                    InnEventOption(label: "Move them to the porch.",
                                   consequence: "Quieter room. Less coin.",
                                   coinDelta: 2, reputationDelta: [2: -2], rumorIdReward: nil, setFlag: nil)
                 ], weight: 5),
        InnEvent(id: 8, title: "Festival Overflow",
                 body: "Sundown Cross has a saint's day. Every cart on the road points at your sign.",
                 category: "social",
                 options: [
                    InnEventOption(label: "Open every table. Hire two day-helpers.",
                                   consequence: "Long night. Sticky coppers. Word travels.",
                                   coinDelta: 28, reputationDelta: [2: 4], rumorIdReward: 112, setFlag: nil),
                    InnEventOption(label: "Hold the line. Half-price ale only.",
                                   consequence: "Steady, sober, modest profit.",
                                   coinDelta: 12, reputationDelta: [2: 1], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Close at sunset.",
                                   consequence: "Quiet. A few muttered curses.",
                                   coinDelta: 2, reputationDelta: [2: -3], rumorIdReward: nil, setFlag: nil)
                 ], weight: 4),
        InnEvent(id: 9, title: "Foreign Embassy Visit",
                 body: "A delegation in unfamiliar silks asks for a private room and absolute discretion.",
                 category: "royal",
                 options: [
                    InnEventOption(label: "Give them the back parlor. No questions.",
                                   consequence: "A heavy purse. Strange writing on a napkin.",
                                   coinDelta: 30, reputationDelta: [4: -2], rumorIdReward: 9, setFlag: "embassyHosted"),
                    InnEventOption(label: "Insist they declare themselves to the constable.",
                                   consequence: "They leave. The crown will hear.",
                                   coinDelta: 0, reputationDelta: [4: 4, 7: -2], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Eavesdrop with your maid.",
                                   consequence: "A name, a place, a whispered date.",
                                   coinDelta: 12, reputationDelta: [4: -1], rumorIdReward: 15, setFlag: nil)
                 ], weight: 4),
        InnEvent(id: 10, title: "Wolfwood Rumblings",
                 body: "A hunter staggers in. He says something walked beside him for two miles without footprints.",
                 category: "weather",
                 options: [
                    InnEventOption(label: "Bed him near the fire. Let him talk.",
                                   consequence: "He tells you more than he should.",
                                   coinDelta: -2, reputationDelta: [8: 3], rumorIdReward: 79, setFlag: nil),
                    InnEventOption(label: "Send him on to Far Bell.",
                                   consequence: "A relief. A shut-down road.",
                                   coinDelta: 0, reputationDelta: [8: -2], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Take his story to the bailiff yourself.",
                                   consequence: "A coin reward. He's furious.",
                                   coinDelta: 8, reputationDelta: [8: -3, 4: 2], rumorIdReward: nil, setFlag: nil)
                 ], weight: 4),
        InnEvent(id: 11, title: "Royal Decree Posted",
                 body: "A crown writ is nailed to your post. It commands a census of all traveling friars.",
                 category: "royal",
                 options: [
                    InnEventOption(label: "Comply diligently.",
                                   consequence: "Slow week. Crown approves.",
                                   coinDelta: -4, reputationDelta: [4: 5], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Send the writ to the prophet's friends.",
                                   consequence: "A favor owed. Two warm cloaks delivered.",
                                   coinDelta: 6, reputationDelta: [4: -3], rumorIdReward: 71, setFlag: nil),
                    InnEventOption(label: "Tear it down. The friars eat free tonight.",
                                   consequence: "Loud, brave, foolish.",
                                   coinDelta: -6, reputationDelta: [4: -5, 6: 3], rumorIdReward: nil, setFlag: nil)
                 ], weight: 3),
        InnEvent(id: 12, title: "Smuggler's Cache Rumor",
                 body: "A drover offers — for a cup of wine — to mark a smuggler cache on your wall.",
                 category: "trade",
                 options: [
                    InnEventOption(label: "Pour the cup. Listen.",
                                   consequence: "He scratches a sign with his thumbnail.",
                                   coinDelta: -2, reputationDelta: [3: 2], rumorIdReward: 30, setFlag: nil),
                    InnEventOption(label: "Refuse — not under this roof.",
                                   consequence: "He sneers.",
                                   coinDelta: 0, reputationDelta: [3: -1, 4: 2], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Pour two cups and pretend to listen.",
                                   consequence: "Garbled, but useful.",
                                   coinDelta: -4, reputationDelta: [3: 1], rumorIdReward: 25, setFlag: nil)
                 ], weight: 4),
        InnEvent(id: 13, title: "Stable Fire",
                 body: "A lantern overturns. Smoke at the stalls. Two horses panic.",
                 category: "danger",
                 options: [
                    InnEventOption(label: "Run to the stalls yourself.",
                                   consequence: "Singed beard. Lives saved.",
                                   coinDelta: -2, reputationDelta: [1: 3, 8: 3], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Send the stableboy with the bucket-chain.",
                                   consequence: "He manages — barely.",
                                   coinDelta: -8, reputationDelta: [1: 1], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Cut the harness, save the horses, lose the stable.",
                                   consequence: "Brutal. Effective.",
                                   coinDelta: -18, reputationDelta: [1: 4], rumorIdReward: nil, setFlag: nil)
                 ], weight: 3),
        InnEvent(id: 14, title: "Mendicant Prophet at the Door",
                 body: "A barefoot man in a sun-bleached robe asks to speak from the porch.",
                 category: "royal",
                 options: [
                    InnEventOption(label: "Let him speak. Buy him bread.",
                                   consequence: "A small sermon. A larger crowd.",
                                   coinDelta: -3, reputationDelta: [6: 4, 4: -2], rumorIdReward: 63, setFlag: nil),
                    InnEventOption(label: "Send him to Wickbrook.",
                                   consequence: "Peace tonight. A note from the friars.",
                                   coinDelta: 0, reputationDelta: [6: -2], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Offer him the suite at no cost.",
                                   consequence: "A bold gesture. A bolder rumor.",
                                   coinDelta: -10, reputationDelta: [6: 6, 4: -4], rumorIdReward: 47, setFlag: "hostedProphet")
                 ], weight: 3),
        InnEvent(id: 15, title: "Coin-Shaver Caught",
                 body: "Your maid finds three filed coins under the floor. She thinks the culprit is at the bar.",
                 category: "danger",
                 options: [
                    InnEventOption(label: "Hand him to the constable.",
                                   consequence: "Justice. A bounty.",
                                   coinDelta: 12, reputationDelta: [3: 3, 4: 2], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Quietly bar him for life.",
                                   consequence: "A whisper in the right ear.",
                                   coinDelta: 0, reputationDelta: [3: 2], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Demand a price for silence.",
                                   consequence: "Heavy purse. Heavier conscience.",
                                   coinDelta: 22, reputationDelta: [3: -2, 4: -3], rumorIdReward: 84, setFlag: nil)
                 ], weight: 3),
        InnEvent(id: 16, title: "Two Mercenaries Argue Over Coin",
                 body: "They are not yet shouting. They are pacing.",
                 category: "danger",
                 options: [
                    InnEventOption(label: "Offer them dice on the house.",
                                   consequence: "Distracted. The coin sleeps.",
                                   coinDelta: -2, reputationDelta: [3: 2], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Pour each a cup and listen.",
                                   consequence: "They name a contract you should not have heard.",
                                   coinDelta: -3, reputationDelta: [3: 1], rumorIdReward: 13, setFlag: nil),
                    InnEventOption(label: "Refuse them further drink.",
                                   consequence: "They leave. Two cups unsold.",
                                   coinDelta: -1, reputationDelta: [3: -2], rumorIdReward: nil, setFlag: nil)
                 ], weight: 5),
        InnEvent(id: 17, title: "Caravan Wagon Breaks Down",
                 body: "A trader at your gate needs a smith. There is no smith. There is you.",
                 category: "trade",
                 options: [
                    InnEventOption(label: "Lend him your stableboy and tools.",
                                   consequence: "He pays. He'll come back.",
                                   coinDelta: 9, reputationDelta: [1: 3], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Send for the wandering smith — at price.",
                                   consequence: "Slow but proper.",
                                   coinDelta: 2, reputationDelta: [1: 1], rumorIdReward: 22, setFlag: nil),
                    InnEventOption(label: "Refuse — too busy.",
                                   consequence: "He limps to Greyhollow.",
                                   coinDelta: 0, reputationDelta: [1: -3], rumorIdReward: nil, setFlag: nil)
                 ], weight: 4),
        InnEvent(id: 18, title: "An Estranged Sister",
                 body: "A woman in mourning silk asks if a certain Lyset has ever stayed under this roof.",
                 category: "social",
                 options: [
                    InnEventOption(label: "Lie. You don't know.",
                                   consequence: "She nods. She does not believe you.",
                                   coinDelta: 0, reputationDelta: [4: -1], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Tell her the truth, what little you know.",
                                   consequence: "She presses a coin into your palm. She presses a hint into your ear.",
                                   coinDelta: 8, reputationDelta: [6: 2], rumorIdReward: 50, setFlag: nil),
                    InnEventOption(label: "Send for the courier to write to the manor.",
                                   consequence: "She frowns. The letter goes.",
                                   coinDelta: -3, reputationDelta: [6: 1], rumorIdReward: nil, setFlag: nil)
                 ], weight: 3),
        InnEvent(id: 19, title: "Bargemen's Disagreement",
                 body: "Three bargemen accuse a fourth of carrying off-the-record salt.",
                 category: "trade",
                 options: [
                    InnEventOption(label: "Buy them the round and ask for stories.",
                                   consequence: "Stories there are. Salt, less so.",
                                   coinDelta: -4, reputationDelta: [7: 2], rumorIdReward: 33, setFlag: nil),
                    InnEventOption(label: "Send the fourth out and the rest to bed.",
                                   consequence: "Tomorrow he sleeps somewhere else.",
                                   coinDelta: 2, reputationDelta: [7: -2], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Tell the constable the next morning.",
                                   consequence: "A small bounty. A larger silence at the bar.",
                                   coinDelta: 6, reputationDelta: [7: -3, 4: 2], rumorIdReward: 100, setFlag: nil)
                 ], weight: 4),
        InnEvent(id: 20, title: "Astronomer's Discovery",
                 body: "An astronomer at the back table claims to have seen a comet — and asks to use the roof.",
                 category: "social",
                 options: [
                    InnEventOption(label: "Send him up with a lantern.",
                                   consequence: "He sketches all night.",
                                   coinDelta: 2, reputationDelta: [7: 2], rumorIdReward: 70, setFlag: nil),
                    InnEventOption(label: "Charge him for roof access.",
                                   consequence: "He grumbles, pays.",
                                   coinDelta: 6, reputationDelta: [:], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Refuse — slates loose.",
                                   consequence: "He leaves. A small loss.",
                                   coinDelta: 0, reputationDelta: [7: -1], rumorIdReward: nil, setFlag: nil)
                 ], weight: 3),
        InnEvent(id: 21, title: "Magus Asks for Brimstone",
                 body: "A magus with stained sleeves wants brimstone, sulphur, salt.",
                 category: "trade",
                 options: [
                    InnEventOption(label: "Give him what little salt you spare.",
                                   consequence: "He smiles. Brimstone he must find elsewhere.",
                                   coinDelta: 4, reputationDelta: [5: 2], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Refuse — too much risk.",
                                   consequence: "He leaves. Tomorrow he leaves coin behind.",
                                   coinDelta: 0, reputationDelta: [5: -2], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Strike a price for the back room.",
                                   consequence: "He works there. Smoke. Glasswork. Coin.",
                                   coinDelta: 14, reputationDelta: [5: -1], rumorIdReward: 32, setFlag: nil)
                 ], weight: 3),
        InnEvent(id: 22, title: "Bounty Hunter at the Door",
                 body: "He has a description of a man you served at supper.",
                 category: "danger",
                 options: [
                    InnEventOption(label: "Show him the room.",
                                   consequence: "He pays. He doesn't say thank you.",
                                   coinDelta: 16, reputationDelta: [3: -2, 4: 3], rumorIdReward: 86, setFlag: nil),
                    InnEventOption(label: "Refuse — the guest paid for privacy.",
                                   consequence: "He nods. He waits outside.",
                                   coinDelta: 0, reputationDelta: [3: 2, 4: -2], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Send the guest out the back.",
                                   consequence: "A whispered favor. A future debt.",
                                   coinDelta: 0, reputationDelta: [3: 4, 4: -3], rumorIdReward: 87, setFlag: "savedFromBounty")
                 ], weight: 4),
        InnEvent(id: 23, title: "Friar's Sermon",
                 body: "A friar wants the porch tomorrow morning to preach without licence.",
                 category: "social",
                 options: [
                    InnEventOption(label: "Allow it. Provide a stool.",
                                   consequence: "Devout crowd. Small coin.",
                                   coinDelta: 4, reputationDelta: [6: 4], rumorIdReward: 58, setFlag: nil),
                    InnEventOption(label: "Send for the bailiff.",
                                   consequence: "Friar leaves. Crown approves.",
                                   coinDelta: 0, reputationDelta: [4: 3, 6: -3], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Charge a porch-fee for the stool.",
                                   consequence: "He pays in cabbage.",
                                   coinDelta: 0, reputationDelta: [6: 1], rumorIdReward: nil, setFlag: nil)
                 ], weight: 3),
        InnEvent(id: 24, title: "Old Soldier's Memory",
                 body: "An old soldier offers, for a cup, the names of two officers who never reported.",
                 category: "social",
                 options: [
                    InnEventOption(label: "Pour. Listen. Write nothing.",
                                   consequence: "Names lodge in your head.",
                                   coinDelta: -2, reputationDelta: [3: 2], rumorIdReward: 8, setFlag: nil),
                    InnEventOption(label: "Pour. Write everything in your ledger.",
                                   consequence: "A risk. Names later useful.",
                                   coinDelta: -2, reputationDelta: [4: 1], rumorIdReward: 11, setFlag: "ledgeredOfficers"),
                    InnEventOption(label: "Refuse.",
                                   consequence: "He leaves. Sober.",
                                   coinDelta: 0, reputationDelta: [3: -1], rumorIdReward: nil, setFlag: nil)
                 ], weight: 3),
        InnEvent(id: 25, title: "Drover's Apology",
                 body: "A drover came back to pay for the cup he stole last fortnight. He brings news.",
                 category: "trade",
                 options: [
                    InnEventOption(label: "Take the coin. Take the news.",
                                   consequence: "Two coppers. One useful word.",
                                   coinDelta: 4, reputationDelta: [1: 2], rumorIdReward: 32, setFlag: nil),
                    InnEventOption(label: "Refuse the coin. Take only the news.",
                                   consequence: "He owes you again.",
                                   coinDelta: 0, reputationDelta: [1: 3], rumorIdReward: 21, setFlag: nil),
                    InnEventOption(label: "Send him on. You have no time.",
                                   consequence: "He grumbles.",
                                   coinDelta: 0, reputationDelta: [1: -1], rumorIdReward: nil, setFlag: nil)
                 ], weight: 3),
        InnEvent(id: 26, title: "Letter-Writer at the Bar",
                 body: "A letter-writer offers two coppers for a quiet table and the maid's discretion.",
                 category: "social",
                 options: [
                    InnEventOption(label: "Give him the parlor. Tell the maid.",
                                   consequence: "A useful trade.",
                                   coinDelta: 2, reputationDelta: [4: 1], rumorIdReward: 17, setFlag: nil),
                    InnEventOption(label: "Charge him double.",
                                   consequence: "He pays. He sneers.",
                                   coinDelta: 5, reputationDelta: [:], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Refuse — too many ears tonight.",
                                   consequence: "He leaves.",
                                   coinDelta: 0, reputationDelta: [4: -1], rumorIdReward: nil, setFlag: nil)
                 ], weight: 3),
        InnEvent(id: 27, title: "Squire-of-Errand",
                 body: "A squire arrives in his lord's livery, asking to leave a sealed letter for collection.",
                 category: "royal",
                 options: [
                    InnEventOption(label: "Accept. Lock it in your strongbox.",
                                   consequence: "A small fee. A new tie to the manor.",
                                   coinDelta: 6, reputationDelta: [4: 3], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Refuse — too much risk.",
                                   consequence: "He leaves with the seal unmade.",
                                   coinDelta: 0, reputationDelta: [4: -1], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Accept. Hold it to the candle.",
                                   consequence: "You read more than you should.",
                                   coinDelta: 6, reputationDelta: [4: -2], rumorIdReward: 18, setFlag: "readSealedLetter")
                 ], weight: 3),
        InnEvent(id: 28, title: "Town Crier Hosts a Gathering",
                 body: "The crier wants to read the new market prices at your porch.",
                 category: "social",
                 options: [
                    InnEventOption(label: "Allow it. Sell ale to listeners.",
                                   consequence: "Brisk hour. Coin.",
                                   coinDelta: 11, reputationDelta: [1: 2], rumorIdReward: 38, setFlag: nil),
                    InnEventOption(label: "Refuse — too noisy.",
                                   consequence: "He goes to the chapel steps.",
                                   coinDelta: 0, reputationDelta: [1: -1], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Charge a porch-fee.",
                                   consequence: "He pays in news.",
                                   coinDelta: 3, reputationDelta: [1: 0], rumorIdReward: 34, setFlag: nil)
                 ], weight: 3),
        InnEvent(id: 29, title: "Healer's Rounds",
                 body: "A folk healer offers to tend the inn's coughing maid for free — for a bed.",
                 category: "social",
                 options: [
                    InnEventOption(label: "Accept the trade.",
                                   consequence: "Maid hale by sunrise.",
                                   coinDelta: -2, reputationDelta: [6: 2], rumorIdReward: 13, setFlag: "healerHosted"),
                    InnEventOption(label: "Refuse — your maid is your business.",
                                   consequence: "He sleeps in the stable.",
                                   coinDelta: 0, reputationDelta: [6: -2], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Take a coin and the bed offer.",
                                   consequence: "Cold deal. Cold profit.",
                                   coinDelta: 6, reputationDelta: [6: -1], rumorIdReward: nil, setFlag: nil)
                 ], weight: 3),
        InnEvent(id: 30, title: "Wolfwood Hermit Visits",
                 body: "A hermit from the Wolfwood asks to warm himself by your hearth.",
                 category: "weather",
                 options: [
                    InnEventOption(label: "Bring him stew. Listen long.",
                                   consequence: "He tells you what he saw.",
                                   coinDelta: -3, reputationDelta: [8: 3], rumorIdReward: 79, setFlag: nil),
                    InnEventOption(label: "Send him to Far Bell.",
                                   consequence: "A quiet night, a lost story.",
                                   coinDelta: 0, reputationDelta: [8: -1], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Take his coin for the suite.",
                                   consequence: "He pays in foreign silver.",
                                   coinDelta: 14, reputationDelta: [8: 1], rumorIdReward: 68, setFlag: nil)
                 ], weight: 3),
        InnEvent(id: 31, title: "Salt-Cart Arrives",
                 body: "A trader has a wagon of salt to sell off in private. Half-price, all in cash.",
                 category: "trade",
                 options: [
                    InnEventOption(label: "Buy it. Stock the cellar.",
                                   consequence: "Cheap salt. Suspicious salt.",
                                   coinDelta: -10, reputationDelta: [4: -1], rumorIdReward: nil, setFlag: "cheapSalt"),
                    InnEventOption(label: "Refuse — no record, no risk.",
                                   consequence: "He drives on.",
                                   coinDelta: 0, reputationDelta: [4: 1], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Buy two sacks only.",
                                   consequence: "A measured bargain.",
                                   coinDelta: -4, reputationDelta: [:], rumorIdReward: 33, setFlag: nil)
                 ], weight: 4),
        InnEvent(id: 32, title: "Tax-Sworn Reeve's Visit",
                 body: "A reeve checks your bar tab against your declared income.",
                 category: "royal",
                 options: [
                    InnEventOption(label: "Open every book.",
                                   consequence: "Clean. Tedious.",
                                   coinDelta: -5, reputationDelta: [4: 3], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Offer him a meal and a private word.",
                                   consequence: "A friendly settlement.",
                                   coinDelta: -3, reputationDelta: [4: 2], rumorIdReward: 25, setFlag: nil),
                    InnEventOption(label: "Refuse — your ledgers are private.",
                                   consequence: "Strained terms. Strained smile.",
                                   coinDelta: 0, reputationDelta: [4: -4], rumorIdReward: nil, setFlag: nil)
                 ], weight: 3),
        InnEvent(id: 33, title: "Pilgrim Procession",
                 body: "Twenty pilgrims at the gate, no coin to spare. They want bread and benediction.",
                 category: "social",
                 options: [
                    InnEventOption(label: "Open the kitchen. Bread for all.",
                                   consequence: "Empty pantry. Full porch.",
                                   coinDelta: -12, reputationDelta: [6: 6], rumorIdReward: 66, setFlag: nil),
                    InnEventOption(label: "Sell them bread at half-price.",
                                   consequence: "Coin and goodwill, balanced.",
                                   coinDelta: 4, reputationDelta: [6: 3], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Bar the door — they should beg the chapel.",
                                   consequence: "Cold message. Colder porch.",
                                   coinDelta: 0, reputationDelta: [6: -5], rumorIdReward: nil, setFlag: nil)
                 ], weight: 3),
        InnEvent(id: 34, title: "Carter's Suggestion",
                 body: "A carter offers a list of three roads no toll-collector watches.",
                 category: "trade",
                 options: [
                    InnEventOption(label: "Buy the list.",
                                   consequence: "Three new clients within a week.",
                                   coinDelta: -8, reputationDelta: [4: -2], rumorIdReward: 39, setFlag: nil),
                    InnEventOption(label: "Refuse politely.",
                                   consequence: "He grumbles.",
                                   coinDelta: 0, reputationDelta: [4: 1], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Trade him an old rumor for the list.",
                                   consequence: "Lighter purse, two new lines on your wall map.",
                                   coinDelta: -2, reputationDelta: [4: -1], rumorIdReward: 91, setFlag: nil)
                 ], weight: 4),
        InnEvent(id: 35, title: "Shepherd's Boy at the Door",
                 body: "A boy from Marsh Reach claims he saw the Wolfwood Beast at dawn.",
                 category: "weather",
                 options: [
                    InnEventOption(label: "Take his name. Pay him a copper.",
                                   consequence: "A small kindness.",
                                   coinDelta: -1, reputationDelta: [7: 2], rumorIdReward: 117, setFlag: nil),
                    InnEventOption(label: "Send for the hunter at the bar.",
                                   consequence: "Two stories in one room.",
                                   coinDelta: 4, reputationDelta: [8: 2], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Dismiss him as a child's tale.",
                                   consequence: "He leaves with tears.",
                                   coinDelta: 0, reputationDelta: [7: -3], rumorIdReward: nil, setFlag: nil)
                 ], weight: 3),
        InnEvent(id: 36, title: "Counterfeit Mark Surfaces",
                 body: "A guest pays with a coin that rings wrong.",
                 category: "danger",
                 options: [
                    InnEventOption(label: "Demand a true mark.",
                                   consequence: "He apologizes. He pays.",
                                   coinDelta: 4, reputationDelta: [:], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Accept it. Pass it later.",
                                   consequence: "Risky. Useful.",
                                   coinDelta: 4, reputationDelta: [3: -1], rumorIdReward: 24, setFlag: "passedCounterfeit"),
                    InnEventOption(label: "Walk him to the constable.",
                                   consequence: "Bounty. Bad gossip at the bar.",
                                   coinDelta: 9, reputationDelta: [3: -3, 4: 2], rumorIdReward: nil, setFlag: nil)
                 ], weight: 3),
        InnEvent(id: 37, title: "Friars Bring News",
                 body: "Two friars from Wickbrook deliver a wax-sealed message — they will not say from whom.",
                 category: "social",
                 options: [
                    InnEventOption(label: "Accept. Don't open.",
                                   consequence: "A clean transaction.",
                                   coinDelta: 6, reputationDelta: [6: 2], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Refuse.",
                                   consequence: "They go. They remember.",
                                   coinDelta: 0, reputationDelta: [6: -3], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Accept. Open by candlelight.",
                                   consequence: "Names. Places.",
                                   coinDelta: 6, reputationDelta: [6: -2], rumorIdReward: 47, setFlag: nil)
                 ], weight: 3),
        InnEvent(id: 38, title: "Off-Duty Constable's Story",
                 body: "A constable, off-duty, tells you who has been bribing whom for a fortnight.",
                 category: "danger",
                 options: [
                    InnEventOption(label: "Listen. Pour another.",
                                   consequence: "Names lodge in your ear.",
                                   coinDelta: -2, reputationDelta: [3: 2], rumorIdReward: 90, setFlag: nil),
                    InnEventOption(label: "Stop him. He needs to sober.",
                                   consequence: "He stops. He's grateful.",
                                   coinDelta: 0, reputationDelta: [3: 1], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Take notes in your back-ledger.",
                                   consequence: "Risky. Useful.",
                                   coinDelta: -2, reputationDelta: [3: 1, 4: -1], rumorIdReward: 94, setFlag: nil)
                 ], weight: 3),
        InnEvent(id: 39, title: "Crows on the Roof",
                 body: "Three dozen crows have settled on the roof. They have not moved in two hours.",
                 category: "weather",
                 options: [
                    InnEventOption(label: "Send the stableboy to shoo them.",
                                   consequence: "They scatter. They return.",
                                   coinDelta: 0, reputationDelta: [:], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Leave them be. Let them be omen.",
                                   consequence: "Guests murmur.",
                                   coinDelta: 4, reputationDelta: [6: 2], rumorIdReward: 76, setFlag: nil),
                    InnEventOption(label: "Pay a friar to bless the eaves.",
                                   consequence: "Crows go. Coin goes.",
                                   coinDelta: -6, reputationDelta: [6: 1], rumorIdReward: nil, setFlag: nil)
                 ], weight: 3),
        InnEvent(id: 40, title: "Foreign Merchant's Offer",
                 body: "A foreigner wants your sign moved closer to the gate. He'll pay for the post.",
                 category: "trade",
                 options: [
                    InnEventOption(label: "Take the coin. Move the sign.",
                                   consequence: "More traffic. More questions.",
                                   coinDelta: 16, reputationDelta: [4: -2], rumorIdReward: 31, setFlag: nil),
                    InnEventOption(label: "Refuse.",
                                   consequence: "He shrugs.",
                                   coinDelta: 0, reputationDelta: [4: 1], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Ask why he cares.",
                                   consequence: "He laughs. He answers.",
                                   coinDelta: 0, reputationDelta: [4: 0], rumorIdReward: 26, setFlag: nil)
                 ], weight: 3),
        InnEvent(id: 41, title: "Two Couriers Arrive at Once",
                 body: "Both bear the same crown sigil. Both bear different writs.",
                 category: "royal",
                 options: [
                    InnEventOption(label: "Send them to separate rooms.",
                                   consequence: "Calm settled.",
                                   coinDelta: 6, reputationDelta: [4: 2], rumorIdReward: 18, setFlag: nil),
                    InnEventOption(label: "Quietly tip the second courier off.",
                                   consequence: "He leaves first.",
                                   coinDelta: 4, reputationDelta: [4: -1], rumorIdReward: 7, setFlag: nil),
                    InnEventOption(label: "Let them notice each other.",
                                   consequence: "A scene.",
                                   coinDelta: 0, reputationDelta: [4: -3], rumorIdReward: nil, setFlag: nil)
                 ], weight: 3),
        InnEvent(id: 42, title: "Storm of Letters",
                 body: "A letter-carrier dumps a sack of returned post on your table. Three are addressed to dead men.",
                 category: "trade",
                 options: [
                    InnEventOption(label: "Open them by candle.",
                                   consequence: "You learn three things you should not.",
                                   coinDelta: 0, reputationDelta: [4: -1], rumorIdReward: 17, setFlag: "openedDeadLetters"),
                    InnEventOption(label: "Refuse — return the sack.",
                                   consequence: "Tedious. Honest.",
                                   coinDelta: 2, reputationDelta: [4: 2], rumorIdReward: nil, setFlag: nil),
                    InnEventOption(label: "Sell the sack to the chronicler.",
                                   consequence: "Quick coin. Slow regret.",
                                   coinDelta: 12, reputationDelta: [4: -3], rumorIdReward: nil, setFlag: nil)
                 ], weight: 3),
    ]

    // MARK: - 20 Upgrades
    static let upgrades: [InnUpgrade] = [
        InnUpgrade(id: 1,  name: "Kitchen Expansion",     blurb: "Two new spits. Meals satisfy more hunger.",        cost: 80,  prereqRevenue: 50),
        InnUpgrade(id: 2,  name: "Cellar",                 blurb: "Drinks keep longer. Stock cap raised.",            cost: 120, prereqRevenue: 100),
        InnUpgrade(id: 3,  name: "Wine Cabinet",           blurb: "Wine and brandy sell at higher mark-up.",          cost: 95,  prereqRevenue: 80),
        InnUpgrade(id: 4,  name: "Fireplace Mantle",       blurb: "Common room mood + 6.",                            cost: 60,  prereqRevenue: 40),
        InnUpgrade(id: 5,  name: "Stained-Glass Window",   blurb: "Friars and monks pay 25% more nightly.",           cost: 140, prereqRevenue: 150),
        InnUpgrade(id: 6,  name: "Sign Painter",           blurb: "Daily roster size + 1 in clear weather.",          cost: 70,  prereqRevenue: 60),
        InnUpgrade(id: 7,  name: "Additional Well",        blurb: "Water always available, no drought penalty.",      cost: 90,  prereqRevenue: 110),
        InnUpgrade(id: 8,  name: "Armorer's Nook",         blurb: "Mercenaries and bounty hunters stay an extra day.", cost: 110, prereqRevenue: 130),
        InnUpgrade(id: 9,  name: "Chess Board",            blurb: "Astronomers and magi pay +4 silver each visit.",   cost: 30,  prereqRevenue: 30),
        InnUpgrade(id: 10, name: "Smoke-Sealed Lintel",    blurb: "Reduces brawl chance by 30%.",                     cost: 75,  prereqRevenue: 80),
        InnUpgrade(id: 11, name: "Wax-Seal Strongbox",     blurb: "Royal couriers can leave letters here for fee.",   cost: 100, prereqRevenue: 120),
        InnUpgrade(id: 12, name: "Back-Parlor Curtains",   blurb: "Spies + embassies stay willingly.",                cost: 130, prereqRevenue: 160),
        InnUpgrade(id: 13, name: "Carved Bar Rail",        blurb: "Common room mood + 8.",                            cost: 95,  prereqRevenue: 130),
        InnUpgrade(id: 14, name: "Bell-and-Lamp",          blurb: "Earlier warning for stable-fire events.",          cost: 55,  prereqRevenue: 60),
        InnUpgrade(id: 15, name: "Roof Watchtower",        blurb: "Astronomers stay an extra night.",                 cost: 165, prereqRevenue: 180),
        InnUpgrade(id: 16, name: "Hidden Granary",         blurb: "Bread/oats stock cap doubled.",                    cost: 80,  prereqRevenue: 80),
        InnUpgrade(id: 17, name: "Lockable Larder",        blurb: "Pickled fish stock cap raised. Spoilage avoided.", cost: 65,  prereqRevenue: 70),
        InnUpgrade(id: 18, name: "Salted Yard",            blurb: "Snow and ice clears faster, weather penalty -10%", cost: 70,  prereqRevenue: 90),
        InnUpgrade(id: 19, name: "Pilgrim's Bench",        blurb: "Pilgrims, friars, and monks tip 3 coppers more.",  cost: 50,  prereqRevenue: 50),
        InnUpgrade(id: 20, name: "Sign of the Crossroads", blurb: "Lifetime traffic +1 per day, all weather.",        cost: 200, prereqRevenue: 250),
    ]

    // MARK: - 32 Achievements
    static let achievementsSeed: [InnAchievement] = [
        InnAchievement(id: 1,  name: "First Night",            blurb: "Survive your first day at the crossroads."),
        InnAchievement(id: 2,  name: "Tap House",              blurb: "Reach Prestige Tier 1."),
        InnAchievement(id: 3,  name: "Wayhouse",               blurb: "Reach Prestige Tier 2."),
        InnAchievement(id: 4,  name: "Crossroads Inn",         blurb: "Reach Prestige Tier 3."),
        InnAchievement(id: 5,  name: "Notable Inn",            blurb: "Reach Prestige Tier 4."),
        InnAchievement(id: 6,  name: "Renowned Estate",        blurb: "Reach Prestige Tier 5."),
        InnAchievement(id: 7,  name: "Legend of the Road",     blurb: "Reach Prestige Tier 6."),
        InnAchievement(id: 8,  name: "Hearth and Stew",        blurb: "Serve 25 meals."),
        InnAchievement(id: 9,  name: "Open Door",              blurb: "Host 30 unique guests."),
        InnAchievement(id: 10, name: "Common Tongue",          blurb: "Host one of each archetype."),
        InnAchievement(id: 11, name: "Ledger of Whispers",     blurb: "Capture 20 rumors."),
        InnAchievement(id: 12, name: "Hall of Whispers",       blurb: "Capture 50 rumors."),
        InnAchievement(id: 13, name: "Coin of Tongues",        blurb: "Sell 10 rumors."),
        InnAchievement(id: 14, name: "Master of Marketplaces", blurb: "Sell 50 rumors."),
        InnAchievement(id: 15, name: "Crossroads Reputation",  blurb: "Reach 60 reputation in 4 settlements."),
        InnAchievement(id: 16, name: "Roadlord",               blurb: "Reach 70 reputation in all 8 settlements."),
        InnAchievement(id: 17, name: "Refused the Crown",      blurb: "Refuse a royal scout's bribe."),
        InnAchievement(id: 18, name: "Bastard Found",          blurb: "Resolve The Lord's Bastard with success."),
        InnAchievement(id: 19, name: "Map in Hand",            blurb: "Resolve Smuggler's Map with success."),
        InnAchievement(id: 20, name: "The Quiet Sermon",       blurb: "Resolve The Mendicant Prophet with success."),
        InnAchievement(id: 21, name: "Peace at the Road",      blurb: "Resolve The Northern Road War with success."),
        InnAchievement(id: 22, name: "Beast at Bay",           blurb: "Resolve The Wolfwood Beast with success."),
        InnAchievement(id: 23, name: "Full Common Room",       blurb: "Have 6 guests dining at once."),
        InnAchievement(id: 24, name: "Full House",             blurb: "Have all 8 rooms occupied at once."),
        InnAchievement(id: 25, name: "Stocked",                blurb: "Hold 20 of each drink type."),
        InnAchievement(id: 26, name: "Pantry of Plenty",       blurb: "Hold 15 of each food type."),
        InnAchievement(id: 27, name: "The Long Year",          blurb: "Survive 100 days."),
        InnAchievement(id: 28, name: "Year-Round Hospitality", blurb: "Survive a season of each kind of weather."),
        InnAchievement(id: 29, name: "Quiet Knife",            blurb: "Save a guest from a bounty hunter."),
        InnAchievement(id: 30, name: "Open Pantry",            blurb: "Feed 20 pilgrims at no cost."),
        InnAchievement(id: 31, name: "Map of the Crossroads",  blurb: "Buy the Sign of the Crossroads upgrade."),
        InnAchievement(id: 32, name: "Witness",                blurb: "Hold a rumor with three corroborations."),
    ]

    // MARK: - 26 Quests (meta-arc: the Old Apprentice)
    static let questsSeed: [InnQuest] = [
        InnQuest(id: 1,  title: "A Cold Bed",             body: "Make up the first room. Light the first hearth.", rewardCoin: 6,  prereqLifetimeRevenue: 0),
        InnQuest(id: 2,  title: "First Stew",             body: "Add a stew to your menu.",                        rewardCoin: 8,  prereqLifetimeRevenue: 5),
        InnQuest(id: 3,  title: "Three Cups",             body: "Serve 3 drinks in a single day.",                 rewardCoin: 6,  prereqLifetimeRevenue: 10),
        InnQuest(id: 4,  title: "The First Guest",        body: "Host any guest overnight.",                       rewardCoin: 10, prereqLifetimeRevenue: 12),
        InnQuest(id: 5,  title: "A Whisper Heard",        body: "Capture your first rumor.",                       rewardCoin: 14, prereqLifetimeRevenue: 20),
        InnQuest(id: 6,  title: "Bargain Struck",         body: "Sell a rumor for the first time.",                rewardCoin: 18, prereqLifetimeRevenue: 30),
        InnQuest(id: 7,  title: "The Long Stew",          body: "Serve 10 meals.",                                 rewardCoin: 22, prereqLifetimeRevenue: 40),
        InnQuest(id: 8,  title: "A Maid's Hand",          body: "Hire a maid.",                                    rewardCoin: 14, prereqLifetimeRevenue: 50),
        InnQuest(id: 9,  title: "Open Stables",           body: "Hire a stableboy.",                               rewardCoin: 14, prereqLifetimeRevenue: 60),
        InnQuest(id: 10, title: "The Old Apprentice",     body: "An old man arrives looking for his master's inn.", rewardCoin: 30, prereqLifetimeRevenue: 80),
        InnQuest(id: 11, title: "A Better Bar",           body: "Upgrade one table.",                              rewardCoin: 16, prereqLifetimeRevenue: 90),
        InnQuest(id: 12, title: "Featherbed",             body: "Upgrade a room to featherbed.",                   rewardCoin: 22, prereqLifetimeRevenue: 120),
        InnQuest(id: 13, title: "The Cellar",             body: "Buy the cellar upgrade.",                         rewardCoin: 30, prereqLifetimeRevenue: 150),
        InnQuest(id: 14, title: "Crossroad Sign",         body: "Buy the sign painter upgrade.",                   rewardCoin: 14, prereqLifetimeRevenue: 80),
        InnQuest(id: 15, title: "Friend of the Crier",    body: "Have town crier rep over 40 in Greyhollow.",      rewardCoin: 20, prereqLifetimeRevenue: 100),
        InnQuest(id: 16, title: "Three Whispers",         body: "Hold 3 captured rumors.",                         rewardCoin: 18, prereqLifetimeRevenue: 60),
        InnQuest(id: 17, title: "Eight Whispers",         body: "Hold 8 captured rumors.",                         rewardCoin: 30, prereqLifetimeRevenue: 120),
        InnQuest(id: 18, title: "The Sealed Letter",      body: "Accept a sealed letter for the strongbox.",        rewardCoin: 16, prereqLifetimeRevenue: 140),
        InnQuest(id: 19, title: "A Prophet's Sermon",     body: "Allow the prophet to speak.",                     rewardCoin: 22, prereqLifetimeRevenue: 130),
        InnQuest(id: 20, title: "A Crown's Pleasure",     body: "Host a royal courier in the suite.",              rewardCoin: 30, prereqLifetimeRevenue: 200),
        InnQuest(id: 21, title: "Bouncer's Eye",          body: "Hire a bouncer.",                                 rewardCoin: 16, prereqLifetimeRevenue: 170),
        InnQuest(id: 22, title: "Bard for Hire",          body: "Hire a bard.",                                    rewardCoin: 24, prereqLifetimeRevenue: 200),
        InnQuest(id: 23, title: "A Letter to the North",  body: "Hire a letter-carrier.",                          rewardCoin: 22, prereqLifetimeRevenue: 220),
        InnQuest(id: 24, title: "Lookout's Vow",          body: "Hire a lookout.",                                 rewardCoin: 20, prereqLifetimeRevenue: 210),
        InnQuest(id: 25, title: "The Crossroads' Map",    body: "Buy the Sign of the Crossroads upgrade.",         rewardCoin: 60, prereqLifetimeRevenue: 300),
        InnQuest(id: 26, title: "The Old Apprentice's Tale", body: "Resolve any narrative arc.",                  rewardCoin: 80, prereqLifetimeRevenue: 200),
    ]

    // MARK: - Arc endings
    static func endingText(for arc: ArcKind, kind: ArcEndingKind) -> String {
        switch (arc, kind) {
        case (.lordsBastard, .success):
            return "You find the heir at last — the quiet stableboy at Wickbrook. With your dossier in hand, the right doors open. The bastard, restored, takes the manor of Black Holt before harvest. Your inn is named in the new lord's first writ of pardon."
        case (.lordsBastard, .partial):
            return "Pieces fall together, but not in time. The heir is found by another — a hard man with a hard purse — and the manor changes hands without you. Still, you hold half the story; the chronicler buys it well."
        case (.lordsBastard, .failure):
            return "The trail goes cold. The bastard is never named. A rumor lingers — the heir, they say, served you ale once, in a winter you can no longer recall."
        case (.smugglersMap, .success):
            return "All three fragments meet at your bar. The cache lies under the carter's well at Wickbrook. You sell the location to the Underground Broker for a sum that reshapes your year — and the cellar."
        case (.smugglersMap, .partial):
            return "Two fragments. The third is taken by a foreign envoy who came through under a false name. Profit, yes — but a piece is missing, and you know it."
        case (.smugglersMap, .failure):
            return "Pieces scatter. A bandit takes one. A bargeman burns another. The third is glimpsed in a child's pocket and never seen again."
        case (.mendicantProphet, .success):
            return "He preaches from your porch on Saint's Eve. The lord of Old Cinder yields the chapel before solstice. The prophet thanks you, sleeps once in your suite, and walks on. A scroll names your inn."
        case (.mendicantProphet, .partial):
            return "The prophet draws crowds, but a careful magistrate brokers a quiet exile. He goes north, your porch grown famous, your stew sold thrice over each Sunday."
        case (.mendicantProphet, .failure):
            return "He is taken at a crossing south of Far Bell. The chapel is repaired. The story does not survive him. You serve a quieter stew."
        case (.northernRoadWar, .success):
            return "Through letters and rumors, you broker a meeting in your back parlor. The duchies sign a tariff pact under candle. The road reopens. Caravans line up at your gate for a fortnight."
        case (.northernRoadWar, .partial):
            return "The peace is brittle but the worst does not happen. Both duchies suspect the inn knows more than it says. You are taxed lightly, watched closely."
        case (.northernRoadWar, .failure):
            return "Banners are raised. The road is closed for a season. You burn through stock, then through patience, then through coin."
        case (.wolfwoodBeast, .success):
            return "The hermit was right — the Beast is a creature of regret, bound to the gore of the wood. With the hunter and the friar in your common room, you map its circuits. The cage is built. The wood is quiet again."
        case (.wolfwoodBeast, .partial):
            return "It is driven north, not slain. Cattle return to Marsh Reach. The shepherd boy sleeps better. The Beast, however, sleeps somewhere."
        case (.wolfwoodBeast, .failure):
            return "Three more herds gone. The watch is doubled. The road bends from the Wolfwood without anyone naming why. Far Bell quietly closes its gates at dusk."
        }
    }

    // MARK: - Staff name pools
    static let staffFirstNames = [
        "Alric", "Bryn", "Cael", "Donn", "Edra", "Fern", "Galen", "Halla",
        "Inga", "Joran", "Kell", "Lyset", "Maeve", "Noll", "Oren", "Pell",
        "Quill", "Rann", "Sevn", "Thane", "Urs", "Vella", "Wilm", "Yarn"
    ]
    static let staffSurnames = [
        "of the Hollow", "of Three Stones", "of Marsh Reach", "of Far Bell",
        "Wickbrook", "Greyhollow", "of Old Cinder", "of the Bell-Line"
    ]
}
