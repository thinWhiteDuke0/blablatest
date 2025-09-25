//
//  MockCityService.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 26.09.25.
//


import XCTest
import Firebase
import FirebaseAuth
import FirebaseFirestore
import Combine
@testable import FinaluriProeqti

class MockCityService: CityFetching {
    var shouldThrowError = false
    var mockCities: [City] = []
    var mockResponse: CityResponse?
    var searchResults: [City] = []

    func fetchCities() async throws -> [City] {
        if shouldThrowError {
            throw CityError.networkError(URLError(.badServerResponse))
        }
        return mockCities
    }

    func fetchCities(limit: Int, offset: Int) async throws -> CityResponse {
        if shouldThrowError {
            throw CityError.networkError(URLError(.badServerResponse))
        }
        return mockResponse ?? CityResponse(
            data: mockCities,
            links: nil,
            metadata: Metadata(currentOffset: offset, totalCount: mockCities.count)
        )
    }

    func searchCities(namePrefix: String) async throws -> [City] {
        if shouldThrowError {
            throw CityError.networkError(URLError(.badServerResponse))
        }
        return searchResults.filter { $0.city.lowercased().hasPrefix(namePrefix.lowercased()) }
    }
}

class MockFavoritesStorage: FavoritesStoraging {
    private var storage: Set<City> = []

    func saveFavorites(_ favorites: Set<City>) {
        storage = favorites
    }

    func loadFavorites() -> Set<City> {
        return storage
    }
}

class MockProfileStorage: UserProfileStoraging {
    private var descriptions: [String: String] = [:]

    func saveUserDescription(_ description: String, for userId: String) {
        descriptions[userId] = description
    }

    func loadUserDescription(for userId: String) -> String? {
        return descriptions[userId]
    }
}
