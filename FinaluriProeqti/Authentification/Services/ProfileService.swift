//
//  ProfileService.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 25.09.25.
//

import Foundation

class ProfileService: ObservableObject {
    private let storage: UserProfileStoraging
    
    init(storage: UserProfileStoraging = UserDefaultsProfileStorage()) {
        self.storage = storage
    }
    
    func saveDescription(_ description: String, for userId: String) {
        storage.saveUserDescription(description, for: userId)
    }
    
    func loadDescription(for userId: String) -> String {
        return storage.loadUserDescription(for: userId) ?? "Bio is empty"
    }
}
