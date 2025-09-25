//
//  LoginViewModel.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 25.09.25.
//

import Foundation


class LoginViewModel: ObservableObject {

  @Published var email = ""
  @Published var password = ""


  @MainActor
  func login() async throws {
    try await AuthService.shared.login(withEmail: email, password: password)
  }

}
