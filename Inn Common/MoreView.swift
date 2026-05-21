import SwiftUI

struct MoreView: View {
    @EnvironmentObject var store: InnStore
    @Binding var activeSheet: InnActiveSheet?
    @State private var confirmReset: Bool = false

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 12) {
                    headerCard
                    cellGrid
                    aboutCard
                    if confirmReset {
                        resetConfirmCard
                    } else {
                        Button(action: { confirmReset = true }) {
                            HStack {
                                XMarkShape().stroke(InnTheme.candleCream, lineWidth: 1.6)
                                    .frame(width: 12, height: 12)
                                Text("Reset Progress")
                            }
                        }
                        .buttonStyle(InnButtonStyle(fill: InnTheme.emberDeep, fg: InnTheme.candleCream))
                    }
                }
                .padding(.horizontal, 14)
                .padding(.top, 14)
                .padding(.bottom, 28)
            }
        }
        .navigationBarHidden(true)
    }

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("More")
                    .font(.system(size: 22, weight: .bold, design: .serif))
                    .foregroundColor(InnTheme.inkCharcoal)
                Spacer()
                InnPill(label: InnEngine.prestigeLabel(store.state.prestigeTier),
                        fg: InnTheme.candleCream,
                        bg: InnTheme.oakBrown)
            }
            Text("Hub for upgrades, prestige, quests, achievements, and the ledger.")
                .font(.system(size: 12, weight: .regular, design: .serif))
                .foregroundColor(InnTheme.inkCharcoal.opacity(0.65))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .innCard()
    }

    private var cellGrid: some View {
        let cols = [GridItem(.flexible()), GridItem(.flexible())]
        return LazyVGrid(columns: cols, spacing: 10) {
            cell("Prestige", AnyView(StarShape().stroke(InnTheme.oakBrown, lineWidth: 1.4)))
                { activeSheet = .prestigePanel }
            cell("Upgrades", AnyView(ShieldShape().stroke(InnTheme.oakBrown, lineWidth: 1.4)))
                { activeSheet = .upgradesPanel }
            cell("Quests",   AnyView(QuillShape().stroke(InnTheme.oakBrown, lineWidth: 1.4)))
                { activeSheet = .questsPanel }
            cell("Achievements", AnyView(LanternShape().stroke(InnTheme.oakBrown, lineWidth: 1.4)))
                { activeSheet = .achievementsPanel }
            cell("Staff",    AnyView(HeartShape().stroke(InnTheme.oakBrown, lineWidth: 1.4)))
                { activeSheet = .staffPanel }
            cell("Menu",     AnyView(PlateShape().stroke(InnTheme.oakBrown, lineWidth: 1.4)))
                { activeSheet = .menuPanel }
            cell("Stock",    AnyView(MugShape().stroke(InnTheme.oakBrown, lineWidth: 1.4)))
                { activeSheet = .stockPanel }
            cell("Ledger",   AnyView(CoinShape().stroke(InnTheme.oakBrown, lineWidth: 1.4)))
                { activeSheet = .ledgerPanel }
            cell("Privacy",  AnyView(PadlockShape().stroke(InnTheme.oakBrown, lineWidth: 1.4)))
                { activeSheet = .privacyPanel }
            cell("Rooms",    AnyView(DoorShape().stroke(InnTheme.oakBrown, lineWidth: 1.4)))
                { activeSheet = .roomsPanel }
        }
    }

    private func cell(_ label: String, _ icon: AnyView, _ onTap: @escaping () -> Void) -> some View {
        Button(action: onTap) {
            HStack(spacing: 10) {
                icon.frame(width: 22, height: 22)
                Text(label)
                    .font(.system(size: 14, weight: .semibold, design: .serif))
                    .foregroundColor(InnTheme.inkCharcoal)
                Spacer()
                ChevronShape(pointingRight: true)
                    .stroke(InnTheme.inkCharcoal.opacity(0.4), lineWidth: 1.4)
                    .frame(width: 9, height: 13)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(InnTheme.tavernCream)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(InnTheme.oakBrown.opacity(0.25), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(.plain)
    }

    private var aboutCard: some View {
        VStack(alignment: .leading, spacing: 6) {
            InnSectionHeader(title: "About the Inn")
            Text("Inn Common is a quiet, slow-burn management sim. There is no clock and no fail state — only the road, the rumors, and the year that turns under your roof.")
                .font(.system(size: 12, weight: .regular, design: .serif))
                .foregroundColor(InnTheme.inkCharcoal.opacity(0.75))
            InnStatRow(label: "Day", value: "Y\(store.state.year) D\(store.state.day)")
            InnStatRow(label: "Lifetime Revenue", value: "\(store.state.lifetimeRevenue)c")
            InnStatRow(label: "Rumors Captured", value: "\(store.state.capturedRumors.count)")
            InnStatRow(label: "Rumors Sold", value: "\(store.state.rumorsSold)")
        }
        .innCard()
    }

    private var resetConfirmCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Reset Progress?")
                .font(.system(size: 15, weight: .bold, design: .serif))
            Text("Burning the records returns every guest, rumor, ledger entry, settlement reputation, and arc to the beginning. The action cannot be undone.")
                .font(.system(size: 12, weight: .regular, design: .serif))
                .foregroundColor(InnTheme.inkCharcoal.opacity(0.7))
            HStack {
                Button(action: { confirmReset = false }) {
                    Text("Keep My Inn")
                }
                .buttonStyle(InnGhostButtonStyle())
                Spacer()
                Button(action: {
                    store.resetProgress()
                    confirmReset = false
                }) {
                    Text("Burn the Records")
                }
                .buttonStyle(InnButtonStyle(fill: InnTheme.emberDeep, fg: InnTheme.candleCream))
            }
        }
        .innCard(tone: InnTheme.candleCream)
    }
}

// MARK: - Staff panel

struct StaffPanelSheet: View {
    @EnvironmentObject var store: InnStore
    @Binding var activeSheet: InnActiveSheet?

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                InnTopBar(title: "Staff", onClose: { activeSheet = nil })
                ScrollView {
                    VStack(alignment: .leading, spacing: 14) {
                        VStack(alignment: .leading, spacing: 6) {
                            InnSectionHeader(title: "Employed", sub: "Wages paid weekly")
                            if store.state.staff.isEmpty {
                                Text("No staff employed. Hire to gain weekly abilities.")
                                    .font(.system(size: 12, weight: .regular, design: .serif))
                                    .foregroundColor(InnTheme.inkCharcoal.opacity(0.6))
                            }
                            ForEach(store.state.staff) { s in
                                HStack(spacing: 8) {
                                    ZStack {
                                        Circle().fill(InnTheme.hearthGold.opacity(0.30)).frame(width: 32, height: 32)
                                        Text(s.role.label.prefix(1))
                                            .font(.system(size: 14, weight: .bold, design: .serif))
                                    }
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(s.name)
                                            .font(.system(size: 13, weight: .bold, design: .serif))
                                        Text("\(s.role.label) — \(s.role.weeklyWage)c/wk")
                                            .font(.system(size: 11, weight: .regular, design: .serif))
                                            .foregroundColor(InnTheme.inkCharcoal.opacity(0.6))
                                    }
                                    Spacer()
                                    Button(action: { store.dismissStaff(staffId: s.id) }) {
                                        Text("Dismiss")
                                    }
                                    .buttonStyle(InnGhostButtonStyle())
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        .innCard()

                        VStack(alignment: .leading, spacing: 8) {
                            InnSectionHeader(title: "For Hire", sub: "Signing fee equals one week's wage")
                            ForEach(StaffRole.allCases, id: \.self) { r in
                                hireRow(r)
                            }
                        }
                        .innCard()
                    }
                    .padding(14)
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func hireRow(_ r: StaffRole) -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 2) {
                Text(r.label)
                    .font(.system(size: 13, weight: .bold, design: .serif))
                Text(r.ability)
                    .font(.system(size: 11, weight: .regular, design: .serif))
                    .foregroundColor(InnTheme.inkCharcoal.opacity(0.65))
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(r.weeklyWage)c")
                    .font(.system(size: 12, weight: .semibold, design: .serif))
                Button(action: { store.hireStaff(role: r) }) {
                    Text("Hire")
                }
                .buttonStyle(InnButtonStyle(fill: InnTheme.oakBrown, fg: InnTheme.candleCream))
                .disabled(store.state.coins < r.weeklyWage)
                .opacity(store.state.coins < r.weeklyWage ? 0.5 : 1)
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Menu panel

struct MenuPanelSheet: View {
    @EnvironmentObject var store: InnStore
    @Binding var activeSheet: InnActiveSheet?

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                InnTopBar(title: "Daily Menu", onClose: { activeSheet = nil })
                ScrollView {
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Choose up to six items. Selected items can be served to guests at the table.")
                            .font(.system(size: 12, weight: .regular, design: .serif))
                            .foregroundColor(InnTheme.inkCharcoal.opacity(0.7))
                            .padding(.horizontal, 4)
                        VStack(alignment: .leading, spacing: 6) {
                            InnSectionHeader(title: "Foods")
                            ForEach(InnCatalog.menuItems.filter { $0.kind == "food" }) { mi in
                                menuRow(mi)
                            }
                        }
                        .innCard()
                        VStack(alignment: .leading, spacing: 6) {
                            InnSectionHeader(title: "Drinks")
                            ForEach(InnCatalog.menuItems.filter { $0.kind == "drink" }) { mi in
                                menuRow(mi)
                            }
                        }
                        .innCard()
                    }
                    .padding(14)
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func menuRow(_ mi: MenuItem) -> some View {
        let isOn = store.state.menu.contains(mi.id)
        return Button(action: { store.toggleMenuItem(mi.id) }) {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(InnTheme.oakBrown.opacity(0.6), lineWidth: 1.4)
                        .frame(width: 22, height: 22)
                    if isOn {
                        CheckShape().stroke(InnTheme.emberDeep, lineWidth: 2)
                            .frame(width: 12, height: 12)
                    }
                }
                Text(mi.name)
                    .font(.system(size: 13, weight: .semibold, design: .serif))
                Spacer()
                InnPill(label: "Cost \(mi.costToMake)", bg: InnTheme.mossyStone.opacity(0.25))
                InnPill(label: "Sell \(mi.sellPrice)", bg: InnTheme.hearthGold.opacity(0.30))
            }
            .padding(.vertical, 4)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Rooms panel

struct RoomsPanelSheet: View {
    @EnvironmentObject var store: InnStore
    @Binding var activeSheet: InnActiveSheet?

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                InnTopBar(title: "Rooms", onClose: { activeSheet = nil })
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(store.state.rooms) { r in
                            roomRow(r)
                        }
                    }
                    .padding(14)
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func roomRow(_ r: InnRoom) -> some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(InnTheme.oakBrown.opacity(0.12))
                    .frame(width: 56, height: 56)
                DoorShape().stroke(InnTheme.oakBrown, lineWidth: 1.5)
                    .frame(width: 28, height: 38)
                    .offset(y: 2)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text("Room \(r.id + 1)")
                    .font(.system(size: 14, weight: .bold, design: .serif))
                Text(r.tier.label)
                    .font(.system(size: 12, weight: .regular, design: .serif))
                    .foregroundColor(InnTheme.inkCharcoal.opacity(0.65))
                Text("Nightly \(r.tier.nightlyRate)c · Mood \(r.tier.happinessBase)")
                    .font(.system(size: 11, weight: .regular, design: .serif))
                    .foregroundColor(InnTheme.inkCharcoal.opacity(0.55))
            }
            Spacer()
            if r.tier.upgradeCost > 0 {
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Upgrade \(r.tier.upgradeCost)c")
                        .font(.system(size: 11, weight: .semibold, design: .serif))
                    Button(action: { store.upgradeRoom(roomId: r.id) }) {
                        Text("Upgrade")
                    }
                    .buttonStyle(InnButtonStyle(fill: InnTheme.oakBrown, fg: InnTheme.candleCream))
                    .disabled(store.state.coins < r.tier.upgradeCost)
                    .opacity(store.state.coins < r.tier.upgradeCost ? 0.5 : 1)
                }
            } else {
                InnPill(label: "Top tier", bg: InnTheme.hearthGold.opacity(0.35))
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(InnTheme.tavernCreamSoft)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(InnTheme.oakBrown.opacity(0.22), lineWidth: 1)
                )
        )
    }
}

// MARK: - Tables panel

struct TablesPanelSheet: View {
    @EnvironmentObject var store: InnStore
    @Binding var activeSheet: InnActiveSheet?

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                InnTopBar(title: "Tables", onClose: { activeSheet = nil })
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(store.state.tables) { t in
                            HStack(spacing: 12) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(InnTheme.oakBrown.opacity(0.12))
                                        .frame(width: 56, height: 56)
                                    TableShape().stroke(InnTheme.oakBrown, lineWidth: 1.5)
                                        .frame(width: 36, height: 36)
                                }
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Table \(t.id + 1)")
                                        .font(.system(size: 14, weight: .bold, design: .serif))
                                    Text(t.tier.label)
                                        .font(.system(size: 12, weight: .regular, design: .serif))
                                        .foregroundColor(InnTheme.inkCharcoal.opacity(0.65))
                                    Text("Mood bonus +\(t.tier.moodBonus)")
                                        .font(.system(size: 11, weight: .regular, design: .serif))
                                        .foregroundColor(InnTheme.inkCharcoal.opacity(0.55))
                                }
                                Spacer()
                                if t.tier.upgradeCost > 0 {
                                    VStack(alignment: .trailing, spacing: 4) {
                                        Text("Upgrade \(t.tier.upgradeCost)c")
                                            .font(.system(size: 11, weight: .semibold, design: .serif))
                                        Button(action: { store.upgradeTable(tableId: t.id) }) {
                                            Text("Upgrade")
                                        }
                                        .buttonStyle(InnButtonStyle(fill: InnTheme.oakBrown, fg: InnTheme.candleCream))
                                        .disabled(store.state.coins < t.tier.upgradeCost)
                                        .opacity(store.state.coins < t.tier.upgradeCost ? 0.5 : 1)
                                    }
                                } else {
                                    InnPill(label: "Top tier", bg: InnTheme.hearthGold.opacity(0.35))
                                }
                            }
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(InnTheme.tavernCreamSoft)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(InnTheme.oakBrown.opacity(0.22), lineWidth: 1)
                                    )
                            )
                        }
                    }
                    .padding(14)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Stock panel

struct StockPanelSheet: View {
    @EnvironmentObject var store: InnStore
    @Binding var activeSheet: InnActiveSheet?

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                InnTopBar(title: "Stock", onClose: { activeSheet = nil })
                ScrollView {
                    VStack(alignment: .leading, spacing: 14) {
                        VStack(alignment: .leading, spacing: 4) {
                            InnSectionHeader(title: "Food")
                            stockRowFood("Bread / Grain",  count: store.state.foodStock.bread)
                            { store.restockGeneric(food: \InnFoodStock.bread, amount: 5, cost: 8, memo: "Restocked bread × 5") }
                            stockRowFood("Meat",  count: store.state.foodStock.meat)
                            { store.restockGeneric(food: \InnFoodStock.meat, amount: 3, cost: 12, memo: "Restocked meat × 3") }
                            stockRowFood("Cheese", count: store.state.foodStock.cheese)
                            { store.restockGeneric(food: \InnFoodStock.cheese, amount: 3, cost: 9, memo: "Restocked cheese × 3") }
                            stockRowFood("Fish",   count: store.state.foodStock.fish)
                            { store.restockGeneric(food: \InnFoodStock.fish, amount: 3, cost: 10, memo: "Restocked fish × 3") }
                            stockRowFood("Herbs",  count: store.state.foodStock.herbs)
                            { store.restockGeneric(food: \InnFoodStock.herbs, amount: 3, cost: 6, memo: "Restocked herbs × 3") }
                            stockRowFood("Roots",  count: store.state.foodStock.roots)
                            { store.restockGeneric(food: \InnFoodStock.roots, amount: 5, cost: 6, memo: "Restocked roots × 5") }
                            stockRowFood("Fruit",  count: store.state.foodStock.fruit)
                            { store.restockGeneric(food: \InnFoodStock.fruit, amount: 3, cost: 8, memo: "Restocked fruit × 3") }
                            stockRowFood("Pies",   count: store.state.foodStock.pies)
                            { store.restockGeneric(food: \InnFoodStock.pies, amount: 2, cost: 10, memo: "Restocked pies × 2") }
                        }
                        .innCard()

                        VStack(alignment: .leading, spacing: 4) {
                            InnSectionHeader(title: "Drink")
                            stockRowFood("Ale",     count: store.state.drinkStock.ale)
                            { store.restockDrink(\InnDrinkStock.ale, amount: 6, cost: 6, memo: "Restocked ale × 6") }
                            stockRowFood("Wine",    count: store.state.drinkStock.wine)
                            { store.restockDrink(\InnDrinkStock.wine, amount: 3, cost: 12, memo: "Restocked wine × 3") }
                            stockRowFood("Mead",    count: store.state.drinkStock.mead)
                            { store.restockDrink(\InnDrinkStock.mead, amount: 3, cost: 9, memo: "Restocked mead × 3") }
                            stockRowFood("Cider",   count: store.state.drinkStock.cider)
                            { store.restockDrink(\InnDrinkStock.cider, amount: 4, cost: 7, memo: "Restocked cider × 4") }
                            stockRowFood("Brandy",  count: store.state.drinkStock.brandy)
                            { store.restockDrink(\InnDrinkStock.brandy, amount: 2, cost: 14, memo: "Restocked brandy × 2") }
                            stockRowFood("Water",   count: store.state.drinkStock.water)
                            { store.restockDrink(\InnDrinkStock.water, amount: 8, cost: 3, memo: "Drew water × 8") }
                        }
                        .innCard()

                        VStack(alignment: .leading, spacing: 4) {
                            InnSectionHeader(title: "Sundries")
                            InnStatRow(label: "Firewood", value: "\(store.state.extras.firewood)")
                            InnStatRow(label: "Salt", value: "\(store.state.extras.salt)")
                            InnStatRow(label: "Candles", value: "\(store.state.extras.candles)")
                        }
                        .innCard()
                    }
                    .padding(14)
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func stockRowFood(_ label: String, count: Int, action: @escaping () -> Void) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 13, weight: .semibold, design: .serif))
            Spacer()
            Text("\(count)")
                .font(.system(size: 13, weight: .bold, design: .serif))
            Button(action: action) { Text("Buy") }
                .buttonStyle(InnGhostButtonStyle())
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Upgrades panel

struct UpgradesPanelSheet: View {
    @EnvironmentObject var store: InnStore
    @Binding var activeSheet: InnActiveSheet?

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                InnTopBar(title: "Upgrades", onClose: { activeSheet = nil })
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(InnCatalog.upgrades) { u in
                            upgradeRow(u)
                        }
                    }
                    .padding(14)
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func upgradeRow(_ u: InnUpgrade) -> some View {
        let owned = store.state.unlockedUpgradeIds.contains(u.id)
        let prereqMet = store.state.lifetimeRevenue >= u.prereqRevenue
        let canAfford = store.state.coins >= u.cost
        return VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(u.name)
                    .font(.system(size: 14, weight: .bold, design: .serif))
                Spacer()
                if owned {
                    InnPill(label: "Owned", fg: InnTheme.candleCream, bg: InnTheme.oakBrown)
                } else if !prereqMet {
                    InnPill(label: "Locked", bg: InnTheme.mossyStone.opacity(0.35))
                } else {
                    InnPill(label: "\(u.cost)c", bg: InnTheme.hearthGold.opacity(0.35))
                }
            }
            Text(u.blurb)
                .font(.system(size: 12, weight: .regular, design: .serif))
                .foregroundColor(InnTheme.inkCharcoal.opacity(0.7))
            Text("Requires lifetime revenue \(u.prereqRevenue)c")
                .font(.system(size: 11, weight: .semibold, design: .serif))
                .foregroundColor(InnTheme.inkCharcoal.opacity(0.55))
            if !owned && prereqMet {
                Button(action: { store.purchaseUpgrade(u) }) {
                    Text("Purchase")
                }
                .buttonStyle(InnButtonStyle(fill: InnTheme.oakBrown, fg: InnTheme.candleCream))
                .disabled(!canAfford)
                .opacity(canAfford ? 1 : 0.55)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(InnTheme.tavernCreamSoft)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(InnTheme.oakBrown.opacity(0.25), lineWidth: 1)
                )
        )
    }
}

// MARK: - Quests panel

struct QuestsPanelSheet: View {
    @EnvironmentObject var store: InnStore
    @Binding var activeSheet: InnActiveSheet?

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                InnTopBar(title: "Quests", onClose: { activeSheet = nil })
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(store.state.quests) { q in
                            HStack(spacing: 10) {
                                ZStack {
                                    Circle()
                                        .stroke(q.completed ? InnTheme.hearthGoldDeep : InnTheme.oakBrown.opacity(0.5), lineWidth: 1.4)
                                        .frame(width: 24, height: 24)
                                    if q.completed {
                                        CheckShape().stroke(InnTheme.hearthGoldDeep, lineWidth: 2)
                                            .frame(width: 12, height: 12)
                                    }
                                }
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(q.title)
                                        .font(.system(size: 13, weight: .bold, design: .serif))
                                    Text(q.body)
                                        .font(.system(size: 11, weight: .regular, design: .serif))
                                        .foregroundColor(InnTheme.inkCharcoal.opacity(0.65))
                                }
                                Spacer()
                                InnPill(label: "\(q.rewardCoin)c", bg: InnTheme.hearthGold.opacity(0.30))
                            }
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(InnTheme.tavernCreamSoft)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(InnTheme.oakBrown.opacity(0.2), lineWidth: 1)
                                    )
                            )
                        }
                    }
                    .padding(14)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Achievements panel

struct AchievementsPanelSheet: View {
    @EnvironmentObject var store: InnStore
    @Binding var activeSheet: InnActiveSheet?

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                InnTopBar(title: "Achievements", onClose: { activeSheet = nil })
                let unlockedCount = store.state.achievements.filter { $0.unlocked }.count
                ScrollView {
                    VStack(spacing: 10) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Unlocked \(unlockedCount) / \(store.state.achievements.count)")
                                .font(.system(size: 12, weight: .semibold, design: .serif))
                                .foregroundColor(InnTheme.inkCharcoal.opacity(0.7))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .innCard()
                        ForEach(store.state.achievements) { a in
                            HStack(spacing: 10) {
                                ZStack {
                                    Circle()
                                        .fill(a.unlocked ? InnTheme.hearthGold.opacity(0.4) : InnTheme.oakBrown.opacity(0.10))
                                        .frame(width: 32, height: 32)
                                    StarShape()
                                        .stroke(a.unlocked ? InnTheme.hearthGoldDeep : InnTheme.oakBrown.opacity(0.35), lineWidth: 1.5)
                                        .frame(width: 18, height: 18)
                                }
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(a.name)
                                        .font(.system(size: 13, weight: .bold, design: .serif))
                                        .foregroundColor(a.unlocked ? InnTheme.inkCharcoal : InnTheme.inkCharcoal.opacity(0.55))
                                    Text(a.blurb)
                                        .font(.system(size: 11, weight: .regular, design: .serif))
                                        .foregroundColor(InnTheme.inkCharcoal.opacity(0.6))
                                }
                                Spacer()
                                if a.unlocked {
                                    InnPill(label: "Earned",
                                            fg: InnTheme.candleCream,
                                            bg: InnTheme.hearthGoldDeep)
                                }
                            }
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(InnTheme.tavernCreamSoft)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(InnTheme.oakBrown.opacity(0.2), lineWidth: 1)
                                    )
                            )
                        }
                    }
                    .padding(14)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Prestige panel

struct PrestigePanelSheet: View {
    @EnvironmentObject var store: InnStore
    @Binding var activeSheet: InnActiveSheet?

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                InnTopBar(title: "Prestige", onClose: { activeSheet = nil })
                ScrollView {
                    VStack(spacing: 10) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Current")
                                .font(.system(size: 12, weight: .semibold, design: .serif))
                                .foregroundColor(InnTheme.inkCharcoal.opacity(0.6))
                            HStack {
                                StarShape().fill(InnTheme.hearthGold)
                                    .frame(width: 28, height: 28)
                                Text(InnEngine.prestigeLabel(store.state.prestigeTier))
                                    .font(.system(size: 18, weight: .bold, design: .serif))
                                Spacer()
                                InnPill(label: "Tier \(store.state.prestigeTier)",
                                        fg: InnTheme.candleCream, bg: InnTheme.oakBrown)
                            }
                            InnStatRow(label: "Lifetime Revenue", value: "\(store.state.lifetimeRevenue)c")
                            InnStatRow(label: "Rumors Sold", value: "\(store.state.rumorsSold)")
                        }
                        .innCard()

                        ForEach(0...6, id: \.self) { t in
                            HStack(spacing: 10) {
                                ZStack {
                                    Circle()
                                        .fill(t <= store.state.prestigeTier ? InnTheme.hearthGold.opacity(0.4) : InnTheme.oakBrown.opacity(0.1))
                                        .frame(width: 30, height: 30)
                                    Text("\(t)")
                                        .font(.system(size: 13, weight: .bold, design: .serif))
                                }
                                Text(InnEngine.prestigeLabel(t))
                                    .font(.system(size: 13, weight: .semibold, design: .serif))
                                Spacer()
                                Text(prestigeRequirements(t))
                                    .font(.system(size: 11, weight: .regular, design: .serif))
                                    .foregroundColor(InnTheme.inkCharcoal.opacity(0.6))
                            }
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(InnTheme.tavernCreamSoft)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(InnTheme.oakBrown.opacity(0.2), lineWidth: 1)
                                    )
                            )
                        }
                    }
                    .padding(14)
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func prestigeRequirements(_ tier: Int) -> String {
        switch tier {
        case 0: return "—"
        case 1: return "40c revenue"
        case 2: return "130c + 6 sold"
        case 3: return "280c + 15 sold"
        case 4: return "500c + 30 sold"
        case 5: return "800c + 50 sold"
        case 6: return "1200c + 80 sold"
        default: return "—"
        }
    }
}

// MARK: - Ledger panel

struct LedgerPanelSheet: View {
    @EnvironmentObject var store: InnStore
    @Binding var activeSheet: InnActiveSheet?

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                InnTopBar(title: "Ledger", onClose: { activeSheet = nil })
                ScrollView {
                    VStack(alignment: .leading, spacing: 6) {
                        InnSectionHeader(title: "Recent Entries")
                        if store.state.ledger.isEmpty {
                            Text("The ledger is clean. The lantern is lit.")
                                .font(.system(size: 12, weight: .regular, design: .serif))
                                .foregroundColor(InnTheme.inkCharcoal.opacity(0.55))
                        }
                        ForEach(store.state.ledger.reversed()) { e in
                            HStack {
                                Text("D\(e.day)")
                                    .font(.system(size: 11, weight: .semibold, design: .serif))
                                    .foregroundColor(InnTheme.inkCharcoal.opacity(0.55))
                                Text(e.memo)
                                    .font(.system(size: 12, weight: .regular, design: .serif))
                                    .foregroundColor(InnTheme.inkCharcoal)
                                Spacer()
                                Text("\(e.delta > 0 ? "+" : "")\(e.delta)c")
                                    .font(.system(size: 12, weight: .bold, design: .serif))
                                    .foregroundColor(e.delta >= 0 ? InnTheme.hearthGoldDeep : InnTheme.emberDeep)
                            }
                            .padding(.vertical, 4)
                            Divider().background(InnTheme.oakBrown.opacity(0.15))
                        }
                        InnSectionHeader(title: "Event Log")
                        ForEach(store.state.eventLog.prefix(20), id: \.self) { line in
                            Text(line)
                                .font(.system(size: 12, weight: .regular, design: .serif))
                                .foregroundColor(InnTheme.inkCharcoal.opacity(0.85))
                                .padding(.vertical, 2)
                        }
                    }
                    .padding(14)
                }
            }
        }
        .navigationBarHidden(true)
    }
}
