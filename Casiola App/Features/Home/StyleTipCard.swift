import SwiftUI

struct StyleTipCard: View {
    let tips: [StyleTip]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionHeader(title: "Style Tips", icon: "lightbulb.fill")
                .padding(.horizontal, 20)

            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(tips) { tip in
                        TipCard(tip: tip)
                    }
                }
                .padding(.horizontal, 20)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.top, 28)
    }
}

private struct TipCard: View {
    let tip: StyleTip

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.casiolaGold.opacity(0.15))
                    .frame(width: 40, height: 40)
                Image(systemName: tip.icon)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(Color.casiolaGold)
            }

            Text(tip.title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color.casiolaTextPrimary)

            Text(tip.body)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(Color.casiolaTextSecondary)
                .lineLimit(4)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(16)
        .frame(width: 200)
        .background(Color.casiolaSurface)
        .clipShape(.rect(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.casiolaStroke, lineWidth: 0.5)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(tip.title): \(tip.body)")
    }
}
