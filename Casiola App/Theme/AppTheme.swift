import SwiftUI

// MARK: - Custom colours (no system colours used anywhere)

extension Color {
    static let casiolaBackground     = Color(red: 0.039, green: 0.039, blue: 0.059)
    static let casiolaSurface        = Color(red: 0.086, green: 0.086, blue: 0.122)
    static let casiolaCard           = Color(red: 0.118, green: 0.118, blue: 0.165)
    static let casiolaGold           = Color(red: 0.831, green: 0.686, blue: 0.216)
    static let casiolaRose           = Color(red: 0.910, green: 0.706, blue: 0.722)
    static let casiolaTextPrimary    = Color(red: 0.941, green: 0.929, blue: 0.906)
    static let casiolaTextSecondary  = Color(red: 0.545, green: 0.533, blue: 0.565)
    static let casiolaStroke         = Color(red: 0.165, green: 0.165, blue: 0.224)
    static let casiolaDeepPurple     = Color(red: 0.220, green: 0.145, blue: 0.360)
}

// MARK: - Gradient presets

extension LinearGradient {
    static let goldRose = LinearGradient(
        colors: [.casiolaGold, .casiolaRose],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    static let casiolaBackground = LinearGradient(
        colors: [Color(red: 0.039, green: 0.039, blue: 0.059),
                 Color(red: 0.059, green: 0.047, blue: 0.090)],
        startPoint: .top,
        endPoint: .bottom
    )
    static let premiumBanner = LinearGradient(
        colors: [Color(red: 0.220, green: 0.145, blue: 0.360),
                 Color(red: 0.140, green: 0.086, blue: 0.220)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

// MARK: - Environment key for tab switching

extension EnvironmentValues {
    @Entry var changeTab: (AppTab) -> Void = { _ in }
}
