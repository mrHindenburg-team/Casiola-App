import SwiftUI

struct ColorPaletteSection: View {
    let palettes: [ColorPalette]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionHeader(title: "Colour Stories", icon: "paintpalette.fill")
                .padding(.horizontal, 20)

            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(palettes) { palette in
                        ColorPaletteCard(palette: palette)
                    }
                }
                .padding(.horizontal, 20)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.top, 28)
    }
}

struct ColorPaletteCard: View {
    @Environment(ActivityManager.self) var activityManager
    let palette: ColorPalette

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Colour swatches
            HStack(spacing: 4) {
                ForEach(Array(palette.colors.enumerated()), id: \.offset) { _, color in
                    RoundedRectangle(cornerRadius: 6)
                        .fill(color)
                        .frame(width: 34, height: 34)
                }
            }

            Text(palette.name)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(Color.casiolaTextPrimary)

            Text(palette.mood)
                .font(.system(size: 11, weight: .regular))
                .foregroundStyle(Color.casiolaTextSecondary)
        }
        .padding(14)
        .background(Color.casiolaSurface)
        .clipShape(.rect(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.casiolaStroke, lineWidth: 0.5)
        }
        .frame(width: 180)
        .accessibilityLabel("\(palette.name) palette, \(palette.mood)")
        .onAppear {
            activityManager.trackPaletteViewed(palette.id)
        }
    }
}
