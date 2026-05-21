import SwiftUI

struct EventCardSheet: View {
    @EnvironmentObject var store: InnStore
    @Binding var activeSheet: InnActiveSheet?

    var body: some View {
        ZStack {
            InnTheme.parchmentGradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                InnTopBar(title: "Event", onClose: { activeSheet = nil })
                if let pe = store.state.pendingEvent,
                   let event = InnCatalog.events.first(where: { $0.id == pe.eventId }) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 14) {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    InnPill(label: event.category.capitalized,
                                            fg: InnTheme.candleCream,
                                            bg: categoryColor(event.category))
                                    Spacer()
                                    InnPill(label: "D\(store.state.day)",
                                            bg: InnTheme.hearthGold.opacity(0.30))
                                }
                                Text(event.title)
                                    .font(.system(size: 20, weight: .bold, design: .serif))
                                    .foregroundColor(InnTheme.inkCharcoal)
                                Text(event.body)
                                    .font(.system(size: 14, weight: .regular, design: .serif))
                                    .foregroundColor(InnTheme.inkCharcoal.opacity(0.85))
                            }
                            .innCard(tone: InnTheme.candleCream)

                            VStack(spacing: 10) {
                                ForEach(Array(event.options.enumerated()), id: \.offset) { idx, opt in
                                    optionRow(idx: idx, opt: opt)
                                }
                            }
                        }
                        .padding(14)
                    }
                } else {
                    VStack {
                        Spacer()
                        Text("Today is quiet at the crossroads.")
                            .font(.system(size: 14, weight: .regular, design: .serif))
                            .foregroundColor(InnTheme.inkCharcoal.opacity(0.65))
                        Spacer()
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func optionRow(idx: Int, opt: InnEventOption) -> some View {
        Button(action: {
            store.resolveEvent(option: idx)
            activeSheet = nil
        }) {
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(opt.label)
                        .font(.system(size: 14, weight: .bold, design: .serif))
                        .foregroundColor(InnTheme.inkCharcoal)
                    Spacer()
                    if opt.coinDelta != 0 {
                        InnPill(label: opt.coinDelta > 0 ? "+\(opt.coinDelta)c" : "\(opt.coinDelta)c",
                                fg: opt.coinDelta > 0 ? InnTheme.candleCream : InnTheme.candleCream,
                                bg: opt.coinDelta > 0 ? InnTheme.hearthGoldDeep : InnTheme.emberDeep)
                    }
                }
                Text(opt.consequence)
                    .font(.system(size: 12, weight: .regular, design: .serif))
                    .foregroundColor(InnTheme.inkCharcoal.opacity(0.7))
                if !opt.reputationDelta.isEmpty {
                    HStack(spacing: 4) {
                        ForEach(opt.reputationDelta.keys.sorted(), id: \.self) { sid in
                            if let s = store.state.settlements.first(where: { $0.id == sid }),
                               let v = opt.reputationDelta[sid] {
                                let sign = v > 0 ? "+" : ""
                                InnPill(label: "\(s.name) \(sign)\(v)",
                                        bg: v > 0 ? InnTheme.hearthGold.opacity(0.30) : InnTheme.emberRed.opacity(0.20))
                            }
                        }
                    }
                }
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(InnTheme.tavernCreamSoft)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(InnTheme.oakBrown.opacity(0.25), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(.plain)
    }

    private func categoryColor(_ category: String) -> Color {
        switch category {
        case "weather": return InnTheme.mossyStone
        case "social":  return InnTheme.hearthGoldDeep
        case "trade":   return InnTheme.oakBrown
        case "danger":  return InnTheme.emberDeep
        case "royal":   return Color(red: 0.40, green: 0.30, blue: 0.55)
        default:        return InnTheme.oakBrown
        }
    }
}
