import Foundation
import FoundationModels

@Observable
@MainActor
final class AIManager {

    // MARK: - Public state

    var messages: [ChatMessage] = []
    var isThinking = false
    var isDeviceAIAvailable = false

    // MARK: - System prompt (also used by FashionAISession)

    static let systemPrompt = """
        You are Casiola, a personal AI fashion and style assistant with an elegant, warm personality. \
        Help users with outfit choices, color coordination, wardrobe planning, and current fashion trends. \
        Keep every reply concise (under 80 words), encouraging, and stylish. \
        Focus only on fashion and style topics.
        """

    // MARK: - Private

    // Stores a FashionAISession when running on iOS 26+; typed as AnyObject
    // so that the property declaration itself does not require @available.
    private var sessionHolder: AnyObject?

    // MARK: - Init

    init() {
        if #available(iOS 26.0, *) {
            setupFoundationModels()
        }
    }

    // MARK: - Actions

    func send(_ text: String) async {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        messages.append(ChatMessage(role: .user, content: trimmed))
        isThinking = true
        defer { isThinking = false }

        if #available(iOS 26.0, *), let session = sessionHolder as? FashionAISession {
            do {
                let reply = try await session.respond(to: trimmed)
                messages.append(ChatMessage(role: .assistant, content: reply))
            } catch {
                messages.append(ChatMessage(role: .assistant, content: "I had a moment — please try again!"))
            }
        } else {
            await sendFallback(for: trimmed)
        }
    }

    // MARK: - Private helpers

    @available(iOS 26.0, *)
    private func setupFoundationModels() {
        guard case .available = SystemLanguageModel.default.availability else { return }
        isDeviceAIAvailable = true
        sessionHolder = FashionAISession()
    }

    private func sendFallback(for text: String) async {
        try? await Task.sleep(for: .seconds(1.2))
        messages.append(ChatMessage(role: .assistant, content: localResponse(for: text)))
    }

    private func localResponse(for text: String) -> String {
        let t = text.lowercased()
        if t.contains("outfit") || t.contains("wear") || t.contains("dress") {
           return "Layer neutrals for effortless elegance — cream linen trousers, a fitted tank, structured blazer. Finish with pointed flats and one bold accessory."
        } else if t.contains("color") || t.contains("colour") || t.contains("palette") {
            return "Top combos this season: mocha brown with ivory, cobalt blue with warm white, sage green with terracotta. All feel polished yet fresh."
        } else if t.contains("trend") || t.contains("season") {
            return "Leading trends: quiet luxury, sheer layering, sculptural shoulders, and chocolate brown as the new neutral. Build around one trend for maximum impact."
        } else if t.contains("casual") {
            return "Effortless casual: barrel-leg jeans + ribbed tank + chunky loafers. A lightweight linen blazer turns it polished in seconds."
        } else if t.contains("formal") || t.contains("work") || t.contains("office") {
            return "A tailored blazer over a silk blouse with wide-leg trousers reads powerful without trying too hard. Add a structured bag."
        } else if t.contains("date") || t.contains("evening") || t.contains("night") {
            return "A midi wrap dress in a deep jewel tone — emerald, burgundy, or navy — is a timeless evening choice. Add strappy heels and a gold necklace."
        } else if t.contains("summer") || t.contains("warm") {
            return "Summer essentials: linen co-ords, breezy midi skirts, strappy sandals. A quality woven tote ties every summer look together."
        } else if t.contains("winter") || t.contains("cold") {
            return "Winter layering: cashmere turtleneck + structured wool coat + slim trousers. Monochromatic in camel or charcoal always looks intentional."
        } else if t.contains("capsule") || t.contains("wardrobe") {
            return "Core capsule pieces: white shirt, black trousers, dark jeans, trench coat, blazer, striped top, midi skirt, ankle boots, white sneakers, classic bag. Mix endlessly."
        } else {
            return "Tell me more! What's the occasion, your current wardrobe, or the vibe you're going for? I'll craft the perfect look for you."
        }
    }
}
