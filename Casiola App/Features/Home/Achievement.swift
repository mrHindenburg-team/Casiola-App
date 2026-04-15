import SwiftUI

// MARK: - Achievement model

struct Achievement: Identifiable {
    let id: String
    let icon: String
    let title: String
    let description: String
    let color: Color
    let isUnlocked: Bool
}

// MARK: - Factory — derives achievements from real managers

extension Achievement {
    static func all(
        favorites: Set<String>,
        activity: ActivityManager
    ) -> [Achievement] {
        let allOutfits    = FashionDataStore.outfits
        let allPaletteIDs = Set(FashionDataStore.colorPalettes.map(\.id))
        let premiumSaved  = allOutfits.filter { favorites.contains($0.id) && $0.isPremium }.count

        return [
            Achievement(
                id: "first_outfit",
                icon: "sparkles",
                title: "First Look",
                description: "Save your first outfit",
                color: .casiolaGold,
                isUnlocked: !favorites.isEmpty
            ),
            Achievement(
                id: "trend_setter",
                icon: "flame.fill",
                title: "Trendsetter",
                description: "Save 10 outfits in a week",
                color: Color(red: 1, green: 0.45, blue: 0.3),
                isUnlocked: activity.savedThisWeek >= 10
            ),
            Achievement(
                id: "palette_master",
                icon: "paintpalette.fill",
                title: "Palette Master",
                description: "Explore all colour palettes",
                color: Color(red: 0.45, green: 0.78, blue: 0.58),
                isUnlocked: allPaletteIDs.isSubset(of: activity.totalUniquePalettes)
            ),
            Achievement(
                id: "ai_whisperer",
                icon: "brain",
                title: "AI Whisperer",
                description: "Send 50 AI messages",
                color: Color(red: 0.6, green: 0.5, blue: 1.0),
                isUnlocked: activity.totalAIChats >= 50
            ),
            Achievement(
                id: "premium_taste",
                icon: "crown.fill",
                title: "Premium Taste",
                description: "Save 5 premium outfits",
                color: Color(red: 1, green: 0.78, blue: 0.28),
                isUnlocked: premiumSaved >= 5
            ),
            Achievement(
                id: "night_owl",
                icon: "moon.stars.fill",
                title: "Night Owl",
                description: "Open the app after midnight",
                color: Color(red: 0.4, green: 0.6, blue: 1.0),
                isUnlocked: activity.hadNightSession
            ),
        ]
    }
}

// MARK: - Card view

struct AchievementsCard: View {
    @Environment(FavoritesManager.self) private var favoritesManager
    @Environment(ActivityManager.self)  private var activityManager

    private var achievements: [Achievement] {
        Achievement.all(
            favorites: favoritesManager.favorites,
            activity:  activityManager
        )
    }

    private var unlockedCount: Int { achievements.filter(\.isUnlocked).count }
    private var progress: CGFloat  { CGFloat(unlockedCount) / CGFloat(achievements.count) }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            // Header
            HStack(alignment: .firstTextBaseline) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Achievements")
                        .font(.system(size: 20, weight: .semibold, design: .serif))
                        .foregroundStyle(Color.casiolaTextPrimary)

                    Text("\(unlockedCount) of \(achievements.count) unlocked")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color.casiolaTextSecondary)
                }

                Spacer()

                // Progress ring
                ZStack {
                    Circle()
                        .stroke(Color.casiolaStroke, lineWidth: 3)

                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(Color.casiolaGold,
                                style: StrokeStyle(lineWidth: 3, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: progress)

                    Text("\(Int(progress * 100))%")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(Color.casiolaGold)
                }
                .frame(width: 44, height: 44)
            }

            // Progress bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(Color.casiolaStroke).frame(height: 4)
                    Capsule()
                        .fill(LinearGradient.goldRose)
                        .frame(width: geo.size.width * progress, height: 4)
                        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: progress)
                }
            }
            .frame(height: 4)

            // Badges grid
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3),
                spacing: 12
            ) {
                ForEach(achievements) { achievement in
                    AchievementBadge(achievement: achievement)
                }
            }
        }
        .padding(20)
        .background(Color.casiolaSurface)
        .clipShape(.rect(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.casiolaStroke, lineWidth: 0.5)
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }
}

// MARK: - Badge

private struct AchievementBadge: View {
    let achievement: Achievement

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(
                        achievement.isUnlocked
                            ? achievement.color.opacity(0.15)
                            : Color.casiolaStroke.opacity(0.4)
                    )
                    .frame(width: 52, height: 52)

                if achievement.isUnlocked {
                    Circle()
                        .strokeBorder(achievement.color.opacity(0.35), lineWidth: 1.5)
                        .frame(width: 52, height: 52)
                }

                Image(systemName: achievement.icon)
                    .font(.system(size: 22, weight: .medium))
                    .foregroundStyle(
                        achievement.isUnlocked
                            ? achievement.color
                            : Color.casiolaTextSecondary.opacity(0.35)
                    )
                    .symbolEffect(.bounce, value: achievement.isUnlocked)

                if !achievement.isUnlocked {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundStyle(Color.casiolaTextSecondary.opacity(0.45))
                        .offset(x: 16, y: 16)
                }
            }

            Text(achievement.title)
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(
                    achievement.isUnlocked
                        ? Color.casiolaTextPrimary
                        : Color.casiolaTextSecondary.opacity(0.45)
                )
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
    }
}
