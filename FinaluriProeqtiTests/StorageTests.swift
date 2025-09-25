//
//  UserDefaultsFavoritesStorageTests.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 26.09.25.
//


import XCTest
@testable import FinaluriProeqti

// MARK: - UserDefaultsFavoritesStorage Tests

class UserDefaultsFavoritesStorageTests: XCTestCase {
    var storage: UserDefaultsFavoritesStorage!
    private let testKey = "favorite_cities"

    override func setUp() {
        super.setUp()
        storage = UserDefaultsFavoritesStorage()
        UserDefaults.standard.removeObject(forKey: testKey)
    }

    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: testKey)
        storage = nil
        super.tearDown()
    }

    func testSaveAndLoadFavorites() {
        // Given
        let cities = Set([
            City.mock(id: 1, city: "Paris"),
            City.mock(id: 2, city: "London")
        ])

        // When
        storage.saveFavorites(cities)
        let loadedCities = storage.loadFavorites()

        // Then
        XCTAssertEqual(loadedCities.count, 2)
        XCTAssertTrue(loadedCities.contains(City.mock(id: 1, city: "Paris")))
        XCTAssertTrue(loadedCities.contains(City.mock(id: 2, city: "London")))
    }

    func testLoadEmptyFavorites() {
        // When
        let loadedCities = storage.loadFavorites()

        // Then
        XCTAssertTrue(loadedCities.isEmpty)
    }

    func testOverwriteFavorites() {
        // Given
        let initialCities = Set([City.mock(id: 1, city: "Berlin")])
        let newCities = Set([City.mock(id: 2, city: "Madrid")])

        // When
        storage.saveFavorites(initialCities)
        storage.saveFavorites(newCities)
        let loadedCities = storage.loadFavorites()

        // Then
        XCTAssertEqual(loadedCities.count, 1)
        XCTAssertTrue(loadedCities.contains(City.mock(id: 2, city: "Madrid")))
        XCTAssertFalse(loadedCities.contains(City.mock(id: 1, city: "Berlin")))
    }
}

// MARK: - UserDefaultsProfileStorage Tests

class UserDefaultsProfileStorageTests: XCTestCase {
    var storage: UserDefaultsProfileStorage!

    override func setUp() {
        super.setUp()
        storage = UserDefaultsProfileStorage()
    }

    override func tearDown() {
        let keys = UserDefaults.standard.dictionaryRepresentation().keys
        keys.filter { $0.hasPrefix("user_description_test_") }
            .forEach { UserDefaults.standard.removeObject(forKey: $0) }
        storage = nil
        super.tearDown()
    }

    func testSaveAndLoadDescription() {
        // Given
        let userId = "test_user_123"
        let description = "Test user description"

        // When
        storage.saveUserDescription(description, for: userId)
        let loadedDescription = storage.loadUserDescription(for: userId)

        // Then
        XCTAssertEqual(loadedDescription, description)
    }

    func testLoadNonexistentDescription() {
        // Given
        let userId = "nonexistent_user"

        // When
        let description = storage.loadUserDescription(for: userId)

        // Then
        XCTAssertNil(description)
    }

    func testOverwriteDescription() {
        // Given
        let userId = "test_user_overwrite"

        // When
        storage.saveUserDescription("First description", for: userId)
        storage.saveUserDescription("Second description", for: userId)
        let description = storage.loadUserDescription(for: userId)

        // Then
        XCTAssertEqual(description, "Second description")
    }
}
