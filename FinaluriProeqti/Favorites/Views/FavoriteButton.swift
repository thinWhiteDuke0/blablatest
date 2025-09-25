//
//  FavoriteButton.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 24.09.25.
//



import SwiftUI


struct FavoriteButton: View {
    let city: City
    @ObservedObject private var favoritesManager: FavoritesManager
    let style: FavoriteButtonStyle
    
    @State private var animationScale: CGFloat = 1.0
    @State private var isAnimating = false
    
    private var isFavorite: Bool {
        favoritesManager.isFavorite(city)
    }
    
    init(city: City, favoritesManager: any FavoriteManaging, style: FavoriteButtonStyle = .standard) {
        self.city = city
        self.favoritesManager = favoritesManager as! FavoritesManager  
        self.style = style
    }

    var body: some View {
        Button(action: toggleFavorite) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(.system(size: style.iconSize, weight: .semibold))
                .foregroundColor(isFavorite ? style.activeColor : style.inactiveColor)
                .scaleEffect(animationScale)
                .frame(width: style.frameSize, height: style.frameSize)
                .background(backgroundView)
        }
        .buttonStyle(PlainButtonStyle())
        .animation(.spring(response: 0.4, dampingFraction: 0.6), value: isFavorite)
    }
    
    @ViewBuilder
    private var backgroundView: some View {
        switch style.backgroundStyle {
        case .none:
            EmptyView()
        case .circle:
            Circle()
                .fill(style.backgroundColor)
                .overlay(
                    Circle()
                        .stroke(style.borderColor, lineWidth: style.borderWidth)
                )
        case .roundedRectangle:
            RoundedRectangle(cornerRadius: style.cornerRadius)
                .fill(style.backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: style.cornerRadius)
                        .stroke(style.borderColor, lineWidth: style.borderWidth)
                )
        }
    }
    
    private func toggleFavorite() {

        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
        

        withAnimation(.easeInOut(duration: 0.1)) {
            animationScale = 1.3
            isAnimating = true
        }
        

        favoritesManager.toggleFavorite(city)
        

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.easeInOut(duration: 0.1)) {
                animationScale = 1.0
                isAnimating = false
            }
        }
    }
}


struct FavoriteButtonStyle {
    let iconSize: CGFloat
    let frameSize: CGFloat
    let activeColor: Color
    let inactiveColor: Color
    let backgroundColor: Color
    let borderColor: Color
    let borderWidth: CGFloat
    let cornerRadius: CGFloat
    let backgroundStyle: BackgroundStyle
    
    enum BackgroundStyle {
        case none
        case circle
        case roundedRectangle
    }
    

    static let standard = FavoriteButtonStyle(
        iconSize: 16,
        frameSize: 40,
        activeColor: Color(red: 0.8, green: 0.2, blue: 0.4),
        inactiveColor: .white,
        backgroundColor: Color.white.opacity(0.15),
        borderColor: Color.white.opacity(0.2),
        borderWidth: 1,
        cornerRadius: 8,
        backgroundStyle: .circle
    )
    
    static let listCard = FavoriteButtonStyle(
        iconSize: 14,
        frameSize: 32,
        activeColor: Color(red: 0.8, green: 0.2, blue: 0.4),
        inactiveColor: Color(red: 0.6, green: 0.6, blue: 0.6),
        backgroundColor: Color.white.opacity(0.9),
        borderColor: Color(red: 0.9, green: 0.9, blue: 0.9),
        borderWidth: 1,
        cornerRadius: 6,
        backgroundStyle: .circle
    )
    
    static let detailView = FavoriteButtonStyle(
        iconSize: 18,
        frameSize: 44,
        activeColor: Color(red: 1.0, green: 0.4, blue: 0.6),
        inactiveColor: .white,
        backgroundColor: Color.white.opacity(0.15),
        borderColor: Color.white.opacity(0.2),
        borderWidth: 1,
        cornerRadius: 8,
        backgroundStyle: .circle
    )
    
    static let compact = FavoriteButtonStyle(
        iconSize: 12,
        frameSize: 28,
        activeColor: Color(red: 0.8, green: 0.2, blue: 0.4),
        inactiveColor: Color(red: 0.7, green: 0.7, blue: 0.7),
        backgroundColor: Color.clear,
        borderColor: Color.clear,
        borderWidth: 0,
        cornerRadius: 0,
        backgroundStyle: .none
    )
}

