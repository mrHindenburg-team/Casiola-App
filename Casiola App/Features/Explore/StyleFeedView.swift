import SwiftUI

struct StyleFeedView: View {
    @State private var selectedCategory: StyleCategory = .all
    @State private var selectedOutfit: Outfit?
    @State private var searchText = ""

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]

    private var displayedOutfits: [Outfit] {
        let base = selectedCategory == .all
            ? FashionDataStore.outfits
            : FashionDataStore.outfits.filter { $0.category == selectedCategory }
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return base }
        return base.filter {
            $0.name.localizedStandardContains(query)
            || $0.category.rawValue.localizedStandardContains(query)
            || $0.tags.contains { $0.localizedStandardContains(query) }
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            exploreHeader
            searchBar
            categoryFilter
            outfitGrid
        }
        .background(Color.casiolaBackground)
        .sheet(item: $selectedOutfit, content: OutfitDetailView.init)
    }

    // MARK: - Subviews

    private var exploreHeader: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Explore")
                    .font(.system(size: 28, weight: .light, design: .serif))
                    .foregroundStyle(Color.casiolaTextPrimary)
                Text("\(displayedOutfits.count) of \(FashionDataStore.outfits.count) styles")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(Color.casiolaTextSecondary)
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }

    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 14))
                .foregroundStyle(Color.casiolaTextSecondary)

            TextField("Search styles, tags…", text: $searchText)
                .font(.system(size: 14))
                .foregroundStyle(Color.casiolaTextPrimary)
                .tint(Color.casiolaGold)

            if !searchText.isEmpty {
                Button("Clear") { searchText = "" }
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color.casiolaTextSecondary)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(Color.casiolaCard)
        .clipShape(.rect(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.casiolaStroke, lineWidth: 0.5)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 12)
    }

    private var categoryFilter: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                ForEach(StyleCategory.allCases) { category in
                    CategoryFilterChip(
                        category: category,
                        isSelected: selectedCategory == category
                    ) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedCategory = category
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .scrollIndicators(.hidden)
        .padding(.bottom, 12)
    }

    private var outfitGrid: some View {
        ScrollView {
            if displayedOutfits.isEmpty {
                emptyState
            } else {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(displayedOutfits) { outfit in
                        OutfitGridCard(outfit: outfit)
                            .onTapGesture { selectedOutfit = outfit }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            }
        }
        .scrollIndicators(.hidden)
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 40, weight: .light))
                .foregroundStyle(Color.casiolaTextSecondary)
            Text("No styles found")
                .font(.system(size: 16, weight: .medium, design: .serif))
                .foregroundStyle(Color.casiolaTextPrimary)
            Text("Try a different category or search term.")
                .font(.system(size: 13))
                .foregroundStyle(Color.casiolaTextSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 80)
    }
}

private struct CategoryFilterChip: View {
    let category: StyleCategory
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 5) {
                Image(systemName: category.icon)
                    .font(.system(size: 11, weight: .medium))
                Text(category.rawValue)
                    .font(.system(size: 13, weight: .medium))
            }
            .foregroundStyle(isSelected ? Color.casiolaBackground : Color.casiolaTextPrimary)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(
                isSelected
                ? LinearGradient.goldRose
                : LinearGradient(colors: [Color.casiolaCard], startPoint: .leading, endPoint: .trailing)
            )
            .clipShape(.rect(cornerRadius: 20))
            .overlay {
                if !isSelected {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.casiolaStroke, lineWidth: 0.5)
                }
            }
        }
    }
}

#Preview {
    StyleFeedView()
}
