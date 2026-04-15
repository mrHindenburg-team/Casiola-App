import SwiftUI

struct OutfitDetailView: View {
    let outfit: Outfit
    @Environment(FavoritesManager.self) private var favoritesManager
    @Environment(\.changeTab) private var changeTab
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView {
                VStack(spacing: 0) {
                    heroHeader
                    detailContent
                }
            }
            .scrollIndicators(.hidden)
            .background(Color.casiolaBackground)

            // Action buttons overlay
            HStack {
                Button("Close") { dismiss() }
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color.casiolaTextPrimary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(Color.casiolaBackground.opacity(0.75))
                    .clipShape(.rect(cornerRadius: 20))

                Spacer()

                HStack(spacing: 12) {
                    favoriteButton
                    shareButton
                }
            }
            .padding(.top, 56)
            .padding(.horizontal, 16)
        }
    }

    // MARK: - Subviews

    private var favoriteButton: some View {
        Button {
            favoritesManager.toggle(outfit.id)
        } label: {
            Image(systemName: favoritesManager.isFavorite(outfit.id) ? "heart.fill" : "heart")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(favoritesManager.isFavorite(outfit.id) ? Color.casiolaGold : Color.casiolaTextPrimary)
                .padding(10)
                .background(Color.casiolaBackground.opacity(0.75))
                .clipShape(.rect(cornerRadius: 20))
        }
    }

    private var shareButton: some View {
        Button {
            let shareText = "Check out this \(outfit.name) look on Casiola! #\(outfit.tags.first ?? "fashion")"
            let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)

            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootVC = windowScene.windows.first?.rootViewController {
                rootVC.present(activityVC, animated: true)
            }
        } label: {
            Image(systemName: "square.and.arrow.up")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.casiolaTextPrimary)
                .padding(10)
                .background(Color.casiolaBackground.opacity(0.75))
                .clipShape(.rect(cornerRadius: 20))
        }
    }

    private var heroHeader: some View {
        ZStack(alignment: .bottomLeading) {
            outfit.gradient
                .frame(height: 320)

            LinearGradient(
                colors: [Color.clear, Color.casiolaBackground.opacity(0.85)],
                startPoint: .center,
                endPoint: .bottom
            )
            .frame(height: 320)

            VStack(alignment: .leading, spacing: 6) {
                if outfit.isPremium {
                    HStack(spacing: 4) {
                        Image(systemName: "crown.fill")
                            .font(.system(size: 10))
                        Text("Premium")
                            .font(.system(size: 11, weight: .semibold))
                    }
                    .foregroundStyle(Color.casiolaBackground)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(LinearGradient.goldRose)
                    .clipShape(.rect(cornerRadius: 8))
                }

                Text(outfit.name)
                    .font(.system(size: 32, weight: .light, design: .serif))
                    .foregroundStyle(Color.casiolaTextPrimary)

                Text(outfit.category.rawValue.uppercased())
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(Color.casiolaGold)
                    .tracking(2)
            }
            .padding(20)
        }
    }

    private var detailContent: some View {
        VStack(alignment: .leading, spacing: 28) {

            // Description
            Text(outfit.description)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(Color.casiolaTextPrimary)
                .lineSpacing(4)

            divider

            // Colour swatches
            VStack(alignment: .leading, spacing: 10) {
                sectionLabel("Colour Palette")

                HStack(spacing: 10) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(outfit.primaryColor)
                        .frame(width: 56, height: 56)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(outfit.secondaryColor)
                        .frame(width: 56, height: 56)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(outfit.gradient)
                        .frame(width: 56, height: 56)
                        .overlay {
                            Text("Mix")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundStyle(Color.casiolaBackground.opacity(0.8))
                        }
                }
            }

            divider

            // Season
            VStack(alignment: .leading, spacing: 10) {
                sectionLabel("Season")

                HStack(spacing: 12) {
                    ForEach(outfit.seasons, id: \.self) { season in
                        VStack(spacing: 4) {
                            Text(season.icon)
                                .font(.system(size: 22))
                            Text(season.name)
                                .font(.system(size: 11, weight: .medium))
                                .foregroundStyle(
                                    outfit.seasons.contains(season)
                                        ? Color.casiolaGold
                                        : Color.casiolaTextSecondary
                                )
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(
                            outfit.seasons.contains(season)
                                ? Color.casiolaGold.opacity(0.1)
                                : Color.casiolaTextSecondary.opacity(0.06)
                        )
                        .clipShape(.rect(cornerRadius: 12))
                    }
                }
            }

            divider

            // Occasions
            VStack(alignment: .leading, spacing: 10) {
                sectionLabel("Perfect For")

                FlowLayout(spacing: 8) {
                    ForEach(outfit.occasions, id: \.self) { occasion in
                        HStack(spacing: 5) {
                            Image(systemName: occasion.icon)
                                .font(.system(size: 11))
                            Text(occasion.label)
                                .font(.system(size: 13, weight: .medium))
                        }
                        .foregroundStyle(Color.casiolaTextPrimary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(Color.casiolaTextSecondary.opacity(0.08))
                        .clipShape(.rect(cornerRadius: 20))
                    }
                }
            }

            divider

            // Styling Tips
            VStack(alignment: .leading, spacing: 12) {
                sectionLabel("Styling Tips")

                VStack(alignment: .leading, spacing: 10) {
                    ForEach(Array(outfit.stylingTips.enumerated()), id: \.offset) { index, tip in
                        HStack(alignment: .top, spacing: 12) {
                            Text("\(index + 1)")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(Color.casiolaGold)
                                .frame(width: 22, height: 22)
                                .background(Color.casiolaGold.opacity(0.12))
                                .clipShape(Circle())

                            Text(tip)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(Color.casiolaTextPrimary)
                                .lineSpacing(3)
                                .fixedSize(horizontal: false, vertical: true)

                            Spacer()
                        }
                        .padding(12)
                        .background(Color.casiolaTextSecondary.opacity(0.05))
                        .clipShape(.rect(cornerRadius: 12))
                    }
                }
            }

            divider

            // Tags
            VStack(alignment: .leading, spacing: 10) {
                sectionLabel("Tags")

                FlowLayout(spacing: 8) {
                    ForEach(outfit.tags, id: \.self) { tag in
                        Text("#\(tag)")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(Color.casiolaGold)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.casiolaGold.opacity(0.1))
                            .clipShape(.rect(cornerRadius: 20))
                    }
                }
            }

            divider

            // Similar Looks
            VStack(alignment: .leading, spacing: 12) {
                sectionLabel("Similar Looks")

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(outfit.similarLooks) { look in
                            VStack(alignment: .leading, spacing: 6) {
                                look.gradient
                                    .frame(width: 130, height: 160)
                                    .clipShape(.rect(cornerRadius: 14))

                                Text(look.name)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundStyle(Color.casiolaTextPrimary)
                                    .lineLimit(1)

                                Text(look.category.rawValue)
                                    .font(.system(size: 11))
                                    .foregroundStyle(Color.casiolaTextSecondary)
                            }
                            .frame(width: 130)
                        }
                    }
                    .padding(.horizontal, 1)
                }
            }

            // CTA
            Button {
                dismiss()
                changeTab(.chat)
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 15, weight: .semibold))
                    Text("Ask Casiola about this look")
                        .font(.system(size: 15, weight: .semibold))
                }
                .foregroundStyle(Color.casiolaBackground)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(LinearGradient.goldRose)
                .clipShape(.rect(cornerRadius: 14))
            }
            .padding(.top, 4)
        }
        .padding(20)
    }

    // MARK: - Helpers

    private var divider: some View {
        Rectangle()
            .fill(Color.casiolaTextSecondary.opacity(0.12))
            .frame(height: 0.5)
    }

    private func sectionLabel(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 12, weight: .semibold))
            .foregroundStyle(Color.casiolaTextSecondary)
            .tracking(1.5)
            .textCase(.uppercase)
    }
}

// MARK: - FlowLayout

/// Simple left-to-right wrapping layout for tags / chips.
struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.width ?? 0
        var height: CGFloat = 0
        var rowWidth: CGFloat = 0
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if rowWidth + size.width > width, rowWidth > 0 {
                height += rowHeight + spacing
                rowWidth = 0
                rowHeight = 0
            }
            rowWidth += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
        height += rowHeight
        return CGSize(width: width, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX
        var y = bounds.minY
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > bounds.maxX, x > bounds.minX {
                y += rowHeight + spacing
                x = bounds.minX
                rowHeight = 0
            }
            subview.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(size))
            x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
    }
}
