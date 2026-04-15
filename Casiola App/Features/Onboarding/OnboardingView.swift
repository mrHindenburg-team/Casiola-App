import SwiftUI

struct OnboardingView: View {
    let onComplete: () -> Void

    @State private var currentIndex = 0

    private let slides = OnboardingSlide.all

    var body: some View {
        ZStack(alignment: .bottom) {
            // Full-screen paged slides
            TabView(selection: $currentIndex) {
                ForEach(slides) { slide in
                    OnboardingSlideView(slide: slide)
                        .tag(slide.id)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 0.35), value: currentIndex)

            // Navigation overlay
            navControls
        }
        .ignoresSafeArea()
    }

    // MARK: - Navigation controls

    private var navControls: some View {
        VStack(spacing: 0) {
            // Page dots
            PageDots(total: slides.count, current: currentIndex)
                .padding(.bottom, 28)

            // Primary button
            Button(action: handleNext) {
                Text(currentIndex == slides.count - 1 ? "Get Started" : "Next")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.casiolaBackground)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(LinearGradient.goldRose)
                    .clipShape(.rect(cornerRadius: 16))
            }
            .padding(.horizontal, 28)
            .sensoryFeedback(.impact(weight: .light), trigger: currentIndex)

            // Skip button (hidden on last slide)
            if currentIndex < slides.count - 1 {
                Button("Skip") {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        onComplete()
                    }
                }
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(Color.casiolaTextSecondary)
                .padding(.top, 16)
                .padding(.bottom, 8)
            } else {
                Color.clear.frame(height: 40)
            }
        }
        .padding(.bottom, 28)
        // Frosted-glass-style card so controls are always readable
        .background(
            LinearGradient(
                colors: [Color.casiolaBackground.opacity(0), Color.casiolaBackground.opacity(0.96)],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }

    // MARK: - Actions

    private func handleNext() {
        if currentIndex < slides.count - 1 {
            withAnimation(.spring(response: 0.45, dampingFraction: 0.78)) {
                currentIndex += 1
            }
        } else {
            onComplete()
        }
    }
}

// MARK: - Page indicator dots

private struct PageDots: View {
    let total: Int
    let current: Int

    var body: some View {
        HStack(spacing: 6) {
            ForEach(0 ..< total, id: \.self) { index in
                Capsule()
                    .fill(index == current ? Color.casiolaGold : Color.casiolaStroke)
                    .frame(width: index == current ? 24 : 6, height: 6)
                    .animation(.spring(response: 0.35, dampingFraction: 0.7), value: current)
            }
        }
    }
}

#Preview {
    OnboardingView(onComplete: { })
}
