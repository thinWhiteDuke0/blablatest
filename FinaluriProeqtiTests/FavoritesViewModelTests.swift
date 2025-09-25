//
//  FavoritesViewModelTests.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 26.09.25.
//


import XCTest
@testable import FinaluriProeqti

@MainActor
class FavoritesViewModelTests: XCTestCase {
    var viewModel: FavoritesViewModel!
    var favoritesManager: FavoritesManager!
    var mockStorage: MockFavoritesStorage!
    
    override func setUp() {
        super.setUp()
        mockStorage = MockFavoritesStorage()
        favoritesManager = FavoritesManager(storage: mockStorage)
        viewModel = FavoritesViewModel(favoritesManager: favoritesManager)
    }
    
    override func tearDown() {
        viewModel = nil
        favoritesManager = nil
        mockStorage = nil
        super.tearDown()
    }
    
    func testFilteredFavoritesEmpty() {
        // Given - No favorites
        
        // When
        let filtered = viewModel.filteredFavorites
        
        // Then
        XCTAssertTrue(filtered.isEmpty)
        XCTAssertTrue(viewModel.isEmpty)
    }
    
    func testFilteredFavoritesWithSearch() {
        // Given
        let cities = [
            City.mock(id: 1, city: "Paris", country: "France"),
            City.mock(id: 2, city: "London", country: "UK"),
            City.mock(id: 3, city: "Berlin", country: "Germany")
        ]
        cities.forEach { favoritesManager.addToFavorites($0) }
        
        // When
        viewModel.searchText = "par"
        let filtered = viewModel.filteredFavorites
        
        // Then
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered.first?.city, "Paris")
    }
    
    func testFilteredFavoritesNoSearch() {
        // Given
        let cities = [
            City.mock(id: 1, city: "Zurich"),
            City.mock(id: 2, city: "Amsterdam")
        ]
        cities.forEach { favoritesManager.addToFavorites($0) }
        
        // When
        let filtered = viewModel.filteredFavorites
        
        // Then
        XCTAssertEqual(filtered.count, 2)
        // Should be sorted alphabetically
        XCTAssertEqual(filtered.first?.city, "Amsterdam")
        XCTAssertEqual(filtered.last?.city, "Zurich")
    }
    
    func testRemoveFromFavorites() {
        // Given
        let city = City.mock(city: "Vienna")
        favoritesManager.addToFavorites(city)
        
        // When
        viewModel.removeFromFavorites(city)
        
        // Then
        XCTAssertFalse(favoritesManager.isFavorite(city))
        XCTAssertTrue(viewModel.isEmpty)
    }
    
    func testClearAllFavorites() {
        // Given
        let cities = [City.mock(id: 1), City.mock(id: 2)]
        cities.forEach { favoritesManager.addToFavorites($0) }
        
        // When
        viewModel.clearAllFavorites()
        
        // Then
        XCTAssertTrue(viewModel.isEmpty)
        XCTAssertTrue(viewModel.filteredFavorites.isEmpty)
    }
}
