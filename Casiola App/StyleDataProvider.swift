import Foundation

struct StyleDataProvider {
    static let mockItems: [StyleItem] = {
        let categories = StyleCategory.allCases
        let descriptions = [
            "Perfect for a rainy autumn day in the city.",
            "Elegant choice for a business meeting or formal dinner.",
            "Bold and edgy look for the urban jungle.",
            "Quiet luxury: high-quality materials and neutral tones.",
            "Clean lines and functional pieces for daily use.",
            "A timeless classic that never goes out of style.",
            "Experimental silhouette with unexpected color combinations."
        ]
        let tagsPool = ["#vintage", "#modern", "#oversize", "#chic", "#sustainable", "#bold", "#classic", "#linen", "#silk"]
        
        return (1...100).map { index in
            StyleItem(
                id: UUID(),
                title: "Outfit Look #\(index)",
                category: categories.randomElement()!,
                description: descriptions.randomElement()!,
                imageName: "look_\(index)",
                tags: Array((0..<3).map { _ in tagsPool.randomElement()! }),
                rating: Double.random(in: 3.5...5.0),
                createdAt: Date().addingTimeInterval(TimeInterval.random(in: -1000000...0))
            )
        }
    }()
}
