import SwiftUI

struct PremiumView: View {
    @Environment(StoreManager.self) private var store
    @State private var showError = false

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                premiumHeader

                if store.isLoading {
                    ProgressView()
                        .tint(Color.casiolaGold)
                        .padding(.top, 40)
                } else {
                    productCards
                }

                restoreButton

                legalFooter
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .background(Color.casiolaBackground)
        .scrollIndicators(.hidden)
        .task { await store.load() }
        .alert("Error", isPresented: $showError) {
        } message: {
            Text(store.purchaseError ?? "Something went wrong.")
        }
        .onChange(of: store.purchaseError) { _, error in
            showError = error != nil
        }
    }

    // MARK: - Subviews

    private var premiumHeader: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.casiolaGold.opacity(0.12))
                    .frame(width: 80, height: 80)
                Image(systemName: "crown.fill")
                    .font(.system(size: 34, weight: .light))
                    .foregroundStyle(Color.casiolaGold)
            }
            .padding(.top, 24)

            Text("Upgrade Casiola")
                .font(.system(size: 28, weight: .light, design: .serif))
                .foregroundStyle(Color.casiolaTextPrimary)

            Text("Unlock exclusive styles, premium collections, and the full power of your AI style coach.")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(Color.casiolaTextSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
        }
    }

    private var productCards: some View {
        VStack(spacing: 16) {
            if let product = store.premiumStyleProduct {
                ProductCard(
                    product: product,
                    isPurchased: store.hasPremiumStyle,
                    features: [
                        "Seasonal lookbooks & trend reports",
                        "Curated colour palette guides",
                    ],
                    accentGradient: LinearGradient.goldRose,
                    onBuy: { await store.purchase(product) }
                )
            } else {
                PlaceholderProductCard(
                    title: "Premium Style Pack",
                    price: "$1.99",
                    features: [
                        "Exclusive outfit collections",
                        "Curated colour palette guides",
                    ]
                )
            }

            if let product = store.aiCoachProduct {
                ProductCard(
                    product: product,
                    isPurchased: store.hasAICoach,
                    features: [
                        "Unlimited personalised AI recommendations",
                        "Priority access to new AI features",
                    ],
                    accentGradient: LinearGradient(
                        colors: [Color.casiolaDeepPurple, Color.casiolaRose],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    onBuy: { await store.purchase(product) }
                )
            } else {
                PlaceholderProductCard(
                    title: "AI Style Coach Pro",
                    price: "$1.99",
                    features: [
                        "Unlimited AI styling sessions",
                        "Virtual wardrobe analysis",
                        "Occasion-specific planning",
                    ]
                )
            }
        }
    }

    private var restoreButton: some View {
        Button("Restore Purchases") {
            Task { await store.restore() }
        }
        .font(.system(size: 14, weight: .medium))
        .foregroundStyle(Color.casiolaTextSecondary)
        .padding(.top, 4)
    }

    private var legalFooter: some View {
        Text("Purchases are non-consumable one-time payments. Managed through your Apple ID.\nSee our Terms of Service and Privacy Policy for details.")
            .font(.system(size: 11, weight: .regular))
            .foregroundStyle(Color.casiolaTextSecondary.opacity(0.6))
            .multilineTextAlignment(.center)
            .padding(.bottom, 8)
    }
}

// Shown while StoreKit loads products — prevents empty screen
private struct PlaceholderProductCard: View {
    let title: String
    let price: String
    let features: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 18, weight: .semibold, design: .serif))
                        .foregroundStyle(Color.casiolaTextPrimary)
                    Text(price)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(Color.casiolaGold)
                    Text("one-time purchase")
                        .font(.system(size: 11))
                        .foregroundStyle(Color.casiolaTextSecondary)
                }
                Spacer()
            }

            VStack(alignment: .leading, spacing: 8) {
                ForEach(features, id: \.self) { f in
                    HStack(spacing: 8) {
                        Image(systemName: "sparkle")
                            .font(.system(size: 10))
                            .foregroundStyle(Color.casiolaGold)
                        Text(f)
                            .font(.system(size: 13))
                            .foregroundStyle(Color.casiolaTextSecondary)
                    }
                }
            }

            RoundedRectangle(cornerRadius: 12)
                .fill(Color.casiolaCard)
                .frame(height: 46)
                .overlay {
                    Text("Loading…")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.casiolaTextSecondary)
                }
        }
        .padding(20)
        .background(Color.casiolaSurface)
        .clipShape(.rect(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.casiolaStroke, lineWidth: 0.5)
        }
    }
}

#Preview {
    PremiumView()
        .environment(StoreManager())
}
