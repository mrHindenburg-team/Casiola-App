// Available only on iOS 26+ where the Foundation Models framework ships.
import FoundationModels

@available(iOS 26.0, *)
@MainActor
final class FashionAISession {

    private let session: LanguageModelSession

    init() {
        session = LanguageModelSession {
            Instructions("""
                You are Casiola, a personal AI fashion and style assistant with an elegant, \
                warm personality. Help users with outfit choices, color coordination, wardrobe \
                planning, and current fashion trends. Keep every reply concise (under 80 words), \
                encouraging, and stylish. Focus only on fashion and style topics.
                """)
        }
    }

    func respond(to message: String) async throws -> String {
        let response = try await session.respond(to: message)
        return response.content
    }
}
