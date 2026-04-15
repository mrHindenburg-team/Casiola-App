import SwiftUI

struct OnboardingSlide: Identifiable {
    let id: Int
    let imageName: String       // Assets.xcassets key, e.g. "onboarding_1"
    let label: String           // small eyebrow label above title
    let title: String
    let subtitle: String
    let placeholderGradient: LinearGradient   // shown while real image loads / missing

    static let all: [OnboardingSlide] = [
        OnboardingSlide(
            id: 0,
            imageName: "slide1",
            label: "DISCOVER",
            title: "Your Style,\nElevated",
            subtitle: "Curated looks and outfit inspiration crafted around your unique personal aesthetic.",
            placeholderGradient: LinearGradient(
                colors: [Color(red: 0.55, green: 0.42, blue: 0.25),
                         Color(red: 0.22, green: 0.16, blue: 0.10)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        ),
        OnboardingSlide(
            id: 1,
            imageName: "slide2",
            label: "EXPLORE",
            title: "Every Look,\nEvery Mood",
            subtitle: "From quiet luxury to bold street style — the full spectrum of fashion at your fingertips.",
            placeholderGradient: LinearGradient(
                colors: [Color(red: 0.20, green: 0.14, blue: 0.36),
                         Color(red: 0.08, green: 0.06, blue: 0.16)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        ),
        OnboardingSlide(
            id: 2,
            imageName: "slide3",
            label: "AI STYLIST",
            title: "Meet Your\nCasiola AI",
            subtitle: "A personal on-device style assistant — private, instant, and always on trend.",
            placeholderGradient: LinearGradient(
                colors: [Color(red: 0.60, green: 0.45, blue: 0.12),
                         Color(red: 0.14, green: 0.10, blue: 0.04)],
                startPoint: .top,
                endPoint: .bottom
            )
        ),
        OnboardingSlide(
            id: 3,
            imageName: "slide4",
            label: "BEGIN",
            title: "Your Journey\nStarts Now",
            subtitle: "Your wardrobe. Your identity. Let's build something extraordinary together.",
            placeholderGradient: LinearGradient(
                colors: [Color(red: 0.50, green: 0.22, blue: 0.28),
                         Color(red: 0.14, green: 0.06, blue: 0.08)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        ),
    ]
}
