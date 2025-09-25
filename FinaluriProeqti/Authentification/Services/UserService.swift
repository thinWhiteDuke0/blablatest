//
//  UserService.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 25.09.25.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

class UserService: ObservableObject {
    @Published var currentUser: User?

    static let shared = UserService()

    init() {
      // Check if user is already authenticated on app start
      if Auth.auth().currentUser != nil {
          Task {
              try? await fetchCurrentUser()
          }
      }
  }

    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("No authenticated user found")
            return
        }

        do {
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            let user = try snapshot.data(as: User.self)
            self.currentUser = user
            print("User data fetched successfully: \(user.fullname)")
        } catch {
            print("Error fetching user data: \(error)")
            throw error
        }
    }

    @MainActor
    func clearCurrentUser() {
        self.currentUser = nil
    }
}
