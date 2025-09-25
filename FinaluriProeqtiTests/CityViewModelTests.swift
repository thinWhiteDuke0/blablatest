//
//  CityViewModelTests.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 26.09.25.
//


import XCTest
import Combine
@testable import FinaluriProeqti

@MainActor
class CityViewModelTests: XCTestCase {
    var viewModel: CityViewModel!
    var mockService: MockCityService!

    override func setUp() {
        super.setUp()
        mockService = MockCityService()
        viewModel = CityViewModel(service: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testLoadCitiesSuccess() async {
        // Given
        let mockCities = [
            City.mock(id: 1, city: "New York"),
            City.mock(id: 2, city: "London")
        ]
        mockService.mockResponse = CityResponse(
            data: mockCities,
            links: nil,
            metadata: Metadata(currentOffset: 0, totalCount: 2)
        )

        // When
        await viewModel.loadCities()

        // Then
        XCTAssertEqual(viewModel.cities.count, 2)
        XCTAssertEqual(viewModel.cities.first?.city, "New York")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testLoadCitiesError() async {
        // Given
        mockService.shouldThrowError = true

        // When
        await viewModel.loadCities()

        // Then
        XCTAssertTrue(viewModel.cities.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
    }

    func testSearchCities() async {
        // Given
        let searchResults = [City.mock(id: 1, city: "Paris")]
        mockService.searchResults = searchResults

        // When
        viewModel.searchText = "Par"

        // Wait a moment for the async search to complete
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds

        // Then
        XCTAssertEqual(viewModel.cities.count, 1)
        XCTAssertEqual(viewModel.cities.first?.city, "Paris")
    }
}
