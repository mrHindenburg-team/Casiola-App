import SwiftUI

enum FashionDataStore {

    // MARK: - Outfits

    static let outfits: [Outfit] = [
        Outfit(
            name: "Urban Minimal",
            category: .minimal,
            description: "Clean lines, neutral palette, effortless sophistication",
            primaryColor: Color(red: 0.86, green: 0.83, blue: 0.76),
            secondaryColor: Color(red: 0.52, green: 0.49, blue: 0.44),
            tags: ["minimalist", "neutral", "clean"],
            isPremium: false
        ),
        Outfit(
            name: "Golden Hour",
            category: .casual,
            description: "Warm sunset tones — relaxed yet polished all day long",
            primaryColor: Color(red: 0.94, green: 0.73, blue: 0.35),
            secondaryColor: Color(red: 0.78, green: 0.43, blue: 0.18),
            tags: ["warm", "casual", "golden"],
            isPremium: false
        ),
        Outfit(
            name: "Midnight Luxe",
            category: .evening,
            description: "Deep jewel tones for an unforgettable night out",
            primaryColor: Color(red: 0.18, green: 0.10, blue: 0.32),
            secondaryColor: Color(red: 0.83, green: 0.69, blue: 0.22),
            tags: ["evening", "glamour", "luxury"],
            isPremium: true
        ),
        Outfit(
            name: "Street Rebel",
            category: .street,
            description: "Bold graphics, oversized silhouettes, pure urban energy",
            primaryColor: Color(red: 0.10, green: 0.10, blue: 0.10),
            secondaryColor: Color(red: 0.85, green: 0.18, blue: 0.18),
            tags: ["streetwear", "bold", "urban"],
            isPremium: false
        ),
        Outfit(
            name: "Boho Goddess",
            category: .boho,
            description: "Flowy fabrics, earth tones, free-spirited layers",
            primaryColor: Color(red: 0.78, green: 0.60, blue: 0.42),
            secondaryColor: Color(red: 0.52, green: 0.68, blue: 0.48),
            tags: ["boho", "earthy", "layered"],
            isPremium: true
        ),
        Outfit(
            name: "Power Suit",
            category: .formal,
            description: "Structured tailoring that commands every room you enter",
            primaryColor: Color(red: 0.14, green: 0.19, blue: 0.30),
            secondaryColor: Color(red: 0.55, green: 0.62, blue: 0.74),
            tags: ["formal", "tailored", "business"],
            isPremium: true
        ),
        Outfit(
            name: "Sport Luxe",
            category: .sport,
            description: "Athletic meets elegant — from studio straight to street",
            primaryColor: Color(red: 0.08, green: 0.08, blue: 0.10),
            secondaryColor: Color(red: 0.83, green: 0.69, blue: 0.22),
            tags: ["sport", "active", "luxe"],
            isPremium: true
        ),
        Outfit(
            name: "Coastal Chic",
            category: .casual,
            description: "Ocean-inspired hues, breezy fabrics, effortless summer style",
            primaryColor: Color(red: 0.52, green: 0.76, blue: 0.86),
            secondaryColor: Color(red: 0.92, green: 0.94, blue: 0.96),
            tags: ["coastal", "summer", "breezy"],
            isPremium: true
        ),
        Outfit(
            name: "Rose Editorial",
            category: .evening,
            description: "Soft femininity meets bold editorial confidence",
            primaryColor: Color(red: 0.88, green: 0.62, blue: 0.68),
            secondaryColor: Color(red: 0.42, green: 0.18, blue: 0.28),
            tags: ["editorial", "feminine", "pink"],
            isPremium: true
        ),
        Outfit(
            name: "Nordic Cool",
            category: .minimal,
            description: "Scandinavian simplicity with sharp monochrome contrast",
            primaryColor: Color(red: 0.95, green: 0.95, blue: 0.95),
            secondaryColor: Color(red: 0.12, green: 0.12, blue: 0.12),
            tags: ["nordic", "monochrome", "sharp"],
            isPremium: true
        ),
        Outfit(
            name: "Desert Bloom",
            category: .boho,
            description: "Sun-baked terracotta and sage in effortless layers",
            primaryColor: Color(red: 0.82, green: 0.52, blue: 0.32),
            secondaryColor: Color(red: 0.60, green: 0.72, blue: 0.56),
            tags: ["boho", "desert", "terracotta"],
            isPremium: true
        ),
        Outfit(
            name: "Velvet Night",
            category: .evening,
            description: "Opulent textures and jewel tones for formal occasions",
            primaryColor: Color(red: 0.22, green: 0.08, blue: 0.35),
            secondaryColor: Color(red: 0.72, green: 0.22, blue: 0.52),
            tags: ["velvet", "formal", "opulent"],
            isPremium: true
        ),
    ]

    // MARK: - Style Tips

    static let styleTips: [StyleTip] = [
        StyleTip(
            title: "The Rule of Three",
            body: "Limit your outfit to three colors. One dominant, one secondary, one accent — always harmonious.",
            icon: "triangle.fill"
        ),
        StyleTip(
            title: "Invest in Basics",
            body: "A white button-down, well-fit jeans, and a tailored blazer form the core of any wardrobe.",
            icon: "star.fill"
        ),
        StyleTip(
            title: "Texture Mixing",
            body: "Pair smooth and textured fabrics for depth. Silk with denim, leather with linen — contrast is key.",
            icon: "square.on.square.fill"
        ),
        StyleTip(
            title: "Fit Is Everything",
            body: "Even budget pieces look expensive when they fit. Tailoring is the ultimate style upgrade.",
            icon: "scissors"
        ),
        StyleTip(
            title: "One Statement Piece",
            body: "One bold piece per outfit — sculptural bag, striking earrings, or a standout belt. Let it shine alone.",
            icon: "sparkles"
        ),
        StyleTip(
            title: "Capsule Wardrobe",
            body: "30 versatile pieces that all work together give you 100+ combinations with zero morning stress.",
            icon: "square.grid.3x3.fill"
        ),
        StyleTip(
            title: "Proportion Play",
            body: "Balance oversized tops with slim bottoms and vice versa. Proportion harmony makes any outfit pop.",
            icon: "arrow.up.left.and.arrow.down.right"
        ),
    ]

    // MARK: - Colour Palettes

    static let colorPalettes: [ColorPalette] = [
        ColorPalette(
            name: "Quiet Luxury",
            colors: [
                Color(red: 0.91, green: 0.88, blue: 0.82),
                Color(red: 0.74, green: 0.70, blue: 0.63),
                Color(red: 0.52, green: 0.47, blue: 0.42),
                Color(red: 0.28, green: 0.25, blue: 0.22),
            ],
            mood: "Sophisticated · Timeless"
        ),
        ColorPalette(
            name: "Electric Pop",
            colors: [
                Color(red: 0.95, green: 0.95, blue: 0.10),
                Color(red: 0.10, green: 0.85, blue: 0.75),
                Color(red: 0.95, green: 0.20, blue: 0.55),
                Color(red: 0.15, green: 0.15, blue: 0.15),
            ],
            mood: "Bold · Energetic"
        ),
        ColorPalette(
            name: "Terra Cotta",
            colors: [
                Color(red: 0.85, green: 0.55, blue: 0.35),
                Color(red: 0.72, green: 0.40, blue: 0.25),
                Color(red: 0.92, green: 0.80, blue: 0.68),
                Color(red: 0.38, green: 0.22, blue: 0.15),
            ],
            mood: "Earthy · Warm"
        ),
        ColorPalette(
            name: "Ocean Depth",
            colors: [
                Color(red: 0.10, green: 0.22, blue: 0.42),
                Color(red: 0.15, green: 0.45, blue: 0.65),
                Color(red: 0.40, green: 0.72, blue: 0.82),
                Color(red: 0.85, green: 0.92, blue: 0.95),
            ],
            mood: "Serene · Deep"
        ),
        ColorPalette(
            name: "Cherry Blossom",
            colors: [
                Color(red: 0.98, green: 0.88, blue: 0.90),
                Color(red: 0.92, green: 0.65, blue: 0.72),
                Color(red: 0.78, green: 0.35, blue: 0.48),
                Color(red: 0.35, green: 0.15, blue: 0.22),
            ],
            mood: "Romantic · Soft"
        ),
    ]

    // MARK: - AI chat suggested prompts

    static let suggestedPrompts: [String] = [
        "What to wear on a first date?",
        "Help me build a capsule wardrobe",
        "Best colors for spring?",
        "What's trending this season?",
        "Chic office outfit ideas?",
        "How to style oversized pieces?",
    ]
}
