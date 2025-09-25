//
//  RegistrationView.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 24.09.25.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            // Background
            AppColors.backgroundGradient
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 32) {
                    Spacer(minLength: 40)

                    // Header Section
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(AppColors.primaryGreen)
                                .frame(width: 70, height: 70)
                                .shadow(color: AppColors.shadowColor.opacity(0.3), radius: 8, x: 0, y: 4)

                            Image(systemName: "person.crop.circle.badge.plus")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                        }

                        Text("Create Account")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundStyle(AppColors.primaryGradient)

                        Text("Join WorldCities community")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(AppColors.secondaryText)
                    }

                    // Form Section
                    VStack(spacing: 16) {
                        TextField("Enter your email", text: $viewModel.email)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .modifier(PrettyTextFieldModifier())

                        SecureField("Enter your password", text: $viewModel.password)
                            .modifier(PrettyTextFieldModifier())

                        TextField("Enter your full name", text: $viewModel.fullname)
                            .modifier(PrettyTextFieldModifier())

                        TextField("Enter your username", text: $viewModel.username)
                            .autocapitalization(.none)
                            .modifier(PrettyTextFieldModifier())
                    }
                    .padding(.horizontal, 20)

                    // Sign Up Button
                    Button {
                        Task { try await viewModel.createUser() }
                    } label: {
                        Text("Sign Up")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(AppColors.primaryGreen)
                            .cornerRadius(16)
                            .shadow(color: AppColors.primaryGreen.opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    .padding(.horizontal, 20)

                    Spacer(minLength: 40)

                    // Sign In Link
                    VStack(spacing: 16) {
                        Rectangle()
                            .fill(AppColors.secondaryText.opacity(0.3))
                            .frame(height: 1)
                            .padding(.horizontal, 20)

                        Button {
                            dismiss()
                        } label: {
                            HStack(spacing: 4) {
                                Text("Already have an account?")
                                    .foregroundColor(AppColors.secondaryText)
                                Text("Sign In")
                                    .fontWeight(.semibold)
                                    .foregroundColor(AppColors.primaryGreen)
                            }
                            .font(.system(size: 15, weight: .medium))
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)

    }
}

#Preview {
    RegistrationView()
}
