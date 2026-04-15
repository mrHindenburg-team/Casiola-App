import Foundation

struct ChatMessage: Identifiable {
    let id = UUID()
    let role: Role
    let content: String
    let timestamp: Date = .now

    enum Role {
        case user, assistant
    }
}
