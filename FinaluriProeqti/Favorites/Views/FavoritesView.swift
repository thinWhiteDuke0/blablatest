//
//  FavoritesView.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 24.09.25.
//


//
//  FavoritesView.swift
//  FinalTaskApp
//
//  Created by Assistant on 24.09.25.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel: FavoritesViewModel
    @State private var selectedCity: City?
    @State private var showingClearAlert = false
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    init(favoritesManager: any FavoriteManaging) {
        self._viewModel = StateObject(wrappedValue: FavoritesViewModel(favoritesManager: favoritesManager))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                backgroundView
                
                if viewModel.isEmpty {
                    emptyStateView
                } else {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            // Header
                            headerSection
                            
                            // Search Bar
                            if !viewModel.isEmpty {
                                searchSection
                            }
                            
                            // Stats Card
                            statsSection
                            
                            // Favorites Grid
                            favoritesGridSection
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(item: $selectedCity) { city in
            CityDetailView(city: city, favoritesManager: viewModel.favoritesManager) 
        }
        .alert("Clear All Favorites", isPresented: $showingClearAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Clear All", role: .destructive) {
                viewModel.clearAllFavorites()
            }
        } message: {
            Text("Are you sure you want to remove all cities from your favorites? This action cannot be undone.")
        }
    }
    
    // MARK: - Background
    private var backgroundView: some View {
        LinearGradient(
            colors: [
                Color(red: 0.95, green: 0.85, blue: 0.88),
                Color(red: 0.98, green: 0.92, blue: 0.94),
                Color(.systemBackground)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
    
    // MARK: - Empty State
    private var emptyStateView: some View {
        VStack(spacing: 24) {
            Image(systemName: "heart.slash")
                .font(.system(size: 64, weight: .light))
                .foregroundColor(Color(red: 0.8, green: 0.2, blue: 0.4).opacity(0.6))
            
            VStack(spacing: 12) {
                Text("No Favorites Yet")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(Color(red: 0.7, green: 0.15, blue: 0.35))
                
                Text("Start exploring cities and add your favorites to see them here.")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color(red: 0.6, green: 0.3, blue: 0.45))
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
            }
        }
        .padding(.horizontal, 40)
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("My Favorites")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [
                                Color(red: 0.7, green: 0.15, blue: 0.35),
                                Color(red: 0.8, green: 0.25, blue: 0.45)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                Text("\(viewModel.filteredFavorites.count) favorite cities")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color(red: 0.6, green: 0.3, blue: 0.45))
            }
            
            Spacer()
            
            if !viewModel.isEmpty {
                Button(action: { showingClearAlert = true }) {
                    Image(systemName: "trash")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(Color(red: 0.8, green: 0.2, blue: 0.4))
                                .shadow(color: Color(red: 0.8, green: 0.2, blue: 0.4).opacity(0.3), radius: 8, x: 0, y: 4)
                        )
                }
            }
        }
        .padding(.top, 12)
    }
    
    // MARK: - Search Section
    private var searchSection: some View {
        HStack(spacing: 14) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color(red: 0.8, green: 0.25, blue: 0.45))
                .font(.system(size: 17, weight: .medium))
            
            TextField("Search your favorites...", text: $viewModel.searchText)
                .textFieldStyle(PlainTextFieldStyle())
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)
            
            if !viewModel.searchText.isEmpty {
                Button {
                    viewModel.searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color(red: 0.6, green: 0.3, blue: 0.45))
                        .font(.system(size: 15))
                }
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color(red: 0.7, green: 0.2, blue: 0.4).opacity(0.15), radius: 12, x: 0, y: 4)
        )
    }
    
    // MARK: - Stats Section
    private var statsSection: some View {
        HStack(spacing: 16) {
            FavoriteStatCard(
                icon: "heart.fill",
                title: "Favorites",
                value: "\(viewModel.filteredFavorites.count)",
                color: Color(red: 0.8, green: 0.2, blue: 0.4)
            )
            
            if let mostRecentFavorite = viewModel.filteredFavorites.first {
                FavoriteStatCard(
                    icon: "star.fill",
                    title: "Recent",
                    value: mostRecentFavorite.city,
                    color: Color(red: 0.7, green: 0.25, blue: 0.45)
                )
            }
            
            FavoriteStatCard(
                icon: viewModel.searchText.isEmpty ? "list.bullet" : "magnifyingglass",
                title: viewModel.searchText.isEmpty ? "Browse" : "Search",
                value: viewModel.searchText.isEmpty ? "All" : "Active",
                color: Color(red: 0.6, green: 0.3, blue: 0.5)
            )
        }
        .padding(.vertical, 8)
    }
    
    // MARK: - Favorites Grid Section
    private var favoritesGridSection: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(viewModel.filteredFavorites, id: \.id) { city in
                FavoriteCityCard(
                    city: city,
                    onTap: { selectedCity = city },
                    onRemove: { viewModel.removeFromFavorites(city) }
                )
            }
        }
    }
}

// MARK: - Favorite Stat Card Component
struct FavoriteStatCard: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(color)
                .frame(width: 32, height: 32)
                .background(
                    Circle()
                        .fill(color.opacity(0.12))
                )
            
            VStack(spacing: 2) {
                Text(value)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(Color(red: 0.7, green: 0.15, blue: 0.35))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                
                Text(title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color(red: 0.6, green: 0.3, blue: 0.45))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color(red: 0.7, green: 0.2, blue: 0.4).opacity(0.1), radius: 8, x: 0, y: 4)
        )
    }
}

// MARK: - Favorite City Card Component
struct FavoriteCityCard: View {
    let city: City
    let onTap: () -> Void
    let onRemove: () -> Void
    @State private var showingRemoveAnimation = false
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 12) {
                // Header with country code and remove button
                HStack {
                    Text(city.countryCode)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(red: 0.8, green: 0.25, blue: 0.45))
                        )
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showingRemoveAnimation = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            onRemove()
                        }
                    }) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 14))
                            .foregroundColor(Color(red: 0.8, green: 0.2, blue: 0.4))
                            .scaleEffect(showingRemoveAnimation ? 0.1 : 1.0)
                            .opacity(showingRemoveAnimation ? 0 : 1)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                // City info
                VStack(alignment: .leading, spacing: 6) {
                    Text(city.city)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.7, green: 0.15, blue: 0.35))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    Text(city.country)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(red: 0.6, green: 0.3, blue: 0.45))
                        .lineLimit(1)
                    
                    if let population = city.population {
                        HStack {
                            Image(systemName: "person.2.fill")
                                .font(.system(size: 10))
                                .foregroundColor(Color(red: 0.8, green: 0.25, blue: 0.45))
                            
                            Text(city.populationFormatted)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(Color(red: 0.6, green: 0.3, blue: 0.45))
                        }
                    }
                }
                
                Spacer()
                
                // Coordinates
                HStack {
                    Image(systemName: "location.fill")
                        .font(.system(size: 10))
                        .foregroundColor(Color(red: 0.8, green: 0.25, blue: 0.45))
                    
                    Text(city.coordinates)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(Color(red: 0.6, green: 0.3, blue: 0.45))
                        .lineLimit(1)
                    
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .shadow(color: Color(red: 0.7, green: 0.15, blue: 0.35).opacity(0.1), radius: 8, x: 0, y: 4)
            )
            .scaleEffect(showingRemoveAnimation ? 0.95 : 1.0)
            .opacity(showingRemoveAnimation ? 0.7 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    FavoritesView(favoritesManager: FavoritesManager())
}
