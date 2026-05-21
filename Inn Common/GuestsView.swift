import SwiftUI

struct GuestsView: View {
    @EnvironmentObject var store: InnStore
    @Binding var activeSheet: InnActiveSheet?
    @State private var section: Int = 0  // 0=guests, 1=arrivals, 2=catalog

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                segmentBar
                ScrollView {
                    VStack(spacing: 12) {
                        if section == 0 { guestsList }
                        else if section == 1 { arrivalsList }
                        else { catalogList }
                    }
                    .padding(.horizontal, 14)
                    .padding(.top, 12)
                    .padding(.bottom, 24)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
    }

    private var segmentBar: some View {
        HStack(spacing: 0) {
            segButton(0, "Guests")
            segButton(1, "Arrivals")
            segButton(2, "Catalog")
        }
        .padding(.horizontal, 14)
        .padding(.top, 12)
    }

    private func segButton(_ idx: Int, _ label: String) -> some View {
        Button(action: { section = idx }) {
            Text(label)
                .font(.system(size: 13, weight: .semibold, design: .serif))
                .foregroundColor(section == idx ? InnTheme.candleCream : InnTheme.inkCharcoal.opacity(0.65))
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(section == idx ? InnTheme.oakBrown : InnTheme.tavernCreamSoft)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(InnTheme.oakBrown.opacity(0.30), lineWidth: 1)
                        )
                )
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 2)
    }

    @ViewBuilder
    private var guestsList: some View {
        if store.state.guests.isEmpty {
            emptyState("No guests in tonight. Welcome a traveler from the Arrivals tab.")
        } else {
            ForEach(store.state.guests) { g in
                let arch = InnCatalog.archetype(g.archetypeId)
                Button(action: { activeSheet = .guestDetail(guestId: g.id) }) {
                    guestRow(g: g, arch: arch)
                }
                .buttonStyle(.plain)
            }
        }
    }

    @ViewBuilder
    private var arrivalsList: some View {
        if store.state.roster.isEmpty {
            emptyState("No new travelers today. Try Advance Day on the Inn tab.")
        } else {
            ForEach(store.state.roster) { g in
                let arch = InnCatalog.archetype(g.archetypeId)
                Button(action: { activeSheet = .acceptRoster(guestId: g.id) }) {
                    guestRow(g: g, arch: arch, arriving: true)
                }
                .buttonStyle(.plain)
            }
        }
    }

    @ViewBuilder
    private var catalogList: some View {
        ForEach(InnCatalog.archetypes) { a in
            HStack(spacing: 12) {
                GuestPortrait(archetype: a, size: 64)
                VStack(alignment: .leading, spacing: 4) {
                    Text(a.name)
                        .font(.system(size: 14, weight: .bold, design: .serif))
                        .foregroundColor(InnTheme.inkCharcoal)
                    Text(a.title)
                        .font(.system(size: 11, weight: .regular, design: .serif))
                        .foregroundColor(InnTheme.inkCharcoal.opacity(0.65))
                    HStack(spacing: 5) {
                        ForEach(a.rumorTags, id: \.self) { t in
                            InnPill(label: t.label, fg: InnTheme.inkCharcoal, bg: t.swatch)
                        }
                    }
                }
                Spacer()
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(InnTheme.tavernCreamSoft)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(InnTheme.oakBrown.opacity(0.20), lineWidth: 1)
                    )
            )
        }
    }

    private func emptyState(_ text: String) -> some View {
        VStack(spacing: 8) {
            ZStack {
                Circle().fill(InnTheme.oakBrown.opacity(0.15)).frame(width: 70, height: 70)
                BuildingShape().stroke(InnTheme.oakBrown, lineWidth: 1.6).frame(width: 38, height: 38)
            }
            Text(text)
                .font(.system(size: 13, weight: .regular, design: .serif))
                .foregroundColor(InnTheme.inkCharcoal.opacity(0.65))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 36)
    }

    private func guestRow(g: InnGuest, arch: InnArchetype, arriving: Bool = false) -> some View {
        HStack(spacing: 12) {
            GuestPortrait(archetype: arch, size: 72)
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Text(arch.name)
                        .font(.system(size: 14, weight: .bold, design: .serif))
                        .foregroundColor(InnTheme.inkCharcoal)
                    if let roomId = g.roomIndex {
                        InnPill(label: "Room \(roomId + 1)", bg: InnTheme.hearthGold.opacity(0.35))
                    } else if arriving {
                        InnPill(label: "Arriving", bg: InnTheme.mossyStone.opacity(0.35))
                    } else {
                        InnPill(label: "Lobby", bg: InnTheme.emberRed.opacity(0.25))
                    }
                }
                Text(arch.title)
                    .font(.system(size: 11, weight: .regular, design: .serif))
                    .foregroundColor(InnTheme.inkCharcoal.opacity(0.65))
                HStack(spacing: 8) {
                    miniMeter(label: "Mood",  v: g.happiness, c: InnTheme.hearthGoldDeep)
                    miniMeter(label: "Need",  v: 100 - g.hunger, c: InnTheme.emberRed)
                }
                .frame(height: 8)
            }
            Spacer()
            ChevronShape(pointingRight: true)
                .stroke(InnTheme.inkCharcoal.opacity(0.40), lineWidth: 1.4)
                .frame(width: 9, height: 13)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(InnTheme.tavernCreamSoft)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(InnTheme.oakBrown.opacity(0.22), lineWidth: 1)
                )
        )
    }

    private func miniMeter(label: String, v: Int, c: Color) -> some View {
        GeometryReader { g in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 3)
                    .fill(InnTheme.oakBrown.opacity(0.18))
                RoundedRectangle(cornerRadius: 3)
                    .fill(c)
                    .frame(width: max(2, g.size.width * CGFloat(max(0, min(100, v))) / 100))
            }
        }
    }
}

// MARK: - Accept roster sheet

struct AcceptRosterSheet: View {
    @EnvironmentObject var store: InnStore
    let guestId: UUID
    @Binding var activeSheet: InnActiveSheet?

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                InnTopBar(title: "Arriving Traveler", onClose: { activeSheet = nil })
                if let g = store.state.roster.first(where: { $0.id == guestId }) {
                    let arch = InnCatalog.archetype(g.archetypeId)
                    ScrollView {
                        VStack(spacing: 14) {
                            HStack(spacing: 14) {
                                GuestPortrait(archetype: arch, size: 116)
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(arch.name)
                                        .font(.system(size: 18, weight: .bold, design: .serif))
                                    Text(arch.title)
                                        .font(.system(size: 12, weight: .regular, design: .serif))
                                        .foregroundColor(InnTheme.inkCharcoal.opacity(0.65))
                                    HStack(spacing: 4) {
                                        ForEach(arch.rumorTags, id: \.self) { t in
                                            InnPill(label: t.label, fg: InnTheme.inkCharcoal, bg: t.swatch)
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .innCard()

                            VStack(alignment: .leading, spacing: 6) {
                                InnSectionHeader(title: "Statures")
                                InnStatRow(label: "Temperament", value: bar(g: arch.temperament))
                                InnStatRow(label: "Generosity",  value: bar(g: arch.generosity))
                                InnStatRow(label: "Gossip Level", value: bar(g: arch.gossipLevel))
                                InnStatRow(label: "Suspicion",   value: bar(g: arch.suspicion))
                            }
                            .innCard()

                            VStack(alignment: .leading, spacing: 8) {
                                InnSectionHeader(title: "Tastes")
                                InnStatRow(label: "Favorite Food",  value: arch.favoriteFood)
                                InnStatRow(label: "Favorite Drink", value: arch.favoriteDrink)
                                InnStatRow(label: "Prefers Room",   value: arch.preferredRoom.label)
                            }
                            .innCard()

                            HStack(spacing: 10) {
                                Button(action: {
                                    store.refuseGuest(g)
                                    activeSheet = nil
                                }) {
                                    HStack {
                                        XMarkShape().stroke(InnTheme.candleCream, lineWidth: 1.6)
                                            .frame(width: 12, height: 12)
                                        Text("Refuse")
                                    }
                                }
                                .buttonStyle(InnButtonStyle(fill: InnTheme.mossyStone, fg: InnTheme.candleCream))

                                Button(action: {
                                    store.acceptGuest(g)
                                    activeSheet = nil
                                }) {
                                    HStack {
                                        CheckShape().stroke(InnTheme.candleCream, lineWidth: 1.8)
                                            .frame(width: 14, height: 14)
                                        Text("Welcome In")
                                    }
                                }
                                .buttonStyle(InnButtonStyle(fill: InnTheme.emberDeep, fg: InnTheme.candleCream))
                            }
                        }
                        .padding(14)
                    }
                } else {
                    Text("No such arrival.")
                        .padding()
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func bar(g: Int) -> String {
        let filled = String(repeating: "■", count: g)
        let empty  = String(repeating: "□", count: max(0, 10 - g))
        return filled + empty
    }
}

// MARK: - Guest detail sheet

struct GuestDetailSheet: View {
    @EnvironmentObject var store: InnStore
    let guestId: UUID
    @Binding var activeSheet: InnActiveSheet?

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                InnTopBar(title: "Guest", onClose: { activeSheet = nil })
                if let g = store.state.guests.first(where: { $0.id == guestId }) {
                    let arch = InnCatalog.archetype(g.archetypeId)
                    ScrollView {
                        VStack(spacing: 14) {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(spacing: 12) {
                                    GuestPortrait(archetype: arch, size: 96)
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(arch.name)
                                            .font(.system(size: 17, weight: .bold, design: .serif))
                                        Text(arch.title)
                                            .font(.system(size: 12, weight: .regular, design: .serif))
                                            .foregroundColor(InnTheme.inkCharcoal.opacity(0.65))
                                        if let r = g.roomIndex {
                                            InnPill(label: "Room \(r + 1)", bg: InnTheme.hearthGold.opacity(0.35))
                                        }
                                    }
                                    Spacer()
                                }
                                InnMeter(label: "Hunger", value: g.hunger, tint: InnTheme.emberRed)
                                InnMeter(label: "Thirst", value: g.thirst, tint: InnTheme.hearthGold)
                                InnMeter(label: "Sleep", value: g.sleep, tint: InnTheme.mossyStone)
                                InnMeter(label: "Happiness", value: g.happiness, tint: InnTheme.hearthGoldDeep)
                            }
                            .innCard()

                            VStack(alignment: .leading, spacing: 10) {
                                InnSectionHeader(title: "Serve from the Menu",
                                                 sub: "Cost deducts stock; pay token cost")
                                VStack(spacing: 6) {
                                    ForEach(activeMenu(), id: \.id) { mi in
                                        HStack {
                                            Text(mi.name)
                                                .font(.system(size: 13, weight: .semibold, design: .serif))
                                            Spacer()
                                            InnPill(label: "+\(mi.sellPrice)c", bg: InnTheme.hearthGold.opacity(0.30))
                                            Button(action: {
                                                _ = store.serveMeal(to: g, itemId: mi.id)
                                            }) {
                                                Text("Serve")
                                            }
                                            .buttonStyle(InnButtonStyle(fill: InnTheme.oakBrown, fg: InnTheme.candleCream))
                                            .disabled(store.state.todayActionToken <= 0)
                                            .opacity(store.state.todayActionToken <= 0 ? 0.5 : 1)
                                        }
                                    }
                                }
                            }
                            .innCard()

                            VStack(alignment: .leading, spacing: 10) {
                                InnSectionHeader(title: "Conversation",
                                                 sub: "Capture rumors via chat actions")
                                Button(action: { activeSheet = .chatWithGuest(guestId: g.id) }) {
                                    HStack {
                                        ScrollShape().stroke(InnTheme.candleCream, lineWidth: 1.6)
                                            .frame(width: 16, height: 16)
                                        Text("Speak with \(arch.name)")
                                    }
                                }
                                .buttonStyle(InnButtonStyle(fill: InnTheme.emberDeep, fg: InnTheme.candleCream))
                            }
                            .innCard()
                        }
                        .padding(14)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func activeMenu() -> [MenuItem] {
        store.state.menu.compactMap { InnCatalog.menuItem($0) }
    }
}

// MARK: - Chat sheet

struct ChatGuestSheet: View {
    @EnvironmentObject var store: InnStore
    let guestId: UUID
    @Binding var activeSheet: InnActiveSheet?
    @State private var lastResultText: String = ""
    @State private var lastWasSuccess: Bool = false

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                InnTopBar(title: "Conversation", onClose: { activeSheet = nil })
                if let g = store.state.guests.first(where: { $0.id == guestId }) {
                    let arch = InnCatalog.archetype(g.archetypeId)
                    ScrollView {
                        VStack(alignment: .leading, spacing: 14) {
                            HStack(spacing: 12) {
                                GuestPortrait(archetype: arch, size: 86)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(arch.name)
                                        .font(.system(size: 16, weight: .bold, design: .serif))
                                    Text("Chat warmth: \(g.chatLevel)/5")
                                        .font(.system(size: 12, weight: .regular, design: .serif))
                                        .foregroundColor(InnTheme.inkCharcoal.opacity(0.70))
                                }
                                Spacer()
                            }
                            .innCard()

                            if !lastResultText.isEmpty {
                                Text(lastResultText)
                                    .font(.system(size: 13, weight: .regular, design: .serif))
                                    .foregroundColor(InnTheme.inkCharcoal)
                                    .padding(12)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(lastWasSuccess ? InnTheme.hearthGold.opacity(0.30) : InnTheme.mossyStone.opacity(0.20))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(InnTheme.oakBrown.opacity(0.3), lineWidth: 1)
                                            )
                                    )
                            }

                            VStack(spacing: 10) {
                                chatAction(.listen,      "Quietly listen near the bar")
                                chatAction(.pourMore,    "Pour them another cup")
                                chatAction(.pressGently, "Ask a careful question")
                                chatAction(.befriend,    "Share a story of your own")
                            }

                            VStack(alignment: .leading, spacing: 6) {
                                InnSectionHeader(title: "Already let slip",
                                                 sub: "\(g.dropped.count) rumor\(g.dropped.count == 1 ? "" : "s")")
                                ForEach(g.dropped, id: \.self) { rid in
                                    if let r = InnCatalog.rumor(rid) {
                                        HStack {
                                            InnPill(label: r.category.label, fg: InnTheme.inkCharcoal, bg: r.category.swatch)
                                            Text(r.summary)
                                                .font(.system(size: 12, weight: .regular, design: .serif))
                                                .foregroundColor(InnTheme.inkCharcoal.opacity(0.85))
                                                .lineLimit(2)
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            .innCard()
                        }
                        .padding(14)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func chatAction(_ action: ChatAction, _ label: String) -> some View {
        Button(action: { performAction(action) }) {
            HStack(alignment: .top, spacing: 10) {
                ZStack {
                    Circle()
                        .fill(InnTheme.hearthGold.opacity(0.30))
                        .frame(width: 30, height: 30)
                    Text(action.label.prefix(1))
                        .font(.system(size: 14, weight: .bold, design: .serif))
                        .foregroundColor(InnTheme.inkCharcoal)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text(action.label)
                        .font(.system(size: 14, weight: .bold, design: .serif))
                        .foregroundColor(InnTheme.inkCharcoal)
                    Text(label)
                        .font(.system(size: 12, weight: .regular, design: .serif))
                        .foregroundColor(InnTheme.inkCharcoal.opacity(0.65))
                }
                Spacer()
            }
            .padding(10)
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

    private func performAction(_ action: ChatAction) {
        let r = store.attemptCapture(guestId: guestId, action: action)
        if r.success, let rid = r.rumorId, let rumor = InnCatalog.rumor(rid) {
            lastWasSuccess = true
            lastResultText = "They lean closer: \"\(rumor.summary)\""
        } else {
            lastWasSuccess = false
            lastResultText = "They smile, but say nothing of consequence."
        }
    }
}
