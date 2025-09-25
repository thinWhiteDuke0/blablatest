//
//  UserDefaultsFavoritesStorage.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 24.09.25.
//

import Foundation


class UserDefaultsFavoritesStorage: FavoritesStoraging {
    private let key = "favorite_cities"
    
    func saveFavorites(_ favorites: Set<City>) {
        do {
            let data = try JSONEncoder().encode(Array(favorites))
            UserDefaults.standard.set(data, forKey: key)
        } catch {
        }
    }
    
    func loadFavorites() -> Set<City> {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return Set<City>()
        }
        
        do {
            let cities = try JSONDecoder().decode([City].self, from: data)
            return Set(cities)
        } catch {
            return Set<City>()
        }
    }
}
