//
//  AuthService.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 24.09.25.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore


import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthService: ObservableObject {
    @Published var userSession: FirebaseAuth.User?

    static let shared = AuthService()

    init() {
        self.userSession = Auth.auth().currentUser

        // Listen for auth state changes to handle app restart scenarios
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.userSession = user

                // Fetch user data when auth state is restored
                if user != nil {
                    Task {
                        try? await UserService.shared.fetchCurrentUser()
                    }
                } else {
                    Task { @MainActor in
                        UserService.shared.clearCurrentUser()
                    }
                }
            }
        }
    }

    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user

            // Trigger user data fetch after successful login
            try await UserService.shared.fetchCurrentUser()
            print("User logged in successfully")
        } catch {
            print("Login error: \(error)")
            throw error
        }
    }

    func createUser(withEmail email: String, password: String, fullname: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)

            await MainActor.run {
                self.userSession = result.user
            }

            try await uploadUserData(withEmail: email, fullname: fullname, username: username, id: result.user.uid)

            // Fetch user data after successful registration
            try await UserService.shared.fetchCurrentUser()
            print("User created and data uploaded successfully")
        } catch {
            print("Create user error: \(error)")
            throw error
        }
    }

    @MainActor
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        // Clear user data on sign out
        UserService.shared.clearCurrentUser()
    }

    @MainActor
    private func uploadUserData(
        withEmail email: String,
        fullname: String,
        username: String,
        id: String
    ) async throws {
        let user = User(id: id, fullname: fullname, email: email, username: username)
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        do {
            try await Firestore.firestore().collection("users").document(id).setData(userData)
            print("User data uploaded successfully to Firestore")
        } catch {
            print("Error uploading to Firestore: \(error)")
            throw error
        }
    }
}
