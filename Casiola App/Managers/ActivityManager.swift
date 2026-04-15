import SwiftUI

@Observable
@MainActor
final class ActivityManager {

    // MARK: - Internal model

    struct DayActivity: Codable {
        var outfitsViewed: Int = 0
        var outfitsSaved:  Int = 0
        var aiChats:       Int = 0
        var palettesViewed: Set<String> = []
        var hadNightSession: Bool = false

        var hasAnyActivity: Bool {
            outfitsViewed > 0 || outfitsSaved > 0 || aiChats > 0
        }
    }

    // MARK: - Storage

    private var log: [String: DayActivity] = [:]
    private let saveKey = "com.Tymur.Casiola-App.activityLog"

    private static let dayFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        f.locale = Locale(identifier: "en_US_POSIX")
        return f
    }()

    init() { load() }

    // MARK: - Public tracking API
    // Call these from the corresponding views / buttons.

    func trackOutfitViewed() {
        mutateToday { $0.outfitsViewed += 1 }
    }

    /// Call alongside FavoritesManager.toggle() when adding (not removing) a favorite.
    func trackOutfitSaved() {
        mutateToday { $0.outfitsSaved += 1 }
        checkNightSession()
    }

    func trackAIChat() {
        mutateToday { $0.aiChats += 1 }
    }

    func trackPaletteViewed(_ id: String) {
        mutateToday { $0.palettesViewed.insert(id) }
    }

    // MARK: - Computed — used by cards

    /// Consecutive days (including today) with any activity.
    var streakDays: Int {
        var count = 0
        var date = Date.now
        let cal = Calendar.current
        while true {
            guard let activity = log[key(for: date)], activity.hasAnyActivity else { break }
            count += 1
            guard let prev = cal.date(byAdding: .day, value: -1, to: date) else { break }
            date = prev
        }
        return count
    }

    var savedThisWeek:  Int { last7.reduce(0) { $0 + ($1?.outfitsSaved  ?? 0) } }
    var viewedThisWeek: Int { last7.reduce(0) { $0 + ($1?.outfitsViewed ?? 0) } }
    var aiChatsThisWeek: Int { last7.reduce(0) { $0 + ($1?.aiChats      ?? 0) } }

    var totalAIChats: Int {
        log.values.reduce(0) { $0 + $1.aiChats }
    }

    var totalUniquePalettes: Set<String> {
        log.values.reduce(into: Set<String>()) { $0.formUnion($1.palettesViewed) }
    }

    var hadNightSession: Bool {
        log.values.contains { $0.hadNightSession }
    }

    /// Normalized (0–1) bar data for the last 7 days, oldest → newest.
    var weeklyBarData: [BarEntry] {
        let cal = Calendar.current
        let labels = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]

        let pairs: [(date: Date, activity: DayActivity?)] = (0..<7).map { offset in
            let d = cal.date(byAdding: .day, value: -(6 - offset), to: .now)!
            return (d, log[key(for: d)])
        }

        let maxViews = pairs.map { $0.activity?.outfitsViewed ?? 0 }.max() ?? 0
        let safeMax = max(maxViews, 1)

        return pairs.map { date, activity in
            let weekday = cal.component(.weekday, from: date) - 1 // 0 = Sun
            let raw = activity?.outfitsViewed ?? 0
            return BarEntry(
                label:   labels[weekday],
                value:   raw > 0 ? max(CGFloat(raw) / CGFloat(safeMax), 0.08) : 0,
                isToday: cal.isDateInToday(date)
            )
        }
    }

    struct BarEntry {
        let label:   String
        let value:   CGFloat // 0–1
        let isToday: Bool
    }

    // MARK: - Private helpers

    private var last7: [DayActivity?] {
        let cal = Calendar.current
        return (0..<7).map { offset in
            let d = cal.date(byAdding: .day, value: -offset, to: .now)!
            return log[key(for: d)]
        }
    }

    private func mutateToday(_ mutation: (inout DayActivity) -> Void) {
        let k = key(for: .now)
        var entry = log[k] ?? DayActivity()
        mutation(&entry)
        log[k] = entry
        save()
    }

    private func checkNightSession() {
        let hour = Calendar.current.component(.hour, from: .now)
        if (0..<5).contains(hour) {
            mutateToday { $0.hadNightSession = true }
        }
    }

    private func key(for date: Date) -> String {
        Self.dayFormatter.string(from: date)
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(log) else { return }
        UserDefaults.standard.set(data, forKey: saveKey)
    }

    private func load() {
        guard
            let data    = UserDefaults.standard.data(forKey: saveKey),
            let decoded = try? JSONDecoder().decode([String: DayActivity].self, from: data)
        else { return }
        log = decoded
    }
}
