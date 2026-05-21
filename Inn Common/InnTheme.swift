import SwiftUI

enum InnTheme {
    // Palette (theme-independent)
    static let oakBrown      = Color(red: 0.420, green: 0.267, blue: 0.137)  // #6B4423
    static let oakBrownDark  = Color(red: 0.290, green: 0.180, blue: 0.090)
    static let tavernCream   = Color(red: 0.949, green: 0.886, blue: 0.737)  // #F2E2BC
    static let tavernCreamSoft = Color(red: 0.967, green: 0.929, blue: 0.819)
    static let emberRed      = Color(red: 0.706, green: 0.243, blue: 0.165)  // #B43E2A
    static let emberDeep     = Color(red: 0.474, green: 0.137, blue: 0.094)
    static let hearthGold    = Color(red: 0.835, green: 0.627, blue: 0.231)  // #D5A03B
    static let hearthGoldDeep = Color(red: 0.643, green: 0.467, blue: 0.149)
    static let mossyStone    = Color(red: 0.416, green: 0.439, blue: 0.349)  // #6A7059
    static let mossyStoneSoft = Color(red: 0.561, green: 0.580, blue: 0.498)
    static let inkCharcoal   = Color(red: 0.165, green: 0.145, blue: 0.125)  // #2A2521
    static let candleCream   = Color(red: 0.976, green: 0.929, blue: 0.714)  // #F9EDB6
    static let parchment     = Color(red: 0.937, green: 0.875, blue: 0.722)
    static let shadowSoft    = Color.black.opacity(0.18)

    // Common gradients
    static var hearthGradient: LinearGradient {
        LinearGradient(colors: [emberRed, hearthGold], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    static var oakGradient: LinearGradient {
        LinearGradient(colors: [oakBrown, oakBrownDark], startPoint: .top, endPoint: .bottom)
    }
    static var parchmentGradient: LinearGradient {
        LinearGradient(colors: [tavernCream, parchment], startPoint: .top, endPoint: .bottom)
    }
}

struct InnCardStyle: ViewModifier {
    var tone: Color = InnTheme.tavernCreamSoft
    func body(content: Content) -> some View {
        content
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(tone)
                    .shadow(color: InnTheme.shadowSoft, radius: 3, x: 0, y: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(InnTheme.oakBrown.opacity(0.20), lineWidth: 1)
            )
    }
}

extension View {
    func innCard(tone: Color = InnTheme.tavernCreamSoft) -> some View {
        modifier(InnCardStyle(tone: tone))
    }
}

struct InnPill: View {
    let label: String
    var fg: Color = InnTheme.inkCharcoal
    var bg: Color = InnTheme.hearthGold.opacity(0.30)
    var body: some View {
        Text(label)
            .font(.system(size: 11, weight: .semibold, design: .serif))
            .foregroundColor(fg)
            .padding(.horizontal, 9)
            .padding(.vertical, 4)
            .background(Capsule().fill(bg))
            .overlay(Capsule().stroke(InnTheme.oakBrown.opacity(0.25), lineWidth: 0.8))
    }
}

struct InnSectionHeader: View {
    let title: String
    var sub: String? = nil
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .serif))
                .foregroundColor(InnTheme.inkCharcoal)
            if let s = sub {
                Text(s)
                    .font(.system(size: 12, weight: .regular, design: .serif))
                    .foregroundColor(InnTheme.inkCharcoal.opacity(0.65))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct InnButtonStyle: ButtonStyle {
    var fill: Color = InnTheme.oakBrown
    var fg: Color = InnTheme.candleCream
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 14, weight: .semibold, design: .serif))
            .foregroundColor(fg)
            .padding(.horizontal, 14)
            .padding(.vertical, 9)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(fill.opacity(configuration.isPressed ? 0.7 : 1.0))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(InnTheme.oakBrownDark.opacity(0.5), lineWidth: 0.8)
            )
    }
}

struct InnGhostButtonStyle: ButtonStyle {
    var fg: Color = InnTheme.oakBrown
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 14, weight: .semibold, design: .serif))
            .foregroundColor(fg)
            .padding(.horizontal, 14)
            .padding(.vertical, 9)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(fg.opacity(0.7), lineWidth: 1.2)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(configuration.isPressed ? 0.5 : 0.0))
                    )
            )
    }
}
