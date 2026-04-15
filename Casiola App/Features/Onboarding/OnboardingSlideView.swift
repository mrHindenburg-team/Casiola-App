import SwiftUI

struct OnboardingSlideView: View {
    let slide: OnboardingSlide

    var body: some View {
        ZStack(alignment: .bottom) {
            backgroundLayer
            gradientOverlay
            contentLayer
        }
        .ignoresSafeArea()
    }

    // MARK: - Sub-layers

    private var backgroundLayer: some View {
        Group {
            // Real image (if present in assets)
            if UIImage(named: slide.imageName) != nil {
                Image(slide.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
            } else {
                // Beautiful gradient placeholder until images are added
                slide.placeholderGradient
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }

    private var gradientOverlay: some View {
        LinearGradient(
            stops: [
                .init(color: .clear, location: 0.0),
                .init(color: Color.casiolaBackground.opacity(0.10), location: 0.30),
                .init(color: Color.casiolaBackground.opacity(0.55), location: 0.55),
                .init(color: Color.casiolaBackground.opacity(0.90), location: 0.75),
                .init(color: Color.casiolaBackground, location: 0.88),
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }

    private var contentLayer: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Eyebrow label
            Text(slide.label)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(Color.casiolaGold)
                .tracking(3)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.casiolaGold.opacity(0.12))
                .clipShape(.rect(cornerRadius: 6))

            // Title (multiline serif)
            Text(slide.title)
                .font(.system(size: 40, weight: .ultraLight, design: .serif))
                .foregroundStyle(Color.casiolaTextPrimary)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)

            // Subtitle
            Text(slide.subtitle)
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(Color.casiolaTextSecondary)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        // Leave 200 pt at the bottom for the nav controls
        .padding(.horizontal, 28)
        .padding(.bottom, 200)
    }
}
