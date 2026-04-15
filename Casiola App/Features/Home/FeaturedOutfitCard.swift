import SwiftUI

struct FeaturedOutfitCard: View {
    let outfit: Outfit
    @Environment(FavoritesManager.self) private var favoritesManager
    @Environment(ActivityManager.self) private var activityManager

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Gradient background
            RoundedRectangle(cornerRadius: 0)
                .fill(outfit.gradient)
                .clipShape(.rect(cornerRadius: 20))
                .frame(height: 260)

            // Dark scrim for readability
            LinearGradient(
                colors: [Color.clear, Color.casiolaBackground.opacity(0.75)],
                startPoint: .top,
                endPoint: .bottom
            )
            .clipShape(.rect(cornerRadius: 20))

            // Favorite Button
            VStack {
                HStack {
                    Spacer()
                    favoriteButton
                }
                Spacer()
            }
            .padding(20)

            // Content
            VStack(alignment: .leading, spacing: 6) {
                if outfit.isPremium {
                    PremiumBadge()
                }

                Text("Today's Pick")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(Color.casiolaGold)
                    .tracking(2)
                    .textCase(.uppercase)

                Text(outfit.name)
                    .font(.system(size: 26, weight: .light, design: .serif))
                    .foregroundStyle(Color.casiolaTextPrimary)

                Text(outfit.description)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(Color.casiolaTextSecondary)
                    .lineLimit(2)

                HStack(spacing: 6) {
                    ForEach(outfit.tags.prefix(3), id: \.self) { tag in
                        Text("#\(tag)")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(Color.casiolaTextSecondary)
                    }
                }
                .padding(.top, 2)
            }
            .padding(20)
        }
        .onAppear {
            activityManager.trackOutfitViewed()
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }

    private var favoriteButton: some View {
        Button {
            favoritesManager.toggle(outfit.id)
        } label: {
            Image(systemName: favoritesManager.isFavorite(outfit.id) ? "heart.fill" : "heart")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(favoritesManager.isFavorite(outfit.id) ? .white : .white.opacity(0.7))
                .padding(10)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                }
        }
        .buttonStyle(.plain)
        .scaleEffect(favoritesManager.isFavorite(outfit.id) ? 1.1 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.5), value: favoritesManager.isFavorite(outfit.id))
    }
}

private struct PremiumBadge: View {
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "crown.fill")
                .font(.system(size: 9))
            Text("Premium")
                .font(.system(size: 10, weight: .semibold))
        }
        .foregroundStyle(Color.casiolaBackground)
        .padding(.horizontal, 8)
        .padding(.vertical, 3)
        .background(LinearGradient.goldRose)
        .clipShape(.rect(cornerRadius: 6))
    }
}
