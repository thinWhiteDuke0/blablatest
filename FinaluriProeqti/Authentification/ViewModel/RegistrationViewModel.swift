//
//  AuthViewModel.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 24.09.25.
//

import Foundation

class RegistrationViewModel: ObservableObject {

  @Published var email = ""
  @Published var password = ""
  @Published var fullname = ""
  @Published var username = ""

  @MainActor
  func createUser() async throws {
    try await AuthService.shared.createUser(withEmail: email, password: password, fullname: fullname, username: username)
  }

}
