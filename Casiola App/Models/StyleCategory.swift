import Foundation

enum StyleCategory: String, CaseIterable, Identifiable {
    case all     = "All"
    case casual  = "Casual"
    case formal  = "Formal"
    case street  = "Street"
    case minimal = "Minimal"
    case boho    = "Boho"
    case evening = "Evening"
    case sport   = "Sport"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .all:     "square.grid.2x2.fill"
        case .casual:  "sun.max.fill"
        case .formal:  "crown.fill"
        case .street:  "bolt.fill"
        case .minimal: "circle.fill"
        case .boho:    "leaf.fill"
        case .evening: "moon.stars.fill"
        case .sport:   "figure.run"
        }
    }
}
