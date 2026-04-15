import Foundation

struct StyleItem: Identifiable, Hashable {
    let id: UUID
    let title: String
    let category: StyleCategory
    let description: String
    let imageName: String
    let tags: [String]
    let rating: Double
    let createdAt: Date
}
