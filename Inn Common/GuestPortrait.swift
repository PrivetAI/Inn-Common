import SwiftUI

// A purely abstract Shape-based portrait composed from cloak + head + hat + accent.
// Variation comes from archetype.cloakHue (0-359), hatStyle (0-4), and id.

struct GuestPortrait: View {
    let archetype: InnArchetype
    let size: CGFloat
    var emphasised: Bool = false

    var cloakColor: Color {
        Color(hue: Double(archetype.cloakHue) / 360.0, saturation: 0.45, brightness: 0.55)
    }
    var trimColor: Color {
        Color(hue: Double((archetype.cloakHue + 30) % 360) / 360.0,
              saturation: 0.55, brightness: 0.72)
    }
    var skinColor: Color {
        let s = (archetype.id * 13) % 4
        switch s {
        case 0: return Color(red: 0.92, green: 0.83, blue: 0.72)
        case 1: return Color(red: 0.84, green: 0.71, blue: 0.60)
        case 2: return Color(red: 0.71, green: 0.55, blue: 0.43)
        default: return Color(red: 0.58, green: 0.43, blue: 0.31)
        }
    }

    var body: some View {
        ZStack {
            // Background plate
            RoundedRectangle(cornerRadius: size * 0.16)
                .fill(InnTheme.tavernCreamSoft)
            // Shoulders/cloak
            HourglassCloakShape()
                .fill(cloakColor)
                .frame(width: size * 0.92, height: size * 0.55)
                .offset(y: size * 0.20)
            HourglassCloakShape()
                .stroke(trimColor, lineWidth: 1.5)
                .frame(width: size * 0.92, height: size * 0.55)
                .offset(y: size * 0.20)

            // Neck
            RoundedRectangle(cornerRadius: 4)
                .fill(skinColor)
                .frame(width: size * 0.16, height: size * 0.10)
                .offset(y: size * 0.05)

            // Head
            Circle()
                .fill(skinColor)
                .frame(width: size * 0.38, height: size * 0.38)
                .offset(y: -size * 0.08)
            // Hair / collar arc
            Path { p in
                p.addArc(center: CGPoint(x: size / 2, y: size / 2 - size * 0.08),
                         radius: size * 0.19,
                         startAngle: .degrees(200),
                         endAngle: .degrees(340),
                         clockwise: true)
            }
            .stroke(InnTheme.oakBrownDark.opacity(0.55), lineWidth: 2)

            // Hat
            hatShape

            // Subtle face: eyes & mouth (abstract dots only — no semantic figures)
            HStack(spacing: size * 0.10) {
                Circle().fill(InnTheme.inkCharcoal).frame(width: size * 0.030, height: size * 0.030)
                Circle().fill(InnTheme.inkCharcoal).frame(width: size * 0.030, height: size * 0.030)
            }
            .offset(y: -size * 0.10)
            // Mouth
            RoundedRectangle(cornerRadius: 1)
                .fill(InnTheme.inkCharcoal.opacity(0.65))
                .frame(width: size * 0.05, height: size * 0.012)
                .offset(y: -size * 0.02)

            // Accent — a coin, a quill, etc. on the chest
            accentShape

            // Emphasis ring
            if emphasised {
                RoundedRectangle(cornerRadius: size * 0.16)
                    .stroke(InnTheme.hearthGold, lineWidth: 2)
            }
        }
        .frame(width: size, height: size)
        .clipShape(RoundedRectangle(cornerRadius: size * 0.16))
        .overlay(
            RoundedRectangle(cornerRadius: size * 0.16)
                .stroke(InnTheme.oakBrown.opacity(0.35), lineWidth: 1)
        )
    }

    @ViewBuilder
    private var hatShape: some View {
        Group {
            switch archetype.hatStyle {
            case 0:
                // Hood
                Path { p in
                    let cx = size / 2
                    let cy = size / 2 - size * 0.05
                    p.move(to: CGPoint(x: cx - size * 0.22, y: cy - size * 0.10))
                    p.addQuadCurve(to: CGPoint(x: cx + size * 0.22, y: cy - size * 0.10),
                                   control: CGPoint(x: cx, y: cy - size * 0.30))
                    p.addLine(to: CGPoint(x: cx + size * 0.20, y: cy - size * 0.04))
                    p.addLine(to: CGPoint(x: cx - size * 0.20, y: cy - size * 0.04))
                    p.closeSubpath()
                }
                .fill(trimColor)
            case 1:
                // Brimmed cap
                RoundedRectangle(cornerRadius: 4)
                    .fill(InnTheme.oakBrownDark)
                    .frame(width: size * 0.42, height: size * 0.07)
                    .offset(y: -size * 0.20)
                RoundedRectangle(cornerRadius: 6)
                    .fill(trimColor)
                    .frame(width: size * 0.30, height: size * 0.14)
                    .offset(y: -size * 0.27)
            case 2:
                // Wide cone
                Path { p in
                    let cx = size / 2
                    let cy = size / 2
                    p.move(to: CGPoint(x: cx, y: cy - size * 0.38))
                    p.addLine(to: CGPoint(x: cx + size * 0.22, y: cy - size * 0.10))
                    p.addLine(to: CGPoint(x: cx - size * 0.22, y: cy - size * 0.10))
                    p.closeSubpath()
                }
                .fill(trimColor)
            case 3:
                // Bandana band
                RoundedRectangle(cornerRadius: 3)
                    .fill(InnTheme.emberDeep)
                    .frame(width: size * 0.36, height: size * 0.07)
                    .offset(y: -size * 0.14)
            default:
                // Crown / circlet
                Path { p in
                    let cx = size / 2
                    let cy = size / 2 - size * 0.14
                    p.move(to: CGPoint(x: cx - size * 0.22, y: cy))
                    p.addLine(to: CGPoint(x: cx - size * 0.18, y: cy - size * 0.08))
                    p.addLine(to: CGPoint(x: cx - size * 0.10, y: cy - size * 0.02))
                    p.addLine(to: CGPoint(x: cx, y: cy - size * 0.10))
                    p.addLine(to: CGPoint(x: cx + size * 0.10, y: cy - size * 0.02))
                    p.addLine(to: CGPoint(x: cx + size * 0.18, y: cy - size * 0.08))
                    p.addLine(to: CGPoint(x: cx + size * 0.22, y: cy))
                    p.closeSubpath()
                }
                .fill(InnTheme.hearthGold)
            }
        }
    }

    @ViewBuilder
    private var accentShape: some View {
        let kind = archetype.id % 6
        Group {
            switch kind {
            case 0:
                CoinShape().stroke(InnTheme.hearthGoldDeep, lineWidth: 1.4)
                    .frame(width: size * 0.10, height: size * 0.10)
                    .offset(x: size * 0.20, y: size * 0.20)
            case 1:
                QuillShape().stroke(InnTheme.inkCharcoal, lineWidth: 1.4)
                    .frame(width: size * 0.18, height: size * 0.18)
                    .offset(x: -size * 0.20, y: size * 0.22)
            case 2:
                ScrollShape().stroke(InnTheme.oakBrownDark, lineWidth: 1.2)
                    .frame(width: size * 0.16, height: size * 0.12)
                    .offset(x: size * 0.18, y: size * 0.22)
            case 3:
                StarShape().stroke(InnTheme.hearthGold, lineWidth: 1.4)
                    .frame(width: size * 0.12, height: size * 0.12)
                    .offset(x: -size * 0.20, y: size * 0.20)
            case 4:
                ShieldShape().stroke(InnTheme.mossyStone, lineWidth: 1.4)
                    .frame(width: size * 0.14, height: size * 0.16)
                    .offset(x: size * 0.18, y: size * 0.20)
            default:
                LanternShape().stroke(InnTheme.emberRed, lineWidth: 1.2)
                    .frame(width: size * 0.12, height: size * 0.16)
                    .offset(x: -size * 0.20, y: size * 0.22)
            }
        }
    }
}
