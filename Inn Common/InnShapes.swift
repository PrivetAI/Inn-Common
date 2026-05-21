import SwiftUI

// MARK: - Building / Door / Window
struct BuildingShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width, h = rect.height
        p.move(to: CGPoint(x: rect.minX + w*0.05, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.minX + w*0.05, y: rect.minY + h*0.45))
        p.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX - w*0.05, y: rect.minY + h*0.45))
        p.addLine(to: CGPoint(x: rect.maxX - w*0.05, y: rect.maxY))
        p.closeSubpath()
        return p
    }
}

struct DoorShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.minY + rect.height * 0.18))
        p.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY + rect.height * 0.18),
                       control: CGPoint(x: rect.midX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        p.closeSubpath()
        return p
    }
}

struct WindowShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.addRoundedRect(in: rect, cornerSize: CGSize(width: 3, height: 3))
        p.move(to: CGPoint(x: rect.midX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        p.move(to: CGPoint(x: rect.minX, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return p
    }
}

// MARK: - Table / Chair / Mug / Plate
struct TableShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width, h = rect.height
        p.addRoundedRect(in: CGRect(x: rect.minX, y: rect.minY + h*0.20, width: w, height: h*0.18),
                         cornerSize: CGSize(width: 3, height: 3))
        p.addRect(CGRect(x: rect.minX + w*0.12, y: rect.minY + h*0.38, width: w*0.08, height: h*0.55))
        p.addRect(CGRect(x: rect.maxX - w*0.20, y: rect.minY + h*0.38, width: w*0.08, height: h*0.55))
        return p
    }
}

struct ChairShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width, h = rect.height
        p.addRect(CGRect(x: rect.minX + w*0.20, y: rect.minY, width: w*0.60, height: h*0.55))
        p.addRect(CGRect(x: rect.minX, y: rect.minY + h*0.50, width: w, height: h*0.16))
        p.addRect(CGRect(x: rect.minX + w*0.12, y: rect.minY + h*0.66, width: w*0.10, height: h*0.34))
        p.addRect(CGRect(x: rect.maxX - w*0.22, y: rect.minY + h*0.66, width: w*0.10, height: h*0.34))
        return p
    }
}

struct MugShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width, h = rect.height
        p.addRoundedRect(in: CGRect(x: rect.minX, y: rect.minY, width: w*0.75, height: h),
                         cornerSize: CGSize(width: w*0.07, height: w*0.07))
        let handle = CGRect(x: rect.minX + w*0.70, y: rect.minY + h*0.25, width: w*0.28, height: h*0.45)
        p.addPath(Path(roundedRect: handle, cornerSize: CGSize(width: w*0.14, height: w*0.14)))
        let inner = CGRect(x: rect.minX + w*0.74, y: rect.minY + h*0.32, width: w*0.18, height: h*0.30)
        p.addPath(Path(roundedRect: inner, cornerSize: CGSize(width: 4, height: 4)))
        return p
    }
}

struct PlateShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.addEllipse(in: rect)
        let inset = rect.insetBy(dx: rect.width * 0.12, dy: rect.height * 0.12)
        p.addEllipse(in: inset)
        return p
    }
}

// MARK: - Scroll / Coin / Quill / Lantern
struct ScrollShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width, h = rect.height
        p.move(to: CGPoint(x: rect.minX + w*0.10, y: rect.minY + h*0.10))
        p.addLine(to: CGPoint(x: rect.maxX - w*0.10, y: rect.minY + h*0.10))
        p.addQuadCurve(to: CGPoint(x: rect.maxX - w*0.10, y: rect.maxY - h*0.20),
                       control: CGPoint(x: rect.maxX, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.minX + w*0.10, y: rect.maxY - h*0.20))
        p.addQuadCurve(to: CGPoint(x: rect.minX + w*0.10, y: rect.minY + h*0.10),
                       control: CGPoint(x: rect.minX, y: rect.midY))
        p.closeSubpath()
        p.addRoundedRect(in: CGRect(x: rect.minX, y: rect.minY + h*0.05, width: w*0.20, height: h*0.10),
                         cornerSize: CGSize(width: 3, height: 3))
        p.addRoundedRect(in: CGRect(x: rect.maxX - w*0.20, y: rect.maxY - h*0.20, width: w*0.20, height: h*0.10),
                         cornerSize: CGSize(width: 3, height: 3))
        return p
    }
}

struct CoinShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.addEllipse(in: rect)
        let inner = rect.insetBy(dx: rect.width * 0.20, dy: rect.height * 0.20)
        p.move(to: CGPoint(x: inner.midX - inner.width*0.15, y: inner.midY))
        p.addLine(to: CGPoint(x: inner.midX + inner.width*0.15, y: inner.midY))
        p.move(to: CGPoint(x: inner.midX, y: inner.midY - inner.height*0.20))
        p.addLine(to: CGPoint(x: inner.midX, y: inner.midY + inner.height*0.20))
        return p
    }
}

struct QuillShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width, h = rect.height
        p.move(to: CGPoint(x: rect.minX + w*0.18, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.maxX - w*0.20, y: rect.minY + h*0.18))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX - w*0.16, y: rect.minY + h*0.34))
        p.closeSubpath()
        return p
    }
}

struct LanternShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width, h = rect.height
        // Handle
        p.move(to: CGPoint(x: rect.midX - w*0.20, y: rect.minY + h*0.10))
        p.addQuadCurve(to: CGPoint(x: rect.midX + w*0.20, y: rect.minY + h*0.10),
                       control: CGPoint(x: rect.midX, y: rect.minY - h*0.06))
        // Top cap
        p.addRect(CGRect(x: rect.minX + w*0.20, y: rect.minY + h*0.10, width: w*0.60, height: h*0.10))
        // Body
        p.addRoundedRect(in: CGRect(x: rect.minX + w*0.10, y: rect.minY + h*0.20, width: w*0.80, height: h*0.60),
                         cornerSize: CGSize(width: 4, height: 4))
        // Base
        p.addRect(CGRect(x: rect.minX + w*0.20, y: rect.minY + h*0.80, width: w*0.60, height: h*0.10))
        // Flame
        p.move(to: CGPoint(x: rect.midX, y: rect.minY + h*0.35))
        p.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.minY + h*0.60),
                       control: CGPoint(x: rect.midX + w*0.12, y: rect.minY + h*0.50))
        p.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.minY + h*0.35),
                       control: CGPoint(x: rect.midX - w*0.12, y: rect.minY + h*0.50))
        return p
    }
}

// MARK: - Chevron / Padlock / Check / X / Star / Heart / Chain / Shield
struct ChevronShape: Shape {
    var pointingRight: Bool = true
    func path(in rect: CGRect) -> Path {
        var p = Path()
        if pointingRight {
            p.move(to: CGPoint(x: rect.minX, y: rect.minY))
            p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        } else {
            p.move(to: CGPoint(x: rect.maxX, y: rect.minY))
            p.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        }
        return p
    }
}

struct PadlockShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width, h = rect.height
        let shackle = CGRect(x: rect.minX + w*0.22, y: rect.minY, width: w*0.56, height: h*0.45)
        p.addPath(Path(roundedRect: shackle, cornerSize: CGSize(width: w*0.28, height: w*0.28)))
        let body = CGRect(x: rect.minX + w*0.10, y: rect.minY + h*0.40, width: w*0.80, height: h*0.55)
        p.addPath(Path(roundedRect: body, cornerSize: CGSize(width: 5, height: 5)))
        return p
    }
}

struct CheckShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.minX + rect.width*0.1, y: rect.minY + rect.height*0.55))
        p.addLine(to: CGPoint(x: rect.minX + rect.width*0.4, y: rect.minY + rect.height*0.85))
        p.addLine(to: CGPoint(x: rect.maxX - rect.width*0.1, y: rect.minY + rect.height*0.20))
        return p
    }
}

struct XMarkShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: rect.origin)
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        p.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        return p
    }
}

struct StarShape: Shape {
    var points: Int = 5
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let r1 = min(rect.width, rect.height) / 2
        let r2 = r1 * 0.45
        for i in 0..<(points * 2) {
            let a = (CGFloat(i) / CGFloat(points * 2)) * 2 * .pi - .pi/2
            let r = (i % 2 == 0) ? r1 : r2
            let pt = CGPoint(x: center.x + cos(a) * r, y: center.y + sin(a) * r)
            if i == 0 { p.move(to: pt) } else { p.addLine(to: pt) }
        }
        p.closeSubpath()
        return p
    }
}

struct HeartShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width, h = rect.height
        p.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        p.addCurve(to: CGPoint(x: rect.minX, y: rect.minY + h*0.30),
                   control1: CGPoint(x: rect.minX - w*0.1, y: rect.midY + h*0.10),
                   control2: CGPoint(x: rect.minX, y: rect.minY + h*0.55))
        p.addArc(center: CGPoint(x: rect.minX + w*0.25, y: rect.minY + h*0.27),
                 radius: w*0.25, startAngle: .degrees(180), endAngle: .degrees(0), clockwise: false)
        p.addArc(center: CGPoint(x: rect.minX + w*0.75, y: rect.minY + h*0.27),
                 radius: w*0.25, startAngle: .degrees(180), endAngle: .degrees(0), clockwise: false)
        p.addCurve(to: CGPoint(x: rect.midX, y: rect.maxY),
                   control1: CGPoint(x: rect.maxX, y: rect.minY + h*0.55),
                   control2: CGPoint(x: rect.maxX + w*0.1, y: rect.midY + h*0.10))
        p.closeSubpath()
        return p
    }
}

struct ChainShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width, h = rect.height
        let r1 = CGRect(x: rect.minX, y: rect.minY + h*0.10, width: w*0.50, height: h*0.50)
        let r2 = CGRect(x: rect.maxX - w*0.50, y: rect.minY + h*0.40, width: w*0.50, height: h*0.50)
        p.addPath(Path(roundedRect: r1, cornerSize: CGSize(width: w*0.20, height: w*0.20)))
        p.addPath(Path(roundedRect: r2, cornerSize: CGSize(width: w*0.20, height: w*0.20)))
        return p
    }
}

struct ShieldShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width, h = rect.height
        p.move(to: CGPoint(x: rect.midX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + h*0.18))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + h*0.55))
        p.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.maxY),
                       control: CGPoint(x: rect.maxX - w*0.10, y: rect.maxY - h*0.10))
        p.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.minY + h*0.55),
                       control: CGPoint(x: rect.minX + w*0.10, y: rect.maxY - h*0.10))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.minY + h*0.18))
        p.closeSubpath()
        return p
    }
}

// MARK: - Tab icons (composed)
struct TabInnIcon: View {
    let size: CGFloat
    let color: Color
    var body: some View {
        ZStack {
            BuildingShape().stroke(color, style: StrokeStyle(lineWidth: 1.6, lineJoin: .round))
            DoorShape().stroke(color, lineWidth: 1.4).frame(width: size*0.22, height: size*0.30)
                .offset(y: size*0.18)
        }
        .frame(width: size, height: size)
    }
}

struct TabGuestsIcon: View {
    let size: CGFloat
    let color: Color
    var body: some View {
        ZStack {
            Circle().stroke(color, lineWidth: 1.6).frame(width: size*0.42, height: size*0.42)
                .offset(y: -size*0.16)
            HourglassCloakShape().stroke(color, style: StrokeStyle(lineWidth: 1.6, lineJoin: .round))
                .frame(width: size*0.80, height: size*0.50)
                .offset(y: size*0.20)
        }
        .frame(width: size, height: size)
    }
}

struct HourglassCloakShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.midX, y: rect.minY))
        p.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY),
                       control: CGPoint(x: rect.maxX + rect.width*0.10, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        p.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.minY),
                       control: CGPoint(x: rect.minX - rect.width*0.10, y: rect.midY))
        p.closeSubpath()
        return p
    }
}

struct TabRumorsIcon: View {
    let size: CGFloat
    let color: Color
    var body: some View {
        ScrollShape().stroke(color, style: StrokeStyle(lineWidth: 1.6, lineJoin: .round))
            .frame(width: size, height: size)
    }
}

struct TabSettlementsIcon: View {
    let size: CGFloat
    let color: Color
    var body: some View {
        ZStack {
            Path { p in
                p.move(to: CGPoint(x: size*0.10, y: size*0.85))
                p.addLine(to: CGPoint(x: size*0.50, y: size*0.30))
                p.addLine(to: CGPoint(x: size*0.90, y: size*0.85))
            }.stroke(color, style: StrokeStyle(lineWidth: 1.6, lineJoin: .round))
            Circle().stroke(color, lineWidth: 1.6).frame(width: size*0.16, height: size*0.16)
                .offset(x: -size*0.20, y: size*0.05)
            Circle().stroke(color, lineWidth: 1.6).frame(width: size*0.16, height: size*0.16)
                .offset(x: size*0.20, y: size*0.05)
        }
        .frame(width: size, height: size)
    }
}

struct TabMoreIcon: View {
    let size: CGFloat
    let color: Color
    var body: some View {
        VStack(spacing: size*0.10) {
            HStack(spacing: size*0.10) {
                dot
                dot
            }
            HStack(spacing: size*0.10) {
                dot
                dot
            }
        }
        .frame(width: size, height: size)
    }
    private var dot: some View {
        Circle().fill(color).frame(width: size*0.18, height: size*0.18)
    }
}

// MARK: - Reusable icon container
struct IconBadge: View {
    let size: CGFloat
    let bg: Color
    let fg: Color
    let icon: AnyView
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size*0.24)
                .fill(bg)
            icon
                .frame(width: size*0.62, height: size*0.62)
                .foregroundColor(fg)
        }
        .frame(width: size, height: size)
    }
}
