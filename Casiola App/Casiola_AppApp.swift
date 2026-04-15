import SwiftUI

@main
struct Casiola_AppApp: App {
    @State private var store = StoreManager()
    @State private var ai    = AIManager()
    @State private var appState: AppState = .splash
    @State private var favoritesManager = FavoritesManager()
    @State private var activManager = ActivityManager()
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    var body: some Scene {
        WindowGroup {
            ZStack {
                switch appState {
                case .splash:
                    SplashView {
                        withAnimation(.easeInOut(duration: 0.55)) {
                            appState = hasSeenOnboarding ? .main : .onboarding
                        }
                    }
                    .transition(.opacity)
                    .zIndex(2)

                case .onboarding:
                    OnboardingView {
                        withAnimation(.easeInOut(duration: 0.55)) {
                            hasSeenOnboarding = true
                            appState = .main
                        }
                    }
                    .transition(.opacity)
                    .zIndex(1)

                case .main:
                    ContentView()
                        .environment(store)
                        .environment(ai)
                        .environment(favoritesManager)
                        .environment(activManager)
                        .transition(.opacity)
                        .zIndex(0)
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}
