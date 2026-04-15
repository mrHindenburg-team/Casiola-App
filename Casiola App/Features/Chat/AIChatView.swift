import SwiftUI

struct AIChatView: View {
    @Environment(AIManager.self) private var ai
    @State private var inputText = ""
    @State private var showOnDeviceAlert = true

    var body: some View {
        VStack(spacing: 0) {
            chatHeader
            messagesArea
            ChatInputBar(text: $inputText, isThinking: ai.isThinking, onSend: sendMessage)
        }
        .background(Color.casiolaBackground)
        .alert("On-Device AI", isPresented: $showOnDeviceAlert) {
            Button("Got it") { }
        } message: {
            Text("Casiola AI runs entirely on your device using Apple's on-device language model. Your conversations are completely private and never leave your iPhone.")
        }
    }

    // MARK: - Subviews

    private var chatHeader: some View {
        HStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(LinearGradient.goldRose)
                    .frame(width: 38, height: 38)
                Image(systemName: "sparkles")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.casiolaBackground)
            }

            VStack(alignment: .leading, spacing: 1) {
                Text("Casiola AI")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(Color.casiolaTextPrimary)

                HStack(spacing: 4) {
                    Circle()
                        .fill(ai.isDeviceAIAvailable ? Color(red: 0.3, green: 0.8, blue: 0.4) : Color.casiolaTextSecondary)
                        .frame(width: 6, height: 6)
                    Text(ai.isDeviceAIAvailable ? "On-device · Private" : "Local mode")
                        .font(.system(size: 11, weight: .regular))
                        .foregroundStyle(Color.casiolaTextSecondary)
                }
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.casiolaSurface)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color.casiolaStroke)
                .frame(height: 0.5)
        }
    }

    private var messagesArea: some View {
        ScrollViewReader { proxy in
            ScrollView {
                if ai.messages.isEmpty {
                    emptyChatState
                } else {
                    LazyVStack(spacing: 12) {
                        ForEach(ai.messages) { message in
                            ChatBubble(message: message)
                                .id(message.id)
                        }

                        if ai.isThinking {
                            ThinkingIndicator()
                        }

                        Color.clear
                            .frame(height: 1)
                            .id("bottom")
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
            }
            .scrollIndicators(.hidden)
            .onChange(of: ai.messages.count) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    proxy.scrollTo("bottom", anchor: .bottom)
                }
            }
            .onChange(of: ai.isThinking) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    proxy.scrollTo("bottom", anchor: .bottom)
                }
            }
        }
        .frame(maxHeight: .infinity)
    }

    private var emptyChatState: some View {
        VStack(spacing: 24) {
            Spacer(minLength: 40)

            ZStack {
                Circle()
                    .fill(Color.casiolaGold.opacity(0.12))
                    .frame(width: 80, height: 80)
                Image(systemName: "sparkles")
                    .font(.system(size: 34, weight: .light))
                    .foregroundStyle(Color.casiolaGold)
            }

            VStack(spacing: 8) {
                Text("Your Style Assistant")
                    .font(.system(size: 22, weight: .light, design: .serif))
                    .foregroundStyle(Color.casiolaTextPrimary)
                Text("Ask me anything about outfits, trends, and personal style.")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(Color.casiolaTextSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }

            VStack(spacing: 8) {
                ForEach(FashionDataStore.suggestedPrompts, id: \.self) { prompt in
                    Button(prompt, action: { sendPrompt(prompt) })
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(Color.casiolaTextPrimary)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.casiolaSurface)
                        .clipShape(.rect(cornerRadius: 12))
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.casiolaStroke, lineWidth: 0.5)
                        }
                }
            }
            .padding(.horizontal, 20)

            Spacer()
        }
    }

    // MARK: - Actions

    private func sendMessage() {
        let text = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }
        inputText = ""
        Task { await ai.send(text) }
    }

    private func sendPrompt(_ prompt: String) {
        Task { await ai.send(prompt) }
    }
}

private struct ThinkingIndicator: View {
    @State private var phase = 0

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            ZStack {
                Circle()
                    .fill(LinearGradient.goldRose)
                    .frame(width: 28, height: 28)
                Image(systemName: "sparkles")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.casiolaBackground)
            }

            HStack(spacing: 4) {
                ForEach(0 ..< 3, id: \.self) { index in
                    Circle()
                        .fill(Color.casiolaTextSecondary)
                        .frame(width: 6, height: 6)
                        .opacity(phase == index ? 1 : 0.3)
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(Color.casiolaCard)
            .clipShape(.rect(cornerRadius: 18))

            Spacer(minLength: 60)
        }
        .task {
            while !Task.isCancelled {
                for i in 0 ..< 3 {
                    phase = i
                    try? await Task.sleep(for: .seconds(0.4))
                }
            }
        }
    }
}

#Preview {
    AIChatView()
        .environment(AIManager())
}
