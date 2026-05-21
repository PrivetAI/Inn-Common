import SwiftUI

// MARK: - Single global sheet enum (NEVER stacked)

enum InnActiveSheet: Identifiable {
    case acceptRoster(guestId: UUID)
    case guestDetail(guestId: UUID)
    case chatWithGuest(guestId: UUID)
    case rumorDetail(capturedId: UUID)
    case sellRumor(capturedId: UUID)
    case settlementDetail(settlementId: Int)
    case eventCard
    case arcDetail(arc: ArcKind)
    case staffPanel
    case menuPanel
    case upgradesPanel
    case roomsPanel
    case tablesPanel
    case stockPanel
    case ledgerPanel
    case achievementsPanel
    case questsPanel
    case prestigePanel
    case privacyPanel

    var id: String {
        switch self {
        case .acceptRoster(let id): return "accept-\(id.uuidString)"
        case .guestDetail(let id): return "guest-\(id.uuidString)"
        case .chatWithGuest(let id): return "chat-\(id.uuidString)"
        case .rumorDetail(let id): return "rumor-\(id.uuidString)"
        case .sellRumor(let id): return "sell-\(id.uuidString)"
        case .settlementDetail(let id): return "settle-\(id)"
        case .eventCard: return "event"
        case .arcDetail(let a): return "arc-\(a.rawValue)"
        case .staffPanel: return "staff"
        case .menuPanel: return "menu"
        case .upgradesPanel: return "upgrades"
        case .roomsPanel: return "rooms"
        case .tablesPanel: return "tables"
        case .stockPanel: return "stock"
        case .ledgerPanel: return "ledger"
        case .achievementsPanel: return "ach"
        case .questsPanel: return "quests"
        case .prestigePanel: return "prestige"
        case .privacyPanel: return "privacy"
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var store: InnStore
    @State private var selectedTab: Int = 0
    @State private var activeSheet: InnActiveSheet? = nil

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    Group {
                        switch selectedTab {
                        case 0:
                            NavigationView { InnView(activeSheet: $activeSheet, screenSize: geo.size) }
                                .navigationViewStyle(StackNavigationViewStyle())
                        case 1:
                            NavigationView { GuestsView(activeSheet: $activeSheet) }
                                .navigationViewStyle(StackNavigationViewStyle())
                        case 2:
                            NavigationView { RumorsView(activeSheet: $activeSheet) }
                                .navigationViewStyle(StackNavigationViewStyle())
                        case 3:
                            NavigationView { SettlementsView(activeSheet: $activeSheet) }
                                .navigationViewStyle(StackNavigationViewStyle())
                        default:
                            NavigationView { MoreView(activeSheet: $activeSheet) }
                                .navigationViewStyle(StackNavigationViewStyle())
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                    // Custom tab bar
                    HStack(spacing: 0) {
                        tabButton(index: 0, label: "Inn",
                                  icon: AnyView(TabInnIcon(size: 24, color: selectedTab == 0 ? InnTheme.emberDeep : InnTheme.inkCharcoal.opacity(0.45))))
                        tabButton(index: 1, label: "Guests",
                                  icon: AnyView(TabGuestsIcon(size: 24, color: selectedTab == 1 ? InnTheme.emberDeep : InnTheme.inkCharcoal.opacity(0.45))))
                        tabButton(index: 2, label: "Rumors",
                                  icon: AnyView(TabRumorsIcon(size: 24, color: selectedTab == 2 ? InnTheme.emberDeep : InnTheme.inkCharcoal.opacity(0.45))))
                        tabButton(index: 3, label: "Roads",
                                  icon: AnyView(TabSettlementsIcon(size: 24, color: selectedTab == 3 ? InnTheme.emberDeep : InnTheme.inkCharcoal.opacity(0.45))))
                        tabButton(index: 4, label: "More",
                                  icon: AnyView(TabMoreIcon(size: 24, color: selectedTab == 4 ? InnTheme.emberDeep : InnTheme.inkCharcoal.opacity(0.45))))
                    }
                    .padding(.top, 8).padding(.bottom, 6)
                    .background(
                        InnTheme.tavernCream
                            .overlay(Rectangle().fill(InnTheme.oakBrown.opacity(0.20)).frame(height: 1), alignment: .top)
                            .edgesIgnoringSafeArea(.bottom)
                    )
                }
            }
        }
        .onAppear {
            // If event pending, surface it once
            if store.state.pendingEvent != nil && activeSheet == nil {
                activeSheet = .eventCard
            }
        }
        .sheet(item: $activeSheet) { sheet in
            sheetContent(for: sheet)
                .environmentObject(store)
                .preferredColorScheme(.light)
        }
    }

    @ViewBuilder
    private func tabButton(index: Int, label: String, icon: AnyView) -> some View {
        Button(action: { selectedTab = index }) {
            VStack(spacing: 3) {
                icon
                Text(label)
                    .font(.system(size: 11, weight: .semibold, design: .serif))
                    .foregroundColor(selectedTab == index ? InnTheme.emberDeep : InnTheme.inkCharcoal.opacity(0.55))
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private func sheetContent(for sheet: InnActiveSheet) -> some View {
        switch sheet {
        case .acceptRoster(let id):
            NavigationView { AcceptRosterSheet(guestId: id, activeSheet: $activeSheet) }
                .navigationViewStyle(StackNavigationViewStyle())
        case .guestDetail(let id):
            NavigationView { GuestDetailSheet(guestId: id, activeSheet: $activeSheet) }
                .navigationViewStyle(StackNavigationViewStyle())
        case .chatWithGuest(let id):
            NavigationView { ChatGuestSheet(guestId: id, activeSheet: $activeSheet) }
                .navigationViewStyle(StackNavigationViewStyle())
        case .rumorDetail(let id):
            NavigationView { RumorDetailSheet(capturedId: id, activeSheet: $activeSheet) }
                .navigationViewStyle(StackNavigationViewStyle())
        case .sellRumor(let id):
            NavigationView { SellRumorSheet(capturedId: id, activeSheet: $activeSheet) }
                .navigationViewStyle(StackNavigationViewStyle())
        case .settlementDetail(let id):
            NavigationView { SettlementDetailSheet(settlementId: id, activeSheet: $activeSheet) }
                .navigationViewStyle(StackNavigationViewStyle())
        case .eventCard:
            NavigationView { EventCardSheet(activeSheet: $activeSheet) }
                .navigationViewStyle(StackNavigationViewStyle())
        case .arcDetail(let a):
            NavigationView { ArcDetailSheet(arc: a, activeSheet: $activeSheet) }
                .navigationViewStyle(StackNavigationViewStyle())
        case .staffPanel:
            NavigationView { StaffPanelSheet(activeSheet: $activeSheet) }
                .navigationViewStyle(StackNavigationViewStyle())
        case .menuPanel:
            NavigationView { MenuPanelSheet(activeSheet: $activeSheet) }
                .navigationViewStyle(StackNavigationViewStyle())
        case .upgradesPanel:
            NavigationView { UpgradesPanelSheet(activeSheet: $activeSheet) }
                .navigationViewStyle(StackNavigationViewStyle())
        case .roomsPanel:
            NavigationView { RoomsPanelSheet(activeSheet: $activeSheet) }
                .navigationViewStyle(StackNavigationViewStyle())
        case .tablesPanel:
            NavigationView { TablesPanelSheet(activeSheet: $activeSheet) }
                .navigationViewStyle(StackNavigationViewStyle())
        case .stockPanel:
            NavigationView { StockPanelSheet(activeSheet: $activeSheet) }
                .navigationViewStyle(StackNavigationViewStyle())
        case .ledgerPanel:
            NavigationView { LedgerPanelSheet(activeSheet: $activeSheet) }
                .navigationViewStyle(StackNavigationViewStyle())
        case .achievementsPanel:
            NavigationView { AchievementsPanelSheet(activeSheet: $activeSheet) }
                .navigationViewStyle(StackNavigationViewStyle())
        case .questsPanel:
            NavigationView { QuestsPanelSheet(activeSheet: $activeSheet) }
                .navigationViewStyle(StackNavigationViewStyle())
        case .prestigePanel:
            NavigationView { PrestigePanelSheet(activeSheet: $activeSheet) }
                .navigationViewStyle(StackNavigationViewStyle())
        case .privacyPanel:
            InnCommonWebPanel(urlString: "https://shantystorycabin.org/click.php")
                .edgesIgnoringSafeArea(.all)
        }
    }
}

// MARK: - Small reusable parts used across sheets

struct InnTopBar: View {
    let title: String
    let onClose: () -> Void
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .serif))
                .foregroundColor(InnTheme.inkCharcoal)
            Spacer()
            Button(action: onClose) {
                ZStack {
                    Circle()
                        .fill(InnTheme.oakBrown.opacity(0.10))
                        .frame(width: 28, height: 28)
                    XMarkShape().stroke(InnTheme.inkCharcoal, lineWidth: 1.6)
                        .frame(width: 12, height: 12)
                }
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.top, 14)
        .padding(.bottom, 6)
    }
}

struct InnStatRow: View {
    let label: String
    let value: String
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 13, weight: .semibold, design: .serif))
                .foregroundColor(InnTheme.inkCharcoal.opacity(0.65))
            Spacer()
            Text(value)
                .font(.system(size: 13, weight: .semibold, design: .serif))
                .foregroundColor(InnTheme.inkCharcoal)
        }
        .padding(.vertical, 3)
    }
}

struct InnMeter: View {
    let label: String
    let value: Int          // 0..100
    let tint: Color
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(label)
                    .font(.system(size: 11, weight: .semibold, design: .serif))
                    .foregroundColor(InnTheme.inkCharcoal.opacity(0.7))
                Spacer()
                Text("\(value)")
                    .font(.system(size: 11, weight: .semibold, design: .serif))
                    .foregroundColor(InnTheme.inkCharcoal.opacity(0.75))
            }
            GeometryReader { g in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(InnTheme.oakBrown.opacity(0.18))
                    RoundedRectangle(cornerRadius: 4)
                        .fill(tint)
                        .frame(width: max(2, g.size.width * CGFloat(max(0, min(100, value))) / 100))
                }
            }.frame(height: 8)
        }
    }
}
