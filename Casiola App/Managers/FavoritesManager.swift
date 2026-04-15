import SwiftUI
import Foundation

@Observable
@MainActor
final class FavoritesManager {
    private(set) var favorites: Set<String> = []

    private let saveKey = "com.Tymur.Casiola-App.favorites"

    init() {
        load()
    }

    func toggle(_ id: String) {
        if favorites.contains(id) {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
        save()
    }

    func isFavorite(_ id: String) -> Bool {
        favorites.contains(id)
    }

    private func save() {
        UserDefaults.standard.set(Array(favorites), forKey: saveKey)
    }

    private func load() {
        if let ids = UserDefaults.standard.stringArray(forKey: saveKey) {
            favorites = Set(ids)
        }
    }
}
