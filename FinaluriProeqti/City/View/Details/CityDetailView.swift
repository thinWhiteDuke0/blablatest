//
//  CityDetailView.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 20.09.25.
//


import SwiftUI
import MapKit

struct CityDetailView: View {
    let city: City
    let favoritesManager: any FavoriteManaging
    @Environment(\.dismiss) private var dismiss
    @State private var showingFullScreen = false
    @State private var scrollOffset: CGFloat = 0
    @State private var showingMap = false

    init(city: City, favoritesManager: any FavoriteManaging) {
        self.city = city
        self.favoritesManager = favoritesManager
    }

    var body: some View {
        ZStack {
            // Modern green background using AppColors
            LinearGradient(
                colors: [
                    AppColors.softGreen,
                    AppColors.mediumGreen,
                    AppColors.primaryGreen
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                LazyVStack(spacing: 0) {
                    // Minimal header with floating cards
                    modernHeaderSection

                    // Content with glassmorphism cards
                    VStack(spacing: 24) {
                        // Hero stats cards
                        heroStatsSection

                        // Main info card
                        mainInfoCard

                        // Location details
                        locationDetailsCard

                        // Action section
                        modernActionSection
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 40)
                    .padding(.bottom, 30)
                }
            }
            .coordinateSpace(name: "scroll")

            // Floating navigation
            floatingNavigation
        }
        .sheet(isPresented: $showingMap) {
            CityMapView(city: city)
        }
    }

    // MARK: - Modern Header Section
    private var modernHeaderSection: some View {
        ZStack {
            // Gradient backdrop using AppColors
            RoundedRectangle(cornerRadius: 0)
                .fill(AppColors.headerGradient)
                .frame(height: 280)

            // Main content
            VStack(spacing: 20) {
                // Flag with modern styling
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(AppColors.surfaceColor.opacity(0.2))
                        .frame(width: 100, height: 100)
                        .blur(radius: 20)

                    RoundedRectangle(cornerRadius: 16)
                        .fill(AppColors.surfaceColor.opacity(0.25))
                        .frame(width: 80, height: 80)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(AppColors.surfaceColor.opacity(0.4), lineWidth: 1)
                        )

                    Text(city.countryEmoji)
                        .font(.system(size: 35))
                }

                VStack(spacing: 12) {
                    Text(city.city)
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [AppColors.surfaceColor, AppColors.surfaceColor.opacity(0.9)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .multilineTextAlignment(.center)

                    HStack(spacing: 16) {
                        Text(city.country)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(AppColors.surfaceColor.opacity(0.95))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .fill(AppColors.surfaceColor.opacity(0.2))
                                    .overlay(
                                        Capsule()
                                            .stroke(AppColors.surfaceColor.opacity(0.3), lineWidth: 1)
                                    )
                            )
                    }
                }
            }
            .padding(.top, 30)
        }
    }

    // MARK: - Hero Stats Section
    private var heroStatsSection: some View {
        HStack(spacing: 16) {
            ModernStatCard(
                value: formatPopulation(city.population ?? 0),
                title: "Population",
                icon: "person.3.fill",
                accentColor: AppColors.lightGreen
            )

            ModernStatCard(
                value: city.countryCode,
                title: "Country",
                icon: "flag.fill",
                accentColor: AppColors.accentGreen
            )

            ModernStatCard(
                value: String(city.region.prefix(8)) + "...",
                title: "Region",
                icon: "map.fill",
                accentColor: AppColors.highlightColor
            )
        }
    }

    // MARK: - Main Info Card
    private var mainInfoCard: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
              Text(LocalizationKey.cityOverview.localized)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(AppColors.surfaceColor)

                Spacer()

                Image(systemName: "building.2.fill")
                    .font(.system(size: 20))
                    .foregroundColor(AppColors.lightGreen)
            }

            VStack(spacing: 16) {
                ModernDetailRow(
                    title: LocalizationKey.fullName.localized,
                    value: city.name,
                    icon: "text.cursor"
                )

                ModernDetailRow(
                    title: LocalizationKey.countryCode.localized,
                    value: city.countryCode,
                    icon: "flag.2.crossed.fill"
                )

                ModernDetailRow(
                    title: LocalizationKey.region.localized,
                    value: city.region,
                    icon: "location.fill"
                )

                ModernDetailRow(
                    title: LocalizationKey.coordinates.localized,
                    value: String(format: "%.4f°, %.4f°", city.latitude, city.longitude),
                    icon: "globe"
                )

                ModernDetailRow(
                    title: LocalizationKey.populationCount.localized,
                    value: city.populationFormatted,
                    icon: "person.3.sequence.fill"
                )
            }
        }
        .padding(24)
        .background(glassmorphismBackground)
    }

    // MARK: - Location Details Card
    private var locationDetailsCard: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text(LocalizationKey.locationDetails)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(AppColors.surfaceColor)

                Spacer()

                Image(systemName: "location.circle.fill")
                    .font(.system(size: 20))
                    .foregroundColor(AppColors.accentGreen)
            }

            VStack(spacing: 18) {
                LocationFeatureCard(
                    icon: "binoculars.fill",
                    title: LocalizationKey.explore,
                    subtitle: "Discover \(city.city)",
                    description: LocalizationKey.findAmazingPlaces,
                    accentColor: AppColors.highlightColor
                )

                LocationFeatureCard(
                    icon: "heart.circle.fill",
                    title: "Favorites",
                    subtitle: "Save City",
                    description: LocalizationKey.keepTrackCities,
                    accentColor: AppColors.featuredColor
                )
            }
        }
        .padding(24)
        .background(glassmorphismBackground)
    }

    // MARK: - Modern Action Section
    private var modernActionSection: some View {
        VStack(spacing: 16) {
            ModernActionButton(
              title: LocalizationKey.viewOnMap,
                icon: "map.fill",
                gradient: LinearGradient(
                    colors: [AppColors.lightGreen, AppColors.primaryGreen],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            ) {
                showingMap = true
            }
        }
    }

    // MARK: - Floating Navigation
    private var floatingNavigation: some View {
        VStack {
            HStack {
                FavoriteButton(
                    city: city,
                    favoritesManager: favoritesManager,
                    style: .detailView
                )

                Spacer()

                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(AppColors.surfaceColor)
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(AppColors.softGreen.opacity(0.8))
                                .overlay(
                                    Circle()
                                        .stroke(AppColors.surfaceColor.opacity(0.3), lineWidth: 1)
                                )
                        )
                }
            }
            .padding(.top, 50)
            .padding(.horizontal, 20)

            Spacer()
        }
    }

    private var glassmorphismBackground: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(AppColors.surfaceColor.opacity(0.15))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(AppColors.surfaceColor.opacity(0.25), lineWidth: 1)
            )
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(AppColors.softGreen.opacity(0.2))
                    .blur(radius: 10)
            )
    }

    private func formatPopulation(_ population: Int?) -> String {
        guard let population = population else { return "N/A" }

        if population >= 1_000_000 {
            return String(format: "%.1fM", Double(population) / 1_000_000)
        } else if population >= 1_000 {
            return String(format: "%.0fK", Double(population) / 1_000)
        } else {
            return "\(population)"
        }
    }
}

#Preview {
    CityDetailView(
        city: City(
            id: 1,
            wikiDataId: "Q90",
            type: "city",
            city: "Paris",
            name: "Paris",
            country: "France",
            countryCode: "FR",
            region: "Île-de-France",
            regionCode: "IDF",
            latitude: 48.8566,
            longitude: 2.3522,
            population: 2_160_000
        ),
        favoritesManager: FavoritesManager()
    )
}
