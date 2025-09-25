//
//  ContentView.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 24.09.25.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var favoritesManager = FavoritesManager()
    @State private var selectedTab = 0

    var body: some View {

        TabView(selection: $selectedTab) {
            CityListView()
                .environmentObject(favoritesManager)
                .tabItem {
                    Image(systemName: "building.2")
                    Text("Cities")
                }
                .tag(0)

            FavoritesView(favoritesManager: favoritesManager)
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
                .tag(1)
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(2)
          }
          .tint(AppColors.accentGreen)
      }
}




#Preview {
    ContentView()
}
