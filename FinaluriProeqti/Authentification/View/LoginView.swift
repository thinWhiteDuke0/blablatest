//
//  LoginView.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 24.09.25.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.backgroundGradient
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 32) {
                        Spacer(minLength: 60)

                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(AppColors.primaryGreen)
                                    .frame(width: 80, height: 80)
                                    .shadow(color: AppColors.shadowColor.opacity(0.3), radius: 10, x: 0, y: 5)

                                Image(systemName: "building.2.fill")
                                    .font(.system(size: 35, weight: .bold))
                                    .foregroundColor(.white)
                            }

                            Text("WorldCities")
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .foregroundStyle(AppColors.primaryGradient)

                            Text("Explore the world, one city at a time")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(AppColors.secondaryText)
                                .multilineTextAlignment(.center)
                        }

                        // Form Section
                        VStack(spacing: 20) {
                            TextField("Enter your email", text: $viewModel.email)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                                .modifier(PrettyTextFieldModifier())

                            SecureField("Enter your password", text: $viewModel.password)
                                .modifier(PrettyTextFieldModifier())
                        }
                        .padding(.horizontal, 20)


                        Button {
                            Task { try await viewModel.login() }
                        } label: {
                            Text("Login")
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

                        // Sign Up Link
                        VStack(spacing: 16) {
                            Rectangle()
                                .fill(AppColors.secondaryText.opacity(0.3))
                                .frame(height: 1)
                                .padding(.horizontal, 20)

                            NavigationLink {
                                RegistrationView()
                            } label: {
                                HStack(spacing: 4) {
                                    Text("Don't have an account?")
                                        .foregroundColor(AppColors.secondaryText)
                                    Text("Sign Up")
                                        .fontWeight(.semibold)
                                        .foregroundColor(AppColors.primaryGreen)
                                }
                                .font(.system(size: 15, weight: .medium))
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }

    }
}



#Preview {
    LoginView()
}
