import SwiftUI

struct RumorsView: View {
    @EnvironmentObject var store: InnStore
    @Binding var activeSheet: InnActiveSheet?
    @State private var section: Int = 0   // 0=ledger, 1=arcs, 2=catalog
    @State private var searchText: String = ""
    @State private var filterCategory: RumorCategory? = nil

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                segmentBar
                if section == 0 { filterBar }
                ScrollView {
                    VStack(spacing: 12) {
                        if section == 0 { ledgerList }
                        else if section == 1 { arcsList }
                        else { catalogList }
                    }
                    .padding(.horizontal, 14)
                    .padding(.top, 10)
                    .padding(.bottom, 24)
                }
            }
        }
        .navigationBarHidden(true)
    }

    private var segmentBar: some View {
        HStack(spacing: 0) {
            segButton(0, "Ledger")
            segButton(1, "Arcs")
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

    private var filterBar: some View {
        VStack(spacing: 8) {
            HStack {
                HStack(spacing: 6) {
                    ScrollShape().stroke(InnTheme.inkCharcoal.opacity(0.6), lineWidth: 1.3)
                        .frame(width: 14, height: 14)
                    TextField("Search whispers...", text: $searchText)
                        .font(.system(size: 13, weight: .regular, design: .serif))
                        .textFieldStyle(.plain)
                        .foregroundColor(InnTheme.inkCharcoal)
                }
                .padding(.horizontal, 10).padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(InnTheme.tavernCreamSoft)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(InnTheme.oakBrown.opacity(0.25), lineWidth: 1)
                        )
                )
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    Button(action: { filterCategory = nil }) {
                        InnPill(label: "All",
                                fg: filterCategory == nil ? InnTheme.candleCream : InnTheme.inkCharcoal,
                                bg: filterCategory == nil ? InnTheme.oakBrown : InnTheme.tavernCreamSoft)
                    }.buttonStyle(.plain)
                    ForEach(RumorCategory.allCases, id: \.self) { c in
                        Button(action: { filterCategory = c }) {
                            InnPill(label: c.label,
                                    fg: filterCategory == c ? InnTheme.candleCream : InnTheme.inkCharcoal,
                                    bg: filterCategory == c ? InnTheme.oakBrown : c.swatch)
                        }.buttonStyle(.plain)
                    }
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.top, 10)
    }

    @ViewBuilder
    private var ledgerList: some View {
        let entries = filteredCaptured()
        if entries.isEmpty {
            emptyState("No whispers captured yet. Speak with guests in the Common Room.")
        } else {
            ForEach(entries) { c in
                Button(action: { activeSheet = .rumorDetail(capturedId: c.id) }) {
                    capturedRow(c)
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func filteredCaptured() -> [CapturedRumor] {
        var list = store.state.capturedRumors
        if let f = filterCategory { list = list.filter { $0.category == f } }
        if !searchText.isEmpty {
            list = list.filter {
                guard let r = InnCatalog.rumor($0.rumorId) else { return false }
                return r.summary.localizedCaseInsensitiveContains(searchText)
            }
        }
        return list.reversed()
    }

    private func capturedRow(_ c: CapturedRumor) -> some View {
        let rumor = InnCatalog.rumor(c.rumorId)
        return VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                InnPill(label: c.category.label, fg: InnTheme.inkCharcoal, bg: c.category.swatch)
                InnPill(label: c.tier.label, fg: InnTheme.candleCream, bg: tierColor(c.tier))
                if c.soldTo != nil {
                    InnPill(label: "Sold", fg: InnTheme.candleCream, bg: InnTheme.mossyStone)
                }
                if c.corroborationCount >= 2 {
                    InnPill(label: "x\(c.corroborationCount) sources", bg: InnTheme.hearthGold.opacity(0.30))
                }
                Spacer()
                Text("D\(c.dayCaught)")
                    .font(.system(size: 11, weight: .semibold, design: .serif))
                    .foregroundColor(InnTheme.inkCharcoal.opacity(0.5))
            }
            Text(rumor?.summary ?? "—")
                .font(.system(size: 13, weight: .regular, design: .serif))
                .foregroundColor(InnTheme.inkCharcoal)
                .lineLimit(3)
            HStack {
                if c.discoveredTruth != .unknown {
                    InnPill(label: c.discoveredTruth.label, bg: truthColor(c.discoveredTruth))
                }
                Spacer()
                ChevronShape(pointingRight: true)
                    .stroke(InnTheme.inkCharcoal.opacity(0.4), lineWidth: 1.4)
                    .frame(width: 9, height: 13)
            }
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

    private func tierColor(_ t: RumorTier) -> Color {
        switch t {
        case .whisper: return InnTheme.mossyStone
        case .hearsay: return InnTheme.oakBrown
        case .fact:    return InnTheme.emberDeep
        }
    }
    private func truthColor(_ t: RumorTruth) -> Color {
        switch t {
        case .trueRumor:  return InnTheme.hearthGold.opacity(0.4)
        case .partial:    return InnTheme.mossyStoneSoft.opacity(0.5)
        case .falseRumor: return InnTheme.emberRed.opacity(0.3)
        case .unknown:    return InnTheme.tavernCreamSoft
        }
    }

    @ViewBuilder
    private var arcsList: some View {
        ForEach(store.state.arcs, id: \.kind) { ap in
            Button(action: { activeSheet = .arcDetail(arc: ap.kind) }) {
                arcRow(ap)
            }
            .buttonStyle(.plain)
        }
    }

    private func arcRow(_ ap: ArcProgress) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(ap.kind.label)
                    .font(.system(size: 15, weight: .bold, design: .serif))
                    .foregroundColor(InnTheme.inkCharcoal)
                Spacer()
                if ap.resolved {
                    InnPill(label: ap.endingKind?.label ?? "Resolved",
                            fg: InnTheme.candleCream, bg: InnTheme.oakBrown)
                } else {
                    InnPill(label: "By Day \(ap.kind.deadlineDay)", bg: InnTheme.hearthGold.opacity(0.30))
                }
            }
            Text(ap.kind.blurb)
                .font(.system(size: 12, weight: .regular, design: .serif))
                .foregroundColor(InnTheme.inkCharcoal.opacity(0.7))
            HStack(spacing: 6) {
                ForEach(ap.kind.relevantCategories, id: \.self) { c in
                    InnPill(label: c.label, fg: InnTheme.inkCharcoal, bg: c.swatch)
                }
                Spacer()
                Text("Tags \(ap.rumorTagCount)  •  Milestones \(ap.milestonesUnlocked)/3")
                    .font(.system(size: 11, weight: .semibold, design: .serif))
                    .foregroundColor(InnTheme.inkCharcoal.opacity(0.6))
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

    @ViewBuilder
    private var catalogList: some View {
        let filtered = catalogFiltered()
        ForEach(filtered) { r in
            HStack(alignment: .top, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        InnPill(label: r.category.label, fg: InnTheme.inkCharcoal, bg: r.category.swatch)
                        InnPill(label: r.tier.label, fg: InnTheme.candleCream, bg: tierColor(r.tier))
                        Spacer()
                        InnPill(label: "#\(r.id)", bg: InnTheme.oakBrown.opacity(0.15))
                    }
                    Text(r.summary)
                        .font(.system(size: 13, weight: .regular, design: .serif))
                        .foregroundColor(InnTheme.inkCharcoal)
                        .lineLimit(3)
                    if store.state.capturedRumors.contains(where: { $0.rumorId == r.id }) {
                        InnPill(label: "Captured", bg: InnTheme.hearthGold.opacity(0.4))
                    }
                }
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(InnTheme.tavernCreamSoft)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(InnTheme.oakBrown.opacity(0.20), lineWidth: 1)
                    )
            )
        }
    }

    private func catalogFiltered() -> [InnRumor] {
        var list = InnCatalog.rumors
        if let f = filterCategory { list = list.filter { $0.category == f } }
        if !searchText.isEmpty {
            list = list.filter { $0.summary.localizedCaseInsensitiveContains(searchText) }
        }
        return list
    }

    private func emptyState(_ text: String) -> some View {
        VStack(spacing: 8) {
            ZStack {
                Circle().fill(InnTheme.oakBrown.opacity(0.15)).frame(width: 70, height: 70)
                ScrollShape().stroke(InnTheme.oakBrown, lineWidth: 1.6).frame(width: 36, height: 36)
            }
            Text(text)
                .font(.system(size: 13, weight: .regular, design: .serif))
                .foregroundColor(InnTheme.inkCharcoal.opacity(0.65))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 28)
    }
}

// MARK: - Rumor detail sheet

struct RumorDetailSheet: View {
    @EnvironmentObject var store: InnStore
    let capturedId: UUID
    @Binding var activeSheet: InnActiveSheet?

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                InnTopBar(title: "Whisper", onClose: { activeSheet = nil })
                if let c = store.state.capturedRumors.first(where: { $0.id == capturedId }),
                   let r = InnCatalog.rumor(c.rumorId) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 14) {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    InnPill(label: r.category.label, fg: InnTheme.inkCharcoal, bg: r.category.swatch)
                                    InnPill(label: r.tier.label, fg: InnTheme.candleCream, bg: InnTheme.oakBrown)
                                    if c.discoveredTruth != .unknown {
                                        InnPill(label: c.discoveredTruth.label, bg: InnTheme.hearthGold.opacity(0.3))
                                    }
                                    Spacer()
                                }
                                Text(r.summary)
                                    .font(.system(size: 15, weight: .regular, design: .serif))
                                    .foregroundColor(InnTheme.inkCharcoal)
                            }
                            .innCard()

                            VStack(alignment: .leading, spacing: 8) {
                                InnSectionHeader(title: "Sources")
                                if c.sourceArchetypeIds.isEmpty {
                                    Text("Heard from no clear source — possibly from an event.")
                                        .font(.system(size: 12, weight: .regular, design: .serif))
                                        .foregroundColor(InnTheme.inkCharcoal.opacity(0.6))
                                } else {
                                    ForEach(c.sourceArchetypeIds, id: \.self) { aid in
                                        let a = InnCatalog.archetype(aid)
                                        HStack(spacing: 8) {
                                            GuestPortrait(archetype: a, size: 40)
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text(a.name)
                                                    .font(.system(size: 12, weight: .bold, design: .serif))
                                                Text(a.title)
                                                    .font(.system(size: 10, weight: .regular, design: .serif))
                                                    .foregroundColor(InnTheme.inkCharcoal.opacity(0.6))
                                            }
                                            Spacer()
                                        }
                                    }
                                }
                                InnStatRow(label: "Corroborations", value: "\(c.corroborationCount)")
                                InnStatRow(label: "Day Caught", value: "Day \(c.dayCaught)")
                            }
                            .innCard()

                            if let arc = r.arcAffinity {
                                VStack(alignment: .leading, spacing: 6) {
                                    InnSectionHeader(title: "Relates To")
                                    HStack {
                                        Text(arc.label)
                                            .font(.system(size: 13, weight: .bold, design: .serif))
                                        Spacer()
                                        Button("Open Arc") {
                                            activeSheet = .arcDetail(arc: arc)
                                        }
                                        .buttonStyle(InnGhostButtonStyle())
                                    }
                                    Text(arc.blurb)
                                        .font(.system(size: 12, weight: .regular, design: .serif))
                                        .foregroundColor(InnTheme.inkCharcoal.opacity(0.65))
                                }
                                .innCard()
                            }

                            if c.soldTo == nil {
                                Button(action: { activeSheet = .sellRumor(capturedId: c.id) }) {
                                    HStack {
                                        CoinShape().stroke(InnTheme.candleCream, lineWidth: 1.5)
                                            .frame(width: 14, height: 14)
                                        Text("Take to Market")
                                    }
                                }
                                .buttonStyle(InnButtonStyle(fill: InnTheme.emberDeep, fg: InnTheme.candleCream))
                            } else {
                                Text("Sold to \(c.soldTo ?? "—")")
                                    .font(.system(size: 12, weight: .semibold, design: .serif))
                                    .foregroundColor(InnTheme.inkCharcoal.opacity(0.7))
                            }
                        }
                        .padding(14)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Sell rumor sheet (market)

struct SellRumorSheet: View {
    @EnvironmentObject var store: InnStore
    let capturedId: UUID
    @Binding var activeSheet: InnActiveSheet?

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                InnTopBar(title: "Rumor Market", onClose: { activeSheet = nil })
                if let c = store.state.capturedRumors.first(where: { $0.id == capturedId }) {
                    ScrollView {
                        VStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Sells: \(store.state.flags["soldToday-\(store.state.day)"] ?? 0) / 3 today")
                                    .font(.system(size: 12, weight: .semibold, design: .serif))
                                    .foregroundColor(InnTheme.inkCharcoal.opacity(0.65))
                                if let r = InnCatalog.rumor(c.rumorId) {
                                    Text(r.summary)
                                        .font(.system(size: 13, weight: .regular, design: .serif))
                                        .foregroundColor(InnTheme.inkCharcoal)
                                }
                            }
                            .innCard()

                            ForEach(BuyerKind.allCases, id: \.self) { buyer in
                                buyerCard(buyer: buyer, captured: c)
                            }
                        }
                        .padding(14)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func buyerCard(buyer: BuyerKind, captured: CapturedRumor) -> some View {
        let price = InnEngine.priceForBuyer(buyer, rumor: captured, lifetimeRevenue: store.state.lifetimeRevenue)
        let interested = buyer.preferredCategories.contains(captured.category)
        return VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(buyer.label)
                    .font(.system(size: 14, weight: .bold, design: .serif))
                    .foregroundColor(InnTheme.inkCharcoal)
                Spacer()
                if interested {
                    InnPill(label: "Interested", bg: InnTheme.hearthGold.opacity(0.40))
                }
            }
            HStack(spacing: 4) {
                ForEach(buyer.preferredCategories, id: \.self) { c in
                    InnPill(label: c.label, fg: InnTheme.inkCharcoal, bg: c.swatch)
                }
            }
            HStack {
                Text("\(price) coins")
                    .font(.system(size: 16, weight: .bold, design: .serif))
                    .foregroundColor(InnTheme.emberDeep)
                Spacer()
                Button(action: {
                    let received = store.sellRumor(capturedId: captured.id, to: buyer)
                    if received > 0 { activeSheet = nil }
                }) {
                    Text("Sell")
                }
                .buttonStyle(InnButtonStyle(fill: InnTheme.oakBrown, fg: InnTheme.candleCream))
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

// MARK: - Arc detail sheet

struct ArcDetailSheet: View {
    @EnvironmentObject var store: InnStore
    let arc: ArcKind
    @Binding var activeSheet: InnActiveSheet?

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                InnTopBar(title: arc.label, onClose: { activeSheet = nil })
                if let ap = store.state.arcs.first(where: { $0.kind == arc }) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 14) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(arc.blurb)
                                    .font(.system(size: 13, weight: .regular, design: .serif))
                                    .foregroundColor(InnTheme.inkCharcoal.opacity(0.85))
                                HStack(spacing: 6) {
                                    ForEach(arc.relevantCategories, id: \.self) { c in
                                        InnPill(label: c.label, fg: InnTheme.inkCharcoal, bg: c.swatch)
                                    }
                                }
                                InnStatRow(label: "Tags Held", value: "\(ap.rumorTagCount)")
                                InnStatRow(label: "Milestones", value: "\(ap.milestonesUnlocked)/3")
                                InnStatRow(label: "Deadline", value: "Day \(arc.deadlineDay)")
                            }
                            .innCard()

                            if ap.resolved {
                                VStack(alignment: .leading, spacing: 8) {
                                    InnSectionHeader(title: "Ending: \(ap.endingKind?.label ?? "—")")
                                    Text(ap.endingText)
                                        .font(.system(size: 13, weight: .regular, design: .serif))
                                        .foregroundColor(InnTheme.inkCharcoal)
                                }
                                .innCard()
                            } else if ap.milestonesUnlocked >= 3 {
                                VStack(alignment: .leading, spacing: 10) {
                                    InnSectionHeader(title: "Make a Choice",
                                                     sub: "The arc resolves on your verdict.")
                                    endingButton(.success, "Press for full resolution",
                                                 "Your dossier is enough to act decisively.")
                                    endingButton(.partial, "Settle for a quiet outcome",
                                                 "Sell what you know, take the rest as cover.")
                                    endingButton(.failure, "Let the matter rest",
                                                 "Some threads burn the spinner.")
                                }
                                .innCard()
                            } else if ap.milestonesUnlocked >= 1 {
                                VStack(alignment: .leading, spacing: 8) {
                                    InnSectionHeader(title: "Milestone \(ap.milestonesUnlocked)",
                                                     sub: "Gather more tagged rumors")
                                    Text(milestoneFlavor(for: arc, milestone: ap.milestonesUnlocked))
                                        .font(.system(size: 13, weight: .regular, design: .serif))
                                        .foregroundColor(InnTheme.inkCharcoal)
                                }
                                .innCard()
                            } else {
                                VStack(alignment: .leading, spacing: 8) {
                                    InnSectionHeader(title: "Begin Listening",
                                                     sub: "No threads gathered yet")
                                    Text("Buy travelers a cup. Lean closer. Most threads begin with a half-finished sentence.")
                                        .font(.system(size: 13, weight: .regular, design: .serif))
                                        .foregroundColor(InnTheme.inkCharcoal.opacity(0.7))
                                }
                                .innCard()
                            }

                            if !ap.resolved {
                                let related = store.state.capturedRumors.filter {
                                    if let r = InnCatalog.rumor($0.rumorId), r.arcAffinity == arc { return true }
                                    return false
                                }
                                if !related.isEmpty {
                                    VStack(alignment: .leading, spacing: 8) {
                                        InnSectionHeader(title: "Held Whispers", sub: "\(related.count)")
                                        ForEach(related) { c in
                                            if let r = InnCatalog.rumor(c.rumorId) {
                                                Text("• " + r.summary)
                                                    .font(.system(size: 12, weight: .regular, design: .serif))
                                                    .foregroundColor(InnTheme.inkCharcoal.opacity(0.85))
                                            }
                                        }
                                    }
                                    .innCard()
                                }
                            }
                        }
                        .padding(14)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func endingButton(_ kind: ArcEndingKind, _ title: String, _ blurb: String) -> some View {
        Button(action: {
            store.resolveArc(arc, kind: kind)
        }) {
            HStack(alignment: .top, spacing: 10) {
                ZStack {
                    Circle().fill(InnTheme.hearthGold.opacity(0.30))
                        .frame(width: 28, height: 28)
                    Text(kind.label.prefix(1))
                        .font(.system(size: 14, weight: .bold, design: .serif))
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 13, weight: .bold, design: .serif))
                        .foregroundColor(InnTheme.inkCharcoal)
                    Text(blurb)
                        .font(.system(size: 11, weight: .regular, design: .serif))
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

    private func milestoneFlavor(for arc: ArcKind, milestone: Int) -> String {
        switch (arc, milestone) {
        case (.lordsBastard, 1):     return "A name. A village. Press more travelers from Tellveric and Wickbrook."
        case (.lordsBastard, 2):     return "A face. Watch the stableboys passing through Wickbrook."
        case (.smugglersMap, 1):     return "A trail leaving the gore of the Wolfwood. Drovers and bargemen know."
        case (.smugglersMap, 2):     return "Two fragments overlap on your wall. A third lies in someone's purse."
        case (.mendicantProphet, 1): return "He preaches near Old Cinder. The friars know more than they will say."
        case (.mendicantProphet, 2): return "A sermon names your roof. Decide what walls hear which words."
        case (.northernRoadWar, 1):  return "Two duchies move quietly. Couriers leave the wrong messages."
        case (.northernRoadWar, 2):  return "Banners sewn in haste. A treaty in shreds in a fire."
        case (.wolfwoodBeast, 1):    return "Hunters and hermits dispute its shape. The shape matters."
        case (.wolfwoodBeast, 2):    return "Pattern in the prints. The Beast's circuit has a beginning."
        default: return "—"
        }
    }
}
