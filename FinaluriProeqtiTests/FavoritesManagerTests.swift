//
//  FavoritesManagerTests.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 26.09.25.
//



import XCTest
@testable import FinaluriProeqti

@MainActor
class FavoritesManagerTests: XCTestCase {
    var favoritesManager: FavoritesManager!
    var mockStorage: MockFavoritesStorage!

    override func setUp() {
        super.setUp()
        mockStorage = MockFavoritesStorage()
        favoritesManager = FavoritesManager(storage: mockStorage)
    }

    override func tearDown() {
        favoritesManager = nil
        mockStorage = nil
        super.tearDown()
    }

    func testAddToFavorites() {
        // Given
        let city = City.mock(city: "Paris")

        // When
        favoritesManager.addToFavorites(city)

        // Then
        XCTAssertTrue(favoritesManager.isFavorite(city))
        XCTAssertEqual(favoritesManager.favoriteCities.count, 1)
    }

    func testRemoveFromFavorites() {
        // Given
        let city = City.mock(city: "London")
        favoritesManager.addToFavorites(city)

        // When
        favoritesManager.removeFromFavorites(city)

        // Then
        XCTAssertFalse(favoritesManager.isFavorite(city))
        XCTAssertEqual(favoritesManager.favoriteCities.count, 0)
    }

    func testToggleFavorite() {
        // Given
        let city = City.mock(city: "Tokyo")

        // When - Add
        favoritesManager.toggleFavorite(city)

        // Then
        XCTAssertTrue(favoritesManager.isFavorite(city))

        // When - Remove
        favoritesManager.toggleFavorite(city)

        // Then
        XCTAssertFalse(favoritesManager.isFavorite(city))
    }

    func testClearAllFavorites() {
        // Given
        let cities = [
            City.mock(id: 1, city: "City1"),
            City.mock(id: 2, city: "City2")
        ]
        cities.forEach { favoritesManager.addToFavorites($0) }

        // When
        favoritesManager.clearAllFavorites()

        // Then
        XCTAssertTrue(favoritesManager.favoriteCities.isEmpty)
    }

    func testPersistence() {
        // Given
        let city = City.mock(city: "Berlin")
        favoritesManager.addToFavorites(city)

        // When - Create new manager with same storage
        let newManager = FavoritesManager(storage: mockStorage)

        // Then
        XCTAssertTrue(newManager.isFavorite(city))
    }
}
