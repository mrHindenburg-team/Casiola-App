import SwiftUI

struct TrendingSection: View {
    let outfits: [Outfit]
    @State private var selectedOutfit: Outfit?

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionHeader(title: "Trending Now", icon: "flame.fill")
                .padding(.horizontal, 20)

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(outfits) { outfit in
                    TrendingOutfitCard(outfit: outfit)
                        .onTapGesture {
                            selectedOutfit = outfit
                        }
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.top, 28)
        .sheet(item: $selectedOutfit, content: OutfitDetailView.init)
    }
}

