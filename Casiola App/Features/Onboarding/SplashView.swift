import SwiftUI

struct SplashView: View {
    let onComplete: () -> Void

    // MARK: - Animation state

    @State private var logoScale: Double    = 0.08
    @State private var logoOpacity: Double  = 0
    @State private var glowScale: Double    = 0.4
    @State private var glowOpacity: Double  = 0
    @State private var brandOpacity: Double = 0
    @State private var lineWidth: Double    = 0
    @State private var taglineOpacity: Double = 0
    @State private var sparkleOpacities: [Double] = Array(repeating: 0, count: 6)
    @State private var sparkleOffsets: [Double]   = Array(repeating: 0, count: 6)

    // Fixed spark positions so layout is deterministic
    private let sparks: [(x: Double, y: Double, size: Double)] = [
        (-100, -55, 13), ( 88, -72, 10), (-62, -108, 9),
        ( 105,  18, 12), (-28,  65, 8),  ( 68,  75, 11),
    ]

    // MARK: - Body

    var body: some View {
        ZStack {
            Color.casiolaBackground.ignoresSafeArea()

            // Radial glow behind logo
            RadialGradient(
                colors: [Color.casiolaGold.opacity(0.28), Color.clear],
                center: .center,
                startRadius: 0,
                endRadius: 120
            )
            .frame(width: 260, height: 260)
            .scaleEffect(glowScale)
            .opacity(glowOpacity)
            .allowsHitTesting(false)

            // Floating sparkles
            ForEach(sparks.indices, id: \.self) { i in
                Image(systemName: "sparkle")
                    .font(.system(size: sparks[i].size, weight: .ultraLight))
                    .foregroundStyle(LinearGradient.goldRose)
                    .offset(x: sparks[i].x, y: sparks[i].y - sparkleOffsets[i])
                    .opacity(sparkleOpacities[i])
                    .allowsHitTesting(false)
            }

            // Core content
            VStack(spacing: 0) {
                // C lettermark
                Text("C")
                    .font(.system(size: 100, weight: .ultraLight, design: .serif))
                    .foregroundStyle(LinearGradient.goldRose)
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)

                // Divider line that grows
                Rectangle()
                    .fill(LinearGradient.goldRose)
                    .frame(width: lineWidth, height: 0.5)
                    .padding(.vertical, 18)

                // Brand name
                Text("CASIOLA")
                    .font(.system(size: 15, weight: .light))
                    .foregroundStyle(Color.casiolaTextPrimary)
                    .tracking(10)
                    .opacity(brandOpacity)

                // Tagline
                Text("Your Style, Elevated")
                    .font(.system(size: 13, weight: .regular, design: .serif))
                    .foregroundStyle(Color.casiolaTextSecondary)
                    .padding(.top, 10)
                    .opacity(taglineOpacity)
            }
        }
        .task { await runAnimation() }
    }

    // MARK: - Animation sequence

    private func runAnimation() async {
        // 1. Glow ring expands
        withAnimation(.easeOut(duration: 0.9)) {
            glowScale   = 1.0
            glowOpacity = 1.0
        }

        // 2. Logo springs in (simultaneous)
        withAnimation(.spring(response: 0.75, dampingFraction: 0.45)) {
            logoScale   = 1.0
            logoOpacity = 1.0
        }

        try? await Task.sleep(for: .seconds(0.55))

        // 3. Divider line grows
        withAnimation(.easeOut(duration: 0.45)) {
            lineWidth = 120
        }

        try? await Task.sleep(for: .seconds(0.25))

        // 4. Brand text fades in
        withAnimation(.easeInOut(duration: 0.5)) {
            brandOpacity = 1.0
        }

        try? await Task.sleep(for: .seconds(0.3))

        // 5. Tagline fades in
        withAnimation(.easeInOut(duration: 0.45)) {
            taglineOpacity = 1.0
        }

        // 6. Sparkles float up (staggered via animation delay)
        for i in sparks.indices {
            let delay = Double(i) * 0.08
            withAnimation(.easeOut(duration: 1.1).delay(delay)) {
                sparkleOpacities[i] = 0.9
                sparkleOffsets[i]   = 44
            }
            withAnimation(.easeIn(duration: 0.35).delay(delay + 0.75)) {
                sparkleOpacities[i] = 0
            }
        }

        try? await Task.sleep(for: .seconds(1.5))

        // 7. Fade everything out
        withAnimation(.easeInOut(duration: 0.55)) {
            logoOpacity    = 0
            brandOpacity   = 0
            taglineOpacity = 0
            glowOpacity    = 0
            lineWidth      = 0
        }

        try? await Task.sleep(for: .seconds(0.55))

        onComplete()
    }
}

#Preview {
    SplashView(onComplete: { })
}
