//
//  ProfileServiceTests.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 26.09.25.
//


import XCTest
@testable import FinaluriProeqti

class ProfileServiceTests: XCTestCase {
    var profileService: ProfileService!
    var mockStorage: MockProfileStorage!

    override func setUp() {
        super.setUp()
        mockStorage = MockProfileStorage()
        profileService = ProfileService(storage: mockStorage)
    }

    override func tearDown() {
        profileService = nil
        mockStorage = nil
        super.tearDown()
    }

    func testSaveAndLoadDescription() {
        // Given
        let userId = "test-user-123"
        let description = "This is a test description"

        // When
        profileService.saveDescription(description, for: userId)
        let loadedDescription = profileService.loadDescription(for: userId)

        // Then
        XCTAssertEqual(loadedDescription, description)
    }

    func testLoadNonexistentDescription() {
        // Given
        let userId = "nonexistent-user"

        // When
        let description = profileService.loadDescription(for: userId)

        // Then
        XCTAssertEqual(description, "Bio is empty")
    }

    func testOverwriteDescription() {
        // Given
        let userId = "test-user-456"
        profileService.saveDescription("Old description", for: userId)

        // When
        profileService.saveDescription("New description", for: userId)
        let description = profileService.loadDescription(for: userId)

        // Then
        XCTAssertEqual(description, "New description")
    }

    func testEmptyDescription() {
        // Given
        let userId = "test-user-empty"

        // When
        profileService.saveDescription("", for: userId)
        let description = profileService.loadDescription(for: userId)

        // Then
        XCTAssertEqual(description, "")
    }
}
