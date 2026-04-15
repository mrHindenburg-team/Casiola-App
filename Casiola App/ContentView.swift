import SwiftUI

struct ContentView: View {
    @State private var selectedTab: AppTab = .home

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home:    HomeView()
                case .explore: StyleFeedView()
                case .chat:    AIChatView()
                case .premium: PremiumView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // Reserve space at the bottom so content never hides behind the bar
            .safeAreaInset(edge: .bottom) { Color.clear.frame(height: 72) }

            CustomTabBar(selectedTab: $selectedTab)
        }
        .background(Color.casiolaBackground)
        .ignoresSafeArea(edges: .bottom)
        .environment(\.changeTab) { tab in
            withAnimation(.spring(response: 0.35, dampingFraction: 0.72)) {
                selectedTab = tab
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(StoreManager())
        .environment(AIManager())
}
