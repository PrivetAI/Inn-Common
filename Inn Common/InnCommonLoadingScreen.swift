import SwiftUI

struct InnCommonLoadingScreen: View {
    @State private var pulse: CGFloat = 0.0

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    InnTheme.oakBrown.opacity(0.95),
                    InnTheme.emberRed.opacity(0.85),
                    InnTheme.hearthGold
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 28) {
                ZStack {
                    Circle()
                        .stroke(InnTheme.candleCream.opacity(0.35), lineWidth: 4)
                        .frame(width: 132, height: 132)
                    Circle()
                        .trim(from: 0, to: 0.32)
                        .stroke(InnTheme.candleCream, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                        .frame(width: 132, height: 132)
                        .rotationEffect(.degrees(Double(pulse * 360)))
                    LanternShape()
                        .fill(InnTheme.candleCream)
                        .frame(width: 58, height: 78)
                }
                Text("Inn Common")
                    .font(.system(size: 22, weight: .semibold, design: .serif))
                    .foregroundColor(InnTheme.candleCream)
                Text("Banking the embers...")
                    .font(.system(size: 14, weight: .regular, design: .serif))
                    .foregroundColor(InnTheme.candleCream.opacity(0.75))
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 1.6).repeatForever(autoreverses: false)) {
                pulse = 1.0
            }
        }
    }
}
