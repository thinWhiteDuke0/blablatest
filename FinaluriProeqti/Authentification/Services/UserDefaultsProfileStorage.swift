//
//  UserDefaultsProfileStorage.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 25.09.25.
//

import Foundation

protocol UserProfileStoraging {
    func saveUserDescription(_ description: String, for userId: String)
    func loadUserDescription(for userId: String) -> String?
}

class UserDefaultsProfileStorage: UserProfileStoraging {
    private let descriptionKeyPrefix = "user_description_"
    
    func saveUserDescription(_ description: String, for userId: String) {
        let key = descriptionKeyPrefix + userId
        UserDefaults.standard.set(description, forKey: key)
    }
    
    func loadUserDescription(for userId: String) -> String? {
        let key = descriptionKeyPrefix + userId
        return UserDefaults.standard.string(forKey: key)
    }
}
