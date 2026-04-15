import SwiftUI

// MARK: - Supporting Types

enum Season: String, CaseIterable, Hashable {
    case spring, summer, autumn, winter

    var name: String { rawValue.capitalized }

    var icon: String {
        switch self {
        case .spring: "🌸"
        case .summer: "☀️"
        case .autumn: "🍂"
        case .winter: "❄️"
        }
    }
}

struct Occasion: Hashable {
    let label: String
    let icon: String
    
    static let casual  = Occasion(label: "Casual",     icon: "figure.walk")
    static let office  = Occasion(label: "Office",     icon: "briefcase")
    static let dinner  = Occasion(label: "Dinner",     icon: "fork.knife")
    static let party   = Occasion(label: "Party",      icon: "music.note")
    static let travel  = Occasion(label: "Travel",     icon: "airplane")
    static let brunch  = Occasion(label: "Brunch",     icon: "cup.and.saucer")
    static let date    = Occasion(label: "Date Night", icon: "heart")
    static let outdoor = Occasion(label: "Outdoor",    icon: "leaf")
    static let gym     = Occasion(label: "Gym",        icon: "dumbbell")
    static let wedding = Occasion(label: "Wedding",    icon: "sparkles")
}

// MARK: - Outfit

struct Outfit: Identifiable {
    var id: String { name }
    let name: String
    let category: StyleCategory
    let description: String
    let primaryColor: Color
    let secondaryColor: Color
    let tags: [String]
    let isPremium: Bool

    var seasons: [Season] = Season.allCases
    var occasions: [Occasion] = [.casual]
    var stylingTips: [String] = []
    var similarLooks: [Outfit] = []

    var gradient: LinearGradient {
        LinearGradient(
            colors: [primaryColor, secondaryColor],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

// MARK: - Sample Data

extension Outfit {
    static let all: [Outfit] = [
        goldenHour,
        midnightFormal,
        urbanStreet,
        whiteMinimal,
        bohoDream,
        eveningRose,
        activeFlow,
    ]

    static let goldenHour = Outfit(
        name: "Golden Hour",
        category: .casual,
        description: "A warm, sun-kissed ensemble that transitions effortlessly from afternoon brunches to evening soirées. Rich amber tones paired with soft blush create a luminous, approachable ease.",
        primaryColor: Color(red: 0.93, green: 0.72, blue: 0.33),
        secondaryColor: Color(red: 0.96, green: 0.84, blue: 0.72),
        tags: ["golden", "warm", "breezy", "brunch", "weekend"],
        isPremium: false,
        seasons: [.spring, .summer],
        occasions: [.brunch, .casual, .outdoor],
        stylingTips: [
            "Anchor with nude or tan sandals — they elongate the leg without competing with the warm palette.",
            "Keep jewellery to a single gold chain or small hoops; anything heavier steals the spotlight.",
            "A woven straw tote or rattan bag keeps the relaxed, sun-drenched feel intact.",
        ]
    )

    static let midnightFormal = Outfit(
        name: "Midnight Formal",
        category: .formal,
        description: "Deep navy and slate blue come together in a silhouette built for boardrooms and black-tie events alike. Structured, confident, and effortlessly sharp.",
        primaryColor: Color(red: 0.10, green: 0.13, blue: 0.28),
        secondaryColor: Color(red: 0.25, green: 0.30, blue: 0.52),
        tags: ["navy", "formal", "structured", "power", "classic"],
        isPremium: true,
        seasons: [.autumn, .winter],
        occasions: [.office, .dinner, .wedding],
        stylingTips: [
            "Oxford shoes in dark burgundy add personality while staying within a formal dress code.",
            "A slim pocket square in ivory or pale gold breaks the monochrome without effort.",
            "Avoid black accessories — they flatten the look. Stay in the navy-to-brown range.",
        ]
    )

    static let urbanStreet = Outfit(
        name: "Urban Street",
        category: .street,
        description: "Graphic energy meets utilitarian layering. This look is built for city movement — bold enough to stand out, practical enough to keep up.",
        primaryColor: Color(red: 0.18, green: 0.18, blue: 0.18),
        secondaryColor: Color(red: 0.42, green: 0.38, blue: 0.90),
        tags: ["street", "urban", "graphic", "layer", "bold"],
        isPremium: true,
        seasons: [.spring, .autumn],
        occasions: [.casual, .outdoor, .travel],
        stylingTips: [
            "Chunky sneakers in white or grey keep the proportions balanced with oversized layers.",
            "A crossbody bag frees up your hands and adds a functional, utilitarian edge.",
            "Roll the cuffs on any oversized piece — it immediately sharpens the silhouette.",
        ]
    )

    static let whiteMinimal = Outfit(
        name: "White Minimal",
        category: .minimal,
        description: "Silence as a statement. A study in restraint — clean whites, soft off-whites, and the kind of effortless composure that only comes from editing down to the essentials.",
        primaryColor: Color(red: 0.97, green: 0.97, blue: 0.95),
        secondaryColor: Color(red: 0.88, green: 0.87, blue: 0.84),
        tags: ["white", "minimal", "clean", "quiet", "timeless"],
        isPremium: true,
        seasons: Season.allCases,
        occasions: [.office, .casual, .dinner],
        stylingTips: [
            "Texture is everything — mix linen, cotton, and fine knit to keep monochrome from feeling flat.",
            "One sculptural piece (a structured bag or architectural shoe) is all the contrast you need.",
            "Iron or steam everything. Minimal looks live and die by how crisp the fabric sits.",
        ]
    )

    static let bohoDream = Outfit(
        name: "Boho Dream",
        category: .boho,
        description: "Free-spirited layers of terracotta, sage, and warm sand. A nod to open landscapes and slow mornings — effortless, earthy, and entirely your own.",
        primaryColor: Color(red: 0.78, green: 0.45, blue: 0.28),
        secondaryColor: Color(red: 0.68, green: 0.72, blue: 0.55),
        tags: ["boho", "earthy", "terracotta", "sage", "free"],
        isPremium: true,
        seasons: [.spring, .summer, .autumn],
        occasions: [.outdoor, .casual, .brunch, .travel],
        stylingTips: [
            "Layer necklaces of different lengths — mixed metals and natural stones both work here.",
            "Flat leather sandals or ankle boots ground the look depending on the season.",
            "A floppy wide-brim hat pulls double duty: it's practical and the perfect finishing touch.",
        ]
    )

    static let eveningRose = Outfit(
        name: "Evening Rose",
        category: .evening,
        description: "Dusty rose and deep mauve create a quietly romantic evening palette. Polished without being loud — the kind of look you remember long after the night ends.",
        primaryColor: Color(red: 0.85, green: 0.60, blue: 0.65),
        secondaryColor: Color(red: 0.52, green: 0.32, blue: 0.42),
        tags: ["rose", "evening", "romantic", "mauve", "glow"],
        isPremium: true,
        seasons: [.spring, .summer],
        occasions: [.dinner, .date, .party, .wedding],
        stylingTips: [
            "Strappy heeled sandals in nude or champagne let the colour palette take centre stage.",
            "A delicate pearl or rose quartz pendant is the only jewellery this look needs.",
            "Go for a satin or silk finish fabric — it catches the evening light beautifully.",
        ]
    )

    static let activeFlow = Outfit(
        name: "Active Flow",
        category: .sport,
        description: "Performance meets intention. Teal and deep slate move together with purpose — made for high-output sessions and the confident ease that follows them.",
        primaryColor: Color(red: 0.15, green: 0.65, blue: 0.62),
        secondaryColor: Color(red: 0.12, green: 0.22, blue: 0.35),
        tags: ["sport", "teal", "active", "performance", "flow"],
        isPremium: true,
        seasons: Season.allCases,
        occasions: [.gym, .outdoor, .casual],
        stylingTips: [
            "Choose a mid-sole shoe with slight cushioning — it transitions from the gym to errands without effort.",
            "A zip-up half-layer in the same tonal family keeps the look cohesive if you run cold.",
            "Stick to one bold colour at a time; let the darker slate act as the neutral anchor.",
        ]
    )
}
