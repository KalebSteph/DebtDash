//
//  AppsColors.swift
//  debtDash
//
//  Created by Kaleb Stephens on 4/16/26.
//

import SwiftUI

enum AppColors {
    static let background = Color(hex: "#F8F4EC")
    static let card = Color(hex: "#F6F1E8")

    static let textPrimary = Color(hex: "#1E2430")
    static let textSecondary = Color(hex: "#6F7684")
    static let textMuted = Color(hex: "#A3A8B3")

    static let purple = Color(hex: "#6B3FD6")
    static let pink = Color(hex: "#FF4F7A")
    static let cyan = Color(hex: "#27C4F5")
    static let green = Color(hex: "#38C172")

    static let border = Color(hex: "#E3DDD3")
    static let track = Color(hex: "#E7E7E7")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255,
                            (int >> 8) * 17,
                            (int >> 4 & 0xF) * 17,
                            (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255,
                            int >> 16,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24,
                            int >> 16 & 0xFF,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
