import SwiftUI

import SwiftUI

struct HomeView: View {
    @State private var selectedCategory: StyleCategory = .all

    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: .now)
        return switch hour {
        case 0 ..< 12: "Good morning"
        case 12 ..< 17: "Good afternoon"
        default:         "Good evening"
        }
    }

    private var filteredOutfits: [Outfit] {
        selectedCategory == .all ? FashionDataStore.outfits.filter {!$0.isPremium}
            : FashionDataStore.outfits.filter { $0.category == selectedCategory && !$0.isPremium}
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0, pinnedViews: []) {
                HomeHeaderView(greeting: greeting)

                AIChatPreviewCard()
                    .padding(.bottom)

                AchievementsCard()

                StyleStatsCard()
                    .padding(.bottom, 8)

                StyleCategoryRow(selectedCategory: $selectedCategory)
                TrendingSection(outfits: filteredOutfits)
                ColorPaletteSection(palettes: FashionDataStore.colorPalettes)
                StyleTipCard(tips: FashionDataStore.styleTips)
                PremiumBanner()
            }
        }
        .background(Color.casiolaBackground)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    HomeView()
        .environment(StoreManager())
        .environment(AIManager())
        .environment(FavoritesManager())
        .environment(ActivityManager())
}
