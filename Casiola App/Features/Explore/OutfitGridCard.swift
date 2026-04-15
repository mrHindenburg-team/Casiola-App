import SwiftUI


#Preview {
    OutfitGridCard(outfit: .bohoDream)
}

struct OutfitGridCard: View {
    let outfit: Outfit

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            outfit.gradient
                .clipShape(.rect(cornerRadius: 16))
                .frame(height: 180)

            LinearGradient(
                stops: [
                    .init(color: .clear, location: 0.4),
                    .init(color: Color.casiolaBackground.opacity(1), location: 1.0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .clipShape(.rect(cornerRadius: 16))

            VStack(alignment: .leading, spacing: 3) {
                if outfit.isPremium {
                    Image(systemName: "crown.fill")
                        .font(.system(size: 10))
                        .foregroundStyle(Color.casiolaGold)
                }

                Text(outfit.name)
                    .font(.system(size: 14, weight: .medium, design: .serif))
                    .foregroundStyle(Color.casiolaTextPrimary)
                    .lineLimit(2)

                VStack(alignment: .leading) {
                    HStack(spacing: 4) {
                        Image(systemName: outfit.category.icon)
                        Text(outfit.category.rawValue)
                    }
                    Text(outfit.seasons.map(\.rawValue.capitalized).joined(separator: ", "))
                }
                .font(.system(size: 10, weight: .regular))
                .foregroundStyle(Color.casiolaGold)
            }
            .padding(12)
        }
        .accessibilityLabel("\(outfit.name), \(outfit.category.rawValue)\(outfit.isPremium ? ", Premium" : "")")
    }
}
