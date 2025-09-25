//
//  AppColors.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 25.09.25.
//


import SwiftUI

struct AppColors {
    // MARK: - Primary
    static let primaryGreen = Color(red: 0.25, green: 0.65, blue: 0.45)
    static let darkGreen = Color(red: 0.15, green: 0.45, blue: 0.30)
    static let lightGreen = Color(red: 0.30, green: 0.70, blue: 0.50)
    static let mediumGreen = Color(red: 0.30, green: 0.60, blue: 0.45)

    // MARK: - Secondary
    static let softGreen = Color(red: 0.20, green: 0.55, blue: 0.35)
    static let accentGreen = Color(red: 0.20, green: 0.58, blue: 0.40)
    static let featuredColor = Color(red: 0.8, green: 0.2, blue: 0.3)

    // MARK: - Background
    static let backgroundLight = Color(red: 0.85, green: 0.95, blue: 0.88)
    static let backgroundMedium = Color(red: 0.92, green: 0.98, blue: 0.94)
    static let overlayBackground = Color(red: 0.95, green: 0.98, blue: 0.96)

    // MARK: - Text
    static let primaryText = darkGreen
    static let secondaryText = mediumGreen

    // MARK: - Shadow & Cards
    static let shadowColor = Color(red: 0.15, green: 0.45, blue: 0.30)
    static let cardShadow = Color(red: 0.20, green: 0.50, blue: 0.35)

    // MARK: - Additional Colors for UI Elements
    static let surfaceColor = Color.white
    static let borderColor = Color(red: 0.85, green: 0.92, blue: 0.88)
    static let dividerColor = Color(red: 0.80, green: 0.88, blue: 0.82)
    static let errorColor = Color(red: 0.9, green: 0.2, blue: 0.3)
    static let warningColor = Color(red: 0.95, green: 0.6, blue: 0.1)
    static let successColor = primaryGreen
    static let infoColor = Color(red: 0.2, green: 0.6, blue: 0.9)

    // MARK: - Interaction States
    static let pressedState = Color(red: 0.20, green: 0.55, blue: 0.35)
    static let disabledState = Color(red: 0.70, green: 0.80, blue: 0.75)
    static let highlightColor = Color(red: 0.35, green: 0.75, blue: 0.55)

    // MARK: - Semantic Colors
    static let favoriteActive = Color(red: 0.8, green: 0.2, blue: 0.4)
    static let favoriteInactive = Color(red: 0.6, green: 0.6, blue: 0.6)

    // MARK: - Gradients
    static let primaryGradient = LinearGradient(
        colors: [darkGreen, primaryGreen],
        startPoint: .leading,
        endPoint: .trailing
    )

    static let backgroundGradient = LinearGradient(
        colors: [backgroundLight, backgroundMedium, Color(.systemBackground)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let headerGradient = LinearGradient(
        colors: [softGreen, primaryGreen, Color(red: 0.15, green: 0.50, blue: 0.40), lightGreen],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let buttonGradient = LinearGradient(
        colors: [softGreen, lightGreen],
        startPoint: .leading,
        endPoint: .trailing
    )

    static let cardGradient = LinearGradient(
        colors: [surfaceColor, Color(red: 0.98, green: 0.99, blue: 0.98)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let overlayGradient = LinearGradient(
        colors: [Color.black.opacity(0.1), Color.black.opacity(0.3)],
        startPoint: .top,
        endPoint: .bottom
    )
}
