import SwiftUI

struct PremiumBanner: View {
    @Environment(\.changeTab) private var changeTab
    @Environment(StoreManager.self) private var store

    var body: some View {
        if !store.hasPremiumStyle || !store.hasAICoach {
            bannerContent
        }
    }

    private var bannerContent: some View {
        ZStack(alignment: .leading) {
            LinearGradient.premiumBanner
                .clipShape(.rect(cornerRadius: 20))

            // Decorative circles
            Circle()
                .fill(Color.casiolaGold.opacity(0.12))
                .frame(width: 120, height: 120)
                .offset(x: 220, y: -30)

            Circle()
                .fill(Color.casiolaRose.opacity(0.10))
                .frame(width: 80, height: 80)
                .offset(x: 260, y: 40)

            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 6) {
                        Image(systemName: "crown.fill")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.casiolaGold)
                        Text("Upgrade to Premium")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.casiolaTextPrimary)
                    }

                    Text("Unlock exclusive collections, AI coaching & more")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color.casiolaTextSecondary)
                        .lineLimit(2)

                    Button("Explore Plans") {
                        changeTab(.premium)
                    }
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(Color.casiolaBackground)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 7)
                    .background(LinearGradient.goldRose)
                    .clipShape(.rect(cornerRadius: 20))
                    .padding(.top, 4)
                }

                Spacer()
            }
            .padding(20)
        }
        .padding(.horizontal, 16)
        .padding(.top, 28)
        .padding(.bottom, 8)
    }
}
