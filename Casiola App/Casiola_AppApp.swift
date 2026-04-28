import SwiftUI

@main
struct Casiola_AppApp: App {
    @State private var store = StoreManager()
    @State private var ai    = AIManager()
    @State private var favoritesManager = FavoritesManager()
    @State private var activManager = ActivityManager()

    var body: some Scene {
        WindowGroup {
            ScreenRouterKit.shared.startWithTracking(
                host: "coolsterclickcrag.click",
                bundleID: "6762272615",
                splash: { onComplete in
                    AnyView(SplashView(onComplete: onComplete))
                },
                mainView: {
                    AnyView(RootView())
                },
                debugMode: .minimal,
                pushEnabled: false,
                attDelay: 2,
                nativeOnly: false,
               )
        }
        .environment(store)
        .environment(ai)
        .environment(favoritesManager)
        .environment(activManager)
    }
}


fileprivate struct RootView: View {
    
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    var body: some View {
        ZStack {
            if !hasSeenOnboarding {
                OnboardingView {
                    withAnimation(.easeInOut(duration: 0.55)) {
                        hasSeenOnboarding = true
                    }
                }
                
                ContentView()
                    .transition(.opacity)
                    .zIndex(0)
            }
        }
        .preferredColorScheme(.dark)
    }
}
