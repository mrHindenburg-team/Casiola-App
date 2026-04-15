import SwiftUI

struct TabBarItem: View {
    let tab: AppTab
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 3) {
            Image(systemName: tab.icon)
                .font(.system(size: 20, weight: isSelected ? .semibold : .regular))
                .foregroundStyle(isSelected ? Color.casiolaGold : Color.casiolaTextSecondary)
                .scaleEffect(isSelected ? 1.08 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.68), value: isSelected)

            Text(tab.rawValue)
                .font(.system(size: 10, weight: isSelected ? .semibold : .medium))
                .foregroundStyle(isSelected ? Color.casiolaGold : Color.casiolaTextSecondary)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 9)
        .background {
            if isSelected {
                // Inner glass capsule for the selected item
                Capsule()
                    .fill(Color.casiolaGold.opacity(0.13))
                    .overlay {
                        Capsule()
                            .strokeBorder(
                                Color.casiolaGold.opacity(0.25),
                                lineWidth: 0.6
                            )
                    }
                    .transition(
                        .asymmetric(
                            insertion: .scale(scale: 0.82).combined(with: .opacity),
                            removal:   .scale(scale: 0.82).combined(with: .opacity)
                        )
                    )
            }
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.72), value: isSelected)
        .contentShape(Rectangle())
        .accessibilityLabel(tab.rawValue)
        .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : .isButton)
    }
}
