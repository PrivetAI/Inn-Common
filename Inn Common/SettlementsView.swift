import SwiftUI

struct SettlementsView: View {
    @EnvironmentObject var store: InnStore
    @Binding var activeSheet: InnActiveSheet?

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    headerCard
                    ForEach(store.state.settlements) { s in
                        Button(action: { activeSheet = .settlementDetail(settlementId: s.id) }) {
                            settlementRow(s)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 14)
                .padding(.top, 14)
                .padding(.bottom, 24)
            }
        }
        .navigationBarHidden(true)
    }

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("The Crossroads")
                .font(.system(size: 22, weight: .bold, design: .serif))
                .foregroundColor(InnTheme.inkCharcoal)
            Text("Eight settlements feed the road. Reputation drives traffic and quality of travelers.")
                .font(.system(size: 12, weight: .regular, design: .serif))
                .foregroundColor(InnTheme.inkCharcoal.opacity(0.65))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .innCard()
    }

    private func settlementRow(_ s: Settlement) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                ZStack {
                    Circle().fill(InnTheme.oakBrown.opacity(0.12)).frame(width: 36, height: 36)
                    BuildingShape().stroke(InnTheme.oakBrown, lineWidth: 1.5)
                        .frame(width: 22, height: 22)
                }
                Text(s.name)
                    .font(.system(size: 15, weight: .bold, design: .serif))
                    .foregroundColor(InnTheme.inkCharcoal)
                Spacer()
                InnPill(label: "Rep \(s.reputation)",
                        bg: reputationTint(s.reputation))
                InnPill(label: "Danger \(s.dangerFactor)",
                        bg: InnTheme.emberRed.opacity(Double(s.dangerFactor) * 0.10))
            }
            Text(s.blurb)
                .font(.system(size: 12, weight: .regular, design: .serif))
                .foregroundColor(InnTheme.inkCharcoal.opacity(0.7))
            HStack(spacing: 6) {
                ForEach(s.primaryGuestArchetypeIds.prefix(3), id: \.self) { aid in
                    let a = InnCatalog.archetype(aid)
                    InnPill(label: a.name, bg: InnTheme.hearthGold.opacity(0.30))
                }
                if s.primaryGuestArchetypeIds.count > 3 {
                    InnPill(label: "+\(s.primaryGuestArchetypeIds.count - 3)", bg: InnTheme.oakBrown.opacity(0.15))
                }
                Spacer()
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

    private func reputationTint(_ r: Int) -> Color {
        if r >= 60 { return InnTheme.hearthGold.opacity(0.40) }
        if r >= 30 { return InnTheme.mossyStone.opacity(0.35) }
        if r >= 0  { return InnTheme.tavernCreamSoft }
        return InnTheme.emberRed.opacity(0.30)
    }
}

// MARK: - Settlement detail sheet

struct SettlementDetailSheet: View {
    @EnvironmentObject var store: InnStore
    let settlementId: Int
    @Binding var activeSheet: InnActiveSheet?

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                InnTopBar(title: "Settlement", onClose: { activeSheet = nil })
                if let s = store.state.settlements.first(where: { $0.id == settlementId }) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 14) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(s.name)
                                    .font(.system(size: 20, weight: .bold, design: .serif))
                                Text(s.blurb)
                                    .font(.system(size: 13, weight: .regular, design: .serif))
                                    .foregroundColor(InnTheme.inkCharcoal.opacity(0.70))
                            }
                            .innCard()

                            VStack(alignment: .leading, spacing: 6) {
                                InnSectionHeader(title: "Statures")
                                InnStatRow(label: "Reputation", value: "\(s.reputation)")
                                InnStatRow(label: "Danger Factor", value: "\(s.dangerFactor)")
                                InnMeter(label: "Rep",
                                         value: max(0, min(100, s.reputation)),
                                         tint: s.reputation >= 30 ? InnTheme.hearthGoldDeep : InnTheme.mossyStone)
                            }
                            .innCard()

                            VStack(alignment: .leading, spacing: 8) {
                                InnSectionHeader(title: "Travelers from Here")
                                ForEach(s.primaryGuestArchetypeIds, id: \.self) { aid in
                                    let a = InnCatalog.archetype(aid)
                                    HStack(spacing: 10) {
                                        GuestPortrait(archetype: a, size: 42)
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(a.name)
                                                .font(.system(size: 13, weight: .bold, design: .serif))
                                            HStack(spacing: 4) {
                                                ForEach(a.rumorTags, id: \.self) { t in
                                                    InnPill(label: t.label, bg: t.swatch)
                                                }
                                            }
                                        }
                                        Spacer()
                                    }
                                    .padding(.vertical, 4)
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
}
