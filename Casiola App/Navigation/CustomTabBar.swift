import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: AppTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(AppTab.allCases) { tab in
                TabBarItem(tab: tab, isSelected: selectedTab == tab)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.72)) {
                            selectedTab = tab
                        }
                    }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        // Liquid Glass pill shape
        .background {
            Capsule()
                .fill(.ultraThinMaterial)
                .overlay {
                    Capsule()
                        .strokeBorder(
                            LinearGradient(
                                colors: [
                                    .white.opacity(0.45),
                                    .white.opacity(0.10)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 0.8
                        )
                }
                .shadow(color: .black.opacity(0.18), radius: 20, x: 0, y: 8)
                .shadow(color: .black.opacity(0.08), radius: 4,  x: 0, y: 2)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 16)
    }
}
