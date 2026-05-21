import SwiftUI

struct InnView: View {
    @EnvironmentObject var store: InnStore
    @Binding var activeSheet: InnActiveSheet?
    let screenSize: CGSize

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    headerCard
                    illustration
                    statsRow
                    todayCard
                    pendingEventCard
                    rosterCard
                    quickGrid
                }
                .padding(.horizontal, 14)
                .padding(.top, 14)
                .padding(.bottom, 28)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
    }

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline) {
                Text("Inn Common")
                    .font(.system(size: 24, weight: .bold, design: .serif))
                    .foregroundColor(InnTheme.inkCharcoal)
                Spacer()
                InnPill(label: "Y\(store.state.year) D\(store.state.day)",
                        bg: InnTheme.hearthGold.opacity(0.40))
            }
            Text("At the trade crossroads, beside the Wolfwood and the Northern Road.")
                .font(.system(size: 12, weight: .regular, design: .serif))
                .foregroundColor(InnTheme.inkCharcoal.opacity(0.65))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .innCard()
    }

    // Canvas, anchored to parent's screenSize.width — NOT the closure's `size`.
    private var illustration: some View {
        let canvasWidth = max(280, screenSize.width - 28)
        let canvasHeight: CGFloat = 132
        return Canvas { ctx, size in
            // Background sky
            let dayProgress = CGFloat(store.state.day % 100) / 100.0
            ctx.fill(Path(CGRect(origin: .zero, size: size)),
                     with: .linearGradient(Gradient(colors: [
                        Color(hue: 0.07 + Double(dayProgress) * 0.05, saturation: 0.40, brightness: 0.75),
                        InnTheme.hearthGold.opacity(0.70)
                     ]), startPoint: .zero, endPoint: CGPoint(x: 0, y: size.height)))
            // Ground
            ctx.fill(Path(CGRect(x: 0, y: size.height * 0.65, width: size.width, height: size.height * 0.35)),
                     with: .color(InnTheme.mossyStone.opacity(0.65)))
            // Sun / moon
            let sunX = canvasWidth * 0.85
            let sunY = canvasHeight * 0.30
            ctx.fill(Path(ellipseIn: CGRect(x: sunX - 14, y: sunY - 14, width: 28, height: 28)),
                     with: .color(InnTheme.candleCream))
            // Inn silhouette
            let innRect = CGRect(x: canvasWidth * 0.18, y: canvasHeight * 0.22,
                                 width: canvasWidth * 0.45, height: canvasHeight * 0.58)
            var inn = Path()
            inn.move(to: CGPoint(x: innRect.minX, y: innRect.maxY))
            inn.addLine(to: CGPoint(x: innRect.minX, y: innRect.minY + innRect.height * 0.40))
            inn.addLine(to: CGPoint(x: innRect.midX, y: innRect.minY))
            inn.addLine(to: CGPoint(x: innRect.maxX, y: innRect.minY + innRect.height * 0.40))
            inn.addLine(to: CGPoint(x: innRect.maxX, y: innRect.maxY))
            inn.closeSubpath()
            ctx.fill(inn, with: .color(InnTheme.oakBrown))
            ctx.stroke(inn, with: .color(InnTheme.oakBrownDark), lineWidth: 1.4)
            // Window glow if night-ish
            let glow = CGRect(x: innRect.midX - 12, y: innRect.minY + innRect.height * 0.55, width: 24, height: 14)
            ctx.fill(Path(roundedRect: glow, cornerSize: CGSize(width: 3, height: 3)),
                     with: .color(InnTheme.emberRed.opacity(0.85)))
            // Tree (Wolfwood) on the right
            let trunk = CGRect(x: canvasWidth * 0.75, y: canvasHeight * 0.55, width: 8, height: 30)
            ctx.fill(Path(roundedRect: trunk, cornerSize: CGSize(width: 2, height: 2)),
                     with: .color(InnTheme.oakBrownDark))
            ctx.fill(Path(ellipseIn: CGRect(x: canvasWidth * 0.71, y: canvasHeight * 0.35,
                                            width: 36, height: 36)),
                     with: .color(InnTheme.mossyStone))
            // Foot path
            var path = Path()
            path.move(to: CGPoint(x: 0, y: canvasHeight * 0.82))
            path.addQuadCurve(to: CGPoint(x: canvasWidth, y: canvasHeight * 0.88),
                              control: CGPoint(x: canvasWidth * 0.5, y: canvasHeight * 0.78))
            ctx.stroke(path, with: .color(InnTheme.candleCream.opacity(0.85)), lineWidth: 4)
        }
        .frame(width: canvasWidth, height: canvasHeight)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(InnTheme.oakBrown.opacity(0.40), lineWidth: 1)
        )
    }

    private var statsRow: some View {
        HStack(spacing: 10) {
            statCell(icon: AnyView(CoinShape().stroke(InnTheme.hearthGoldDeep, lineWidth: 1.5)),
                     label: "Coins", value: "\(store.state.coins)")
            statCell(icon: AnyView(StarShape().stroke(InnTheme.emberRed, lineWidth: 1.5)),
                     label: "Prestige",
                     value: InnEngine.prestigeLabel(store.state.prestigeTier))
            statCell(icon: AnyView(ScrollShape().stroke(InnTheme.oakBrownDark, lineWidth: 1.5)),
                     label: "Rumors", value: "\(store.state.capturedRumors.count)")
        }
    }

    private func statCell(icon: AnyView, label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                icon.frame(width: 16, height: 16)
                Text(label)
                    .font(.system(size: 11, weight: .semibold, design: .serif))
                    .foregroundColor(InnTheme.inkCharcoal.opacity(0.65))
            }
            Text(value)
                .font(.system(size: 15, weight: .bold, design: .serif))
                .foregroundColor(InnTheme.inkCharcoal)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .innCard()
    }

    private var todayCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            InnSectionHeader(title: "Today", sub: store.state.weather.label)
            HStack {
                InnPill(label: store.state.weather.label, bg: InnTheme.mossyStone.opacity(0.30))
                InnPill(label: "Roster \(store.state.roster.count)", bg: InnTheme.hearthGold.opacity(0.30))
                InnPill(label: "Guests \(store.state.guests.count)/\(store.state.rooms.count)",
                        bg: InnTheme.emberRed.opacity(0.30))
                Spacer()
            }
            Button(action: { store.advanceDay() }) {
                HStack {
                    LanternShape().stroke(InnTheme.candleCream, lineWidth: 1.4)
                        .frame(width: 18, height: 18)
                    Text("Advance Day")
                        .font(.system(size: 15, weight: .semibold, design: .serif))
                }
            }
            .buttonStyle(InnButtonStyle(fill: InnTheme.emberDeep, fg: InnTheme.candleCream))
        }
        .innCard()
    }

    @ViewBuilder
    private var pendingEventCard: some View {
        if let pe = store.state.pendingEvent,
           let event = InnCatalog.events.first(where: { $0.id == pe.eventId }) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    InnPill(label: event.category.capitalized, bg: InnTheme.emberRed.opacity(0.35))
                    Spacer()
                    InnPill(label: "Today", bg: InnTheme.hearthGold.opacity(0.35))
                }
                Text(event.title)
                    .font(.system(size: 17, weight: .bold, design: .serif))
                    .foregroundColor(InnTheme.inkCharcoal)
                Text(event.body)
                    .font(.system(size: 13, weight: .regular, design: .serif))
                    .foregroundColor(InnTheme.inkCharcoal.opacity(0.75))
                Button(action: { activeSheet = .eventCard }) {
                    Text("Open Card")
                }
                .buttonStyle(InnGhostButtonStyle())
            }
            .innCard(tone: InnTheme.candleCream)
        }
    }

    @ViewBuilder
    private var rosterCard: some View {
        if !store.state.roster.isEmpty {
            VStack(alignment: .leading, spacing: 10) {
                InnSectionHeader(title: "Arrivals", sub: "Tap to inspect and accept")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(store.state.roster) { g in
                            let arch = InnCatalog.archetype(g.archetypeId)
                            Button(action: { activeSheet = .acceptRoster(guestId: g.id) }) {
                                VStack(alignment: .leading, spacing: 6) {
                                    GuestPortrait(archetype: arch, size: 78)
                                    Text(arch.name)
                                        .font(.system(size: 12, weight: .semibold, design: .serif))
                                        .foregroundColor(InnTheme.inkCharcoal)
                                        .lineLimit(1)
                                    Text(arch.title)
                                        .font(.system(size: 10, weight: .regular, design: .serif))
                                        .foregroundColor(InnTheme.inkCharcoal.opacity(0.65))
                                        .lineLimit(1)
                                }
                                .frame(width: 110, alignment: .leading)
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(InnTheme.tavernCream)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(InnTheme.oakBrown.opacity(0.25), lineWidth: 1)
                                        )
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .innCard()
        }
    }

    private var quickGrid: some View {
        VStack(alignment: .leading, spacing: 10) {
            InnSectionHeader(title: "The House")
            let cols = [GridItem(.flexible()), GridItem(.flexible())]
            LazyVGrid(columns: cols, spacing: 10) {
                quickCell(label: "Rooms",   icon: AnyView(DoorShape().stroke(InnTheme.oakBrown, lineWidth: 1.4))) { activeSheet = .roomsPanel }
                quickCell(label: "Tables",  icon: AnyView(TableShape().stroke(InnTheme.oakBrown, lineWidth: 1.4))) { activeSheet = .tablesPanel }
                quickCell(label: "Menu",    icon: AnyView(PlateShape().stroke(InnTheme.oakBrown, lineWidth: 1.4))) { activeSheet = .menuPanel }
                quickCell(label: "Stock",   icon: AnyView(MugShape().stroke(InnTheme.oakBrown, lineWidth: 1.4))) { activeSheet = .stockPanel }
                quickCell(label: "Staff",   icon: AnyView(ShieldShape().stroke(InnTheme.oakBrown, lineWidth: 1.4))) { activeSheet = .staffPanel }
                quickCell(label: "Upgrades", icon: AnyView(StarShape().stroke(InnTheme.oakBrown, lineWidth: 1.4))) { activeSheet = .upgradesPanel }
            }
        }
        .innCard()
    }

    private func quickCell(label: String, icon: AnyView, onTap: @escaping () -> Void) -> some View {
        Button(action: onTap) {
            HStack(spacing: 10) {
                icon.frame(width: 22, height: 22)
                Text(label)
                    .font(.system(size: 14, weight: .semibold, design: .serif))
                    .foregroundColor(InnTheme.inkCharcoal)
                Spacer()
                ChevronShape(pointingRight: true)
                    .stroke(InnTheme.inkCharcoal.opacity(0.40), lineWidth: 1.6)
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
}
