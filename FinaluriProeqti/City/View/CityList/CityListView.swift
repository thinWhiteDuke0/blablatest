//
//  CityListView.swift
//  FinalTaskApp
//
//  Created by Giorgi Manjavidze on 24.09.25.
//


import SwiftUI

struct CityListView: View {
    @StateObject private var viewModel = CityViewModel()
    @EnvironmentObject var favoritesManager: FavoritesManager
    @State private var selectedCity: City?

    private let columns = [
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24)
    ]

    var body: some View {
        NavigationView {
            ZStack {
                backgroundView

                ScrollView {
                    LazyVStack(spacing: 24) {
                        headerImageView

                        headerSection

                        searchSection

                        if !viewModel.cities.isEmpty {
                            citiesStatsCard
                        }

                        if viewModel.isLoading && viewModel.cities.isEmpty {
                            EmptyView()
                        } else if viewModel.cities.isEmpty && !viewModel.searchText.isEmpty {
                            noSearchResultsView
                        } else if viewModel.cities.isEmpty && !viewModel.isLoading {
                            emptyStateView
                        } else {
                            citiesGridSection
                        }
                        loadingSection
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                }
                .refreshable {
                    await viewModel.refreshCities()
                }

                // Initial loading overlay
                if viewModel.isLoading && viewModel.cities.isEmpty {
                    loadingOverlay
                }
            }
            .navigationBarHidden(true)
        }
        .task {
            if viewModel.cities.isEmpty && !viewModel.isLoading {
                await viewModel.loadCities()
            }
        }
        .fullScreenCover(item: $selectedCity) { city in
            CityDetailView(city: city, favoritesManager: favoritesManager)
        }
    }

    // MARK: - Empty States
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "building.2")
                .font(.system(size: 48, weight: .light))
                .foregroundColor(AppColors.primaryGreen.opacity(0.6))

            Text(LocalizationKey.noCitiesFound)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(AppColors.primaryText)

            Text(LocalizationKey.unableToLoadCities)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppColors.secondaryText)
                .multilineTextAlignment(.center)

            Button(LocalizationKey.retry) {
                Task { await viewModel.retry() }
            }
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(.white)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(AppColors.primaryGreen)
            )
        }
        .padding(.vertical, 60)
    }

    private var noSearchResultsView: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48, weight: .light))
                .foregroundColor(AppColors.primaryGreen.opacity(0.6))

            Text(LocalizationKey.noResults)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(AppColors.primaryText)

            Text("\(LocalizationKey.noCitiesMatch) '\(viewModel.searchText)'")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppColors.secondaryText)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 60)
    }

    // MARK: - Background
    private var backgroundView: some View {
        AppColors.backgroundGradient
            .ignoresSafeArea()
    }

    // MARK: - Header Image
    private var headerImageView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .fill(AppColors.headerGradient)
                .frame(height: 180)

            RoundedRectangle(cornerRadius: 28)
                .fill(
                    RadialGradient(
                        colors: [
                            Color.white.opacity(0.1),
                            Color.clear,
                            Color.black.opacity(0.1)
                        ],
                        center: .topLeading,
                        startRadius: 50,
                        endRadius: 200
                    )
                )
                .frame(height: 180)

            VStack(spacing: 12) {
                Text("🏙️🌍🗺️")
                    .font(.system(size: 28))

                Text(LocalizationKey.exploreWorldCities)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 24)
                    .background(AppColors.buttonGradient)
                    .cornerRadius(14)
            }


        }
        .shadow(color: AppColors.shadowColor.opacity(0.4), radius: 15, x: 0, y: 8)
    }

    // MARK: - Header Section
    private var headerSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(LocalizationKey.citiesInfo)
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.primaryGradient)

              Text("\(viewModel.cities.count) \(LocalizationKey.citiesLoaded)")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(AppColors.secondaryText)
            }

            Spacer()
        }
        .padding(.top, 12)
    }

    // MARK: - Search Section
    private var searchSection: some View {
        HStack(spacing: 14) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(AppColors.primaryGreen)
                .font(.system(size: 17, weight: .medium))

            TextField(LocalizationKey.searchCitiesPlaceholder, text: $viewModel.searchText)
                .textFieldStyle(PlainTextFieldStyle())
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)

            if !viewModel.searchText.isEmpty {
                Button {
                    viewModel.searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(AppColors.secondaryText)
                        .font(.system(size: 15))
                }
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: AppColors.cardShadow, radius: 12, x: 0, y: 4)
        )
    }

    // MARK: - Cities Stats Card
    private var citiesStatsCard: some View {
        HStack(spacing: 16) {
            StatCard(
                icon: "building.2.fill",
                title: "Cities",
                value: "\(viewModel.cities.count)",
                color: AppColors.accentGreen
            )

            if let topCity = viewModel.cities.randomElement() {
                StatCard(
                    icon: "location.fill",
                    title: "Featured",
                    value: topCity.city,
                    color: AppColors.primaryGreen
                )
            }

            StatCard(
                icon: viewModel.searchText.isEmpty ? "globe.americas.fill" : "magnifyingglass",
                title: viewModel.searchText.isEmpty ? LocalizationKey.browse : LocalizationKey.search,
                value: viewModel.searchText.isEmpty ? LocalizationKey.global : LocalizationKey.active,
                color: AppColors.featuredColor
            )
        }
        .padding(.vertical, 8)
    }

    // MARK: - Cities Grid Section
    private var citiesGridSection: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(Array(viewModel.cities.enumerated()), id: \.element.id) { index, city in
                CityCard(city: city, index: index, favoritesManager: favoritesManager) {
                    selectedCity = city
                }
                .onAppear {
                    // Only load more when not in search mode and reaching the last item
                    if viewModel.searchText.isEmpty &&
                       city.id == viewModel.cities.last?.id &&
                       viewModel.hasMoreData {
                        Task {
                            await viewModel.loadMoreCities()
                        }
                    }
                }
            }
        }
    }

    // MARK: - Loading Section
    private var loadingSection: some View {
        Group {
            if viewModel.hasMoreData && !viewModel.cities.isEmpty && viewModel.searchText.isEmpty {
                HStack(spacing: 14) {
                    ProgressView()
                        .scaleEffect(0.9)
                        .tint(AppColors.primaryGreen)

                  Text(LocalizationKey.loadingMoreCities)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(AppColors.secondaryText)
                }
                .padding(.vertical, 24)
            }
        }
    }

    // MARK: - Loading Overlay
    private var loadingOverlay: some View {
        ZStack {
            AppColors.overlayBackground
                .opacity(0.95)
                .ignoresSafeArea()

            VStack(spacing: 18) {
                ProgressView()
                    .scaleEffect(1.3)
                    .tint(AppColors.primaryGreen)

                Text("Exploring the World...")
                    .font(.system(size: 19, weight: .semibold, design: .rounded))
                    .foregroundColor(AppColors.softGreen)
            }
        }
    }
}


#Preview {
    CityListView()
        .environmentObject(FavoritesManager())
}
