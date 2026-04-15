import Foundation

enum AppTab: String, CaseIterable, Identifiable {
    case home    = "Home"
    case explore = "Explore"
    case chat    = "Chat"
    case premium = "Premium"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .home:    "house.fill"
        case .explore: "sparkles"
        case .chat:    "bubble.left.and.bubble.right.fill"
        case .premium: "crown.fill"
        }
    }
}
