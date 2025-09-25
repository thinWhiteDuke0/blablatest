//
//  CityTests.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 26.09.25.
//



import XCTest
@testable import FinaluriProeqti

// MARK: - City Model Tests

class CityTests: XCTestCase {

    func testCityEquality() {
        // Given
        let city1 = City.mock(id: 1, city: "Paris")
        let city2 = City.mock(id: 1, city: "Paris")
        let city3 = City.mock(id: 2, city: "London")

        // Then
        XCTAssertEqual(city1, city2)
        XCTAssertNotEqual(city1, city3)
    }

    func testCityHashing() {
        // Given
        let city1 = City.mock(id: 1, city: "Tokyo")
        let city2 = City.mock(id: 1, city: "Tokyo")

        // When
        let set = Set([city1, city2])

        // Then
        XCTAssertEqual(set.count, 1) // Should only contain one city due to equality
    }

    func testCityWithNilPopulation() {
        // Given
        let city = City.mock(population: nil)

        // Then
        XCTAssertNil(city.population)
        XCTAssertEqual(city.city, "Test City")
    }

    func testCityInitialization() {
        // Given
        let city = City.mock(
            id: 123,
            city: "New York",
            country: "USA",
            population: 8000000
        )

        // Then
        XCTAssertEqual(city.id, 123)
        XCTAssertEqual(city.city, "New York")
        XCTAssertEqual(city.country, "USA")
        XCTAssertEqual(city.population, 8000000)
    }
}
