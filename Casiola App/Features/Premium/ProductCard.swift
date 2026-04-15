import SwiftUI
import StoreKit

struct ProductCard: View {
    let product: Product
    let isPurchased: Bool
    let features: [String]
    let accentGradient: LinearGradient
    let onBuy: () async -> Void

    @State private var isBuying = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(product.displayName)
                        .font(.system(size: 18, weight: .semibold, design: .serif))
                        .foregroundStyle(Color.casiolaTextPrimary)

                    if isPurchased {
                        HStack(spacing: 4) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 12))
                            Text("Purchased")
                                .font(.system(size: 12, weight: .medium))
                        }
                        .foregroundStyle(Color(red: 0.3, green: 0.8, blue: 0.4))
                    } else {
                        Text(product.displayPrice)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(Color.casiolaGold)
                        Text("one-time purchase")
                            .font(.system(size: 11, weight: .regular))
                            .foregroundStyle(Color.casiolaTextSecondary)
                    }
                }
                Spacer()

                ZStack {
                    Circle()
                        .fill(accentGradient)
                        .frame(width: 44, height: 44)
                    Image(systemName: "crown.fill")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(Color.casiolaBackground)
                }
            }

            // Feature list
            VStack(alignment: .leading, spacing: 8) {
                ForEach(features, id: \.self) { feature in
                    HStack(spacing: 8) {
                        Image(systemName: "sparkle")
                            .font(.system(size: 10))
                            .foregroundStyle(Color.casiolaGold)
                        Text(feature)
                            .font(.system(size: 13, weight: .regular))
                            .foregroundStyle(Color.casiolaTextSecondary)
                    }
                }
            }

            // Buy button
            if !isPurchased {
                Button {
                    isBuying = true
                    Task {
                        await onBuy()
                        isBuying = false
                    }
                } label: {
                    HStack(spacing: 8) {
                        if isBuying {
                            ProgressView()
                                .tint(Color.casiolaBackground)
                                .scaleEffect(0.8)
                        } else {
                            Text("Buy for \(product.displayPrice)")
                                .font(.system(size: 15, weight: .semibold))
                        }
                    }
                    .foregroundStyle(Color.casiolaBackground)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 13)
                    .background(accentGradient)
                    .clipShape(.rect(cornerRadius: 12))
                }
                .disabled(isBuying)
                .sensoryFeedback(.success, trigger: isPurchased)
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
