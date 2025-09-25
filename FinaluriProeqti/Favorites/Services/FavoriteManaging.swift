//
//  FavoriteManaging.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 24.09.25.
//


import Foundation


import Foundation

// MARK: - Favorites Protocol
@MainActor
protocol FavoriteManaging: ObservableObject {
    var favoriteCities: Set<City> { get }
    func isFavorite(_ city: City) -> Bool
    func toggleFavorite(_ city: City)
    func addToFavorites(_ city: City)
    func removeFromFavorites(_ city: City)
    func clearAllFavorites()
}

// MARK: - Favorites Storage Protocol
protocol FavoritesStoraging {
    func saveFavorites(_ favorites: Set<City>)
    func loadFavorites() -> Set<City>
}
