import SwiftUI

struct ChatInputBar: View {
    @Binding var text: String
    let isThinking: Bool
    let onSend: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            TextField("Ask about style, outfits, trends…", text: $text, axis: .vertical)
                .font(.system(size: 15))
                .foregroundStyle(Color.casiolaTextPrimary)
                .tint(Color.casiolaGold)
                .lineLimit(1...5)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(Color.casiolaCard)
                .clipShape(.rect(cornerRadius: 22))
                .overlay {
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(Color.casiolaStroke, lineWidth: 0.5)
                }
                .onSubmit(onSend)

            Button(action: onSend) {
                ZStack {
                    Circle()
                        .fill(text.trimmingCharacters(in: .whitespaces).isEmpty || isThinking
                              ? AnyShapeStyle(Color.casiolaCard)
                              : AnyShapeStyle(LinearGradient.goldRose))
                        .frame(width: 42, height: 42)

                    if isThinking {
                        ProgressView()
                            .tint(Color.casiolaTextSecondary)
                            .scaleEffect(0.8)
                    } else {
                        Image(systemName: "arrow.up")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(
                                text.trimmingCharacters(in: .whitespaces).isEmpty
                                ? Color.casiolaTextSecondary
                                : Color.casiolaBackground
                            )
                    }
                }
            }
            .disabled(text.trimmingCharacters(in: .whitespaces).isEmpty || isThinking)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isThinking)
            .accessibilityLabel("Send message")
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.casiolaSurface)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(Color.casiolaStroke)
                .frame(height: 0.5)
        }
    }
}
