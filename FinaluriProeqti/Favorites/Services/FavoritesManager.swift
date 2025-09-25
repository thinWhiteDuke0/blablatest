//
//  FavoritesManager.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 24.09.25.
//

import Foundation



@MainActor
class FavoritesManager: FavoriteManaging {
    @Published var favoriteCities: Set<City> = []
    
    private let storage: FavoritesStoraging
    
    // Dependency Injection
    init(storage: FavoritesStoraging = UserDefaultsFavoritesStorage()) {
        self.storage = storage
        loadFavorites()
    }
    
    func isFavorite(_ city: City) -> Bool {
        favoriteCities.contains(city)
    }
    
    func toggleFavorite(_ city: City) {
        if isFavorite(city) {
            removeFromFavorites(city)
        } else {
            addToFavorites(city)
        }
    }
    
    func addToFavorites(_ city: City) {
        favoriteCities.insert(city)
        saveFavorites()
    }
    
    func removeFromFavorites(_ city: City) {
        favoriteCities.remove(city)
        saveFavorites()
    }
    
    func clearAllFavorites() {
        favoriteCities.removeAll()
        saveFavorites()
    }
    
    private func loadFavorites() {
        favoriteCities = storage.loadFavorites()
    }
    
    private func saveFavorites() {
        storage.saveFavorites(favoriteCities)
    }
}
