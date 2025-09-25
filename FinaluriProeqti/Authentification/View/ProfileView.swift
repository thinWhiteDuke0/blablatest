//
//  ProfileView.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 25.09.25.
//



import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var isEditingDescription = false
    @State private var showingSignOutAlert = false

    private let profileImage = "person.crop.circle.fill"

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                profileHeader
                userInfoSection
                descriptionSection
                signOutButton
                Spacer(minLength: 40)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        .background(AppColors.backgroundGradient.ignoresSafeArea())
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            AppDelegate.orientationLock = .all
        }
        .onDisappear {
            AppDelegate.orientationLock = .portrait
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        }
        .alert("Sign Out", isPresented: $showingSignOutAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Sign Out", role: .destructive) {
                signOut()
            }
        } message: {
            Text("Are you sure you want to sign out?")
        }
    }

    // MARK: - Profile Header
    private var profileHeader: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(AppColors.primaryGreen)
                    .frame(width: 120, height: 120)
                    .shadow(color: AppColors.shadowColor.opacity(0.3), radius: 10, x: 0, y: 5)

                Image(systemName: profileImage)
                    .font(.system(size: 60, weight: .medium))
                    .foregroundColor(.white)
            }

            Button(action: {
                // Photo edit functionality ... if i had time
            }) {
                Text("Edit Photo")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(AppColors.primaryGreen)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(AppColors.primaryGreen, lineWidth: 1.5)
                    )
            }
        }
    }

    // MARK: - User Info Section
    private var userInfoSection: some View {
        VStack(spacing: 12) {
            Text(viewModel.currentUser?.fullname ?? "Loading...")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(AppColors.primaryText)

            Text("@\(viewModel.currentUser?.username ?? "username")")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppColors.secondaryText)
        }
    }

    // MARK: - Description Section
    private var descriptionSection: some View {
        VStack(spacing: 16) {
            HStack {
                Text("About")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(AppColors.primaryText)

                Spacer()

                Button(action: {
                    if isEditingDescription {
                        viewModel.saveDescription()
                    }
                    isEditingDescription.toggle()
                }) {
                    Image(systemName: isEditingDescription ? "checkmark" : "pencil")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(AppColors.primaryGreen)
                        .frame(width: 32, height: 32)
                        .background(
                            Circle()
                                .fill(AppColors.primaryGreen.opacity(0.1))
                        )
                }
            }

            if isEditingDescription {
                TextEditor(text: $viewModel.userDescription)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(AppColors.primaryText)
                    .padding(16)
                    .frame(minHeight: 100)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                            .stroke(AppColors.primaryGreen.opacity(0.3), lineWidth: 1)
                    )
            } else {
                Text(viewModel.userDescription)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(AppColors.secondaryText)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                            .shadow(color: AppColors.cardShadow.opacity(0.1), radius: 8, x: 0, y: 4)
                    )
            }
        }
    }

    // MARK: - Sign Out Button
    private var signOutButton: some View {
        Button(action: {
            showingSignOutAlert = true
        }) {
            HStack {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.system(size: 16, weight: .semibold))

                Text("Sign Out")
                    .font(.system(size: 16, weight: .semibold))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(AppColors.featuredColor)
            )
        }
        .padding(.top, 20)
    }

    // MARK: - Functions
    private func signOut() {
        AuthService.shared.signOut()
    }
}

#Preview {
  ProfileView()
}
