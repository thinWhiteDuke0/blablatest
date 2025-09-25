//
//  FavoritesViewModel.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 24.09.25.
//

import Foundation

@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var searchText: String = ""
    
    let favoritesManager: any FavoriteManaging
    
    init(favoritesManager: any FavoriteManaging) {
        self.favoritesManager = favoritesManager
    }
    
    var filteredFavorites: [City] {
        let favorites = Array(favoritesManager.favoriteCities)
        
        if searchText.isEmpty {
            return favorites.sorted { $0.city < $1.city }
        } else {
            return favorites
                .filter { city in
                    city.city.localizedCaseInsensitiveContains(searchText) ||
                    city.country.localizedCaseInsensitiveContains(searchText) ||
                    city.region.localizedCaseInsensitiveContains(searchText)
                }
                .sorted { $0.city < $1.city }
        }
    }
    
    var isEmpty: Bool {
        favoritesManager.favoriteCities.isEmpty
    }
    
    func removeFromFavorites(_ city: City) {
        favoritesManager.removeFromFavorites(city)
    }
    
    func clearAllFavorites() {
        favoritesManager.clearAllFavorites()
    }
}
