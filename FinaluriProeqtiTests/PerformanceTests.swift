//
//  PerformanceTests.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 26.09.25.
//



import XCTest
@testable import FinaluriProeqti

// MARK: - Performance Tests

class PerformanceTests: XCTestCase {

    @MainActor
    func testFavoritesManagerPerformance() {
        let storage = MockFavoritesStorage()
        let manager = FavoritesManager(storage: storage)

        let cities = (1...1000).map { City.mock(id: $0, city: "City \($0)") }

        measure {
            for city in cities {
                manager.addToFavorites(city)
            }
        }
    }

    func testCitySearchPerformance() {
        let cities = (1...10000).map {
            City.mock(id: $0, city: "City \($0)", country: "Country \($0 % 100)")
        }

        measure {
            let filtered = cities.filter { city in
                city.city.localizedCaseInsensitiveContains("City 1") ||
                city.country.localizedCaseInsensitiveContains("Country 1")
            }
            _ = filtered.count
        }
    }

    func testCitySetOperationsPerformance() {
        let cities = (1...5000).map { City.mock(id: $0, city: "City \($0)") }

        measure {
            let citySet = Set(cities)
            let testCity = City.mock(id: 2500, city: "City 2500")
            _ = citySet.contains(testCity)
        }
    }
}
