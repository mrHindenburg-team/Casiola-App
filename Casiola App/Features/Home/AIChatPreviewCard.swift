import SwiftUI

struct AIChatPreviewCard: View {
    @Environment(\.changeTab) private var changeTab

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Header row
            HStack(spacing: 10) {
                ZStack {
                    Circle()
                        .fill(LinearGradient.goldRose)
                        .frame(width: 36, height: 36)
                    Image(systemName: "sparkles")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color.casiolaBackground)
                }

                VStack(alignment: .leading, spacing: 1) {
                    Text("Casiola AI")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.casiolaTextPrimary)
                    Text("On-device · Private")
                        .font(.system(size: 11, weight: .regular))
                        .foregroundStyle(Color.casiolaGold)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color.casiolaTextSecondary)
            }

            // Preview message bubble
            HStack(alignment: .bottom, spacing: 8) {
                Circle()
                    .fill(LinearGradient.goldRose)
                    .frame(width: 26, height: 26)
                    .overlay {
                        Image(systemName: "sparkles")
                            .font(.system(size: 11))
                            .foregroundStyle(Color.casiolaBackground)
                    }

                Text("Hi! I'm Casiola. Ask me anything about style, outfits, or your wardrobe.")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(Color.casiolaTextPrimary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.casiolaCard)
                    .clipShape(.rect(cornerRadius: 14, style: .continuous))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            // Quick prompts
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(FashionDataStore.suggestedPrompts, id: \.self) { prompt in
                        Button(prompt) {
                            changeTab(.chat)
                        }
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color.casiolaTextPrimary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(Color.casiolaCard)
                        .clipShape(.rect(cornerRadius: 20))
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.casiolaStroke, lineWidth: 0.5)
                        }
                    }
                }
                .padding(.horizontal, 1)
            }
            .scrollIndicators(.hidden)
        }
        .padding(16)
        .background(Color.casiolaSurface)
        .clipShape(.rect(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.casiolaStroke, lineWidth: 0.5)
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .onTapGesture {
            changeTab(.chat)
        }
    }
}
