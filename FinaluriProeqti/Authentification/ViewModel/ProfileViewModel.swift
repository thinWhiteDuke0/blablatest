//
//  ProfileViewModel.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 25.09.25.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var userDescription: String = ""

    private let profileService: ProfileService
    private var cancellables = Set<AnyCancellable>()

    init(profileService: ProfileService = ProfileService()) {
        self.profileService = profileService
        setupSubscribers()
    }

    private func setupSubscribers() {
        UserService.shared.$currentUser
            .sink { [weak self] user in
                self?.currentUser = user
                if let user = user {
                    self?.loadUserDescription(for: user.id)
                }
            }
            .store(in: &cancellables)
    }

    func saveDescription() {
        guard let userId = currentUser?.id else { return }
        profileService.saveDescription(userDescription, for: userId)
    }

    private func loadUserDescription(for userId: String) {
        userDescription = profileService.loadDescription(for: userId)
    }
}
