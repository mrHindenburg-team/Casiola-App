import SwiftUI

struct StyleCategoryRow: View {
    @Binding var selectedCategory: StyleCategory

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Categories")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(Color.casiolaTextSecondary)
                .tracking(1.5)
                .textCase(.uppercase)
                .padding(.horizontal, 20)

            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(StyleCategory.allCases) { category in
                        CategoryChip(
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
        }
        .padding(.top, 24)
    }
}

private struct CategoryChip: View {
    let category: StyleCategory
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 6) {
                Image(systemName: category.icon)
                    .font(.system(size: 12, weight: .medium))
                Text(category.rawValue)
                    .font(.system(size: 13, weight: .medium))
            }
            .foregroundStyle(isSelected ? Color.casiolaBackground : Color.casiolaTextPrimary)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(isSelected ? LinearGradient.goldRose : LinearGradient(colors: [Color.casiolaCard], startPoint: .leading, endPoint: .trailing))
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
