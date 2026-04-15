import SwiftUI

struct ChatBubble: View {
    let message: ChatMessage

    private var isUser: Bool { message.role == .user }

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if isUser {
                Spacer(minLength: 60)
                Text(message.content)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(Color.casiolaBackground)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(LinearGradient.goldRose)
                    .clipShape(.rect(cornerRadius: 18, style: .continuous))
            } else {
                // AI avatar
                ZStack {
                    Circle()
                        .fill(LinearGradient.goldRose)
                        .frame(width: 28, height: 28)
                    Image(systemName: "sparkles")
                        .font(.system(size: 12))
                        .foregroundStyle(Color.casiolaBackground)
                }

                Text(message.content)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(Color.casiolaTextPrimary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(Color.casiolaCard)
                    .clipShape(.rect(cornerRadius: 18, style: .continuous))
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer(minLength: 60)
            }
        }
        .accessibilityLabel("\(isUser ? "You" : "Casiola"): \(message.content)")
    }
}
