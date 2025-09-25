//
//  ProfileViewModelTests.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 26.09.25.
//



import XCTest
import Combine
@testable import FinaluriProeqti

@MainActor
class ProfileViewModelTests: XCTestCase {
    var viewModel: ProfileViewModel!
    var mockProfileService: ProfileService!
    var mockStorage: MockProfileStorage!

    override func setUp() {
        super.setUp()
        mockStorage = MockProfileStorage()
        mockProfileService = ProfileService(storage: mockStorage)
    }

    override func tearDown() {
        viewModel = nil
        mockProfileService = nil
        mockStorage = nil
        super.tearDown()
    }

    func testInitialState() async {
        // Given - Create viewModel
        viewModel = ProfileViewModel(profileService: mockProfileService)

        try? await Task.sleep(nanoseconds: 10_000_000) 

        // Then - Test the state after initialization

        XCTAssertTrue(viewModel.userDescription == "Bio is empty" ||
                     viewModel.userDescription.isEmpty ||
                     viewModel.userDescription.hasPrefix("Bio"))
    }

    func testSaveDescription() {
        // Given
        let user = User.mock()
        viewModel.currentUser = user
        viewModel.userDescription = "Test bio"

        // When
        viewModel.saveDescription()

        // Then
        let savedDescription = mockProfileService.loadDescription(for: user.id)
        XCTAssertEqual(savedDescription, "Test bio")
    }

    func testSaveDescriptionWithoutUser() {
        // Given
        viewModel.currentUser = nil
        viewModel.userDescription = "Test bio"

        // When
        viewModel.saveDescription()

        // Then - Should not crash and description should remain
        XCTAssertEqual(viewModel.userDescription, "Test bio")
    }

    func testSaveDescriptionUpdatesStorage() {
        // Given
        let user = User.mock(id: "test-save-123")
        viewModel.currentUser = user

        // When
        viewModel.userDescription = "Updated bio"
        viewModel.saveDescription()

        // Then
        XCTAssertEqual(mockStorage.loadUserDescription(for: "test-save-123"), "Updated bio")
    }

    func testDescriptionBinding() {
        // Given
        let user = User.mock()
        viewModel.currentUser = user

        // When
        viewModel.userDescription = "New description"

        // Then
        XCTAssertEqual(viewModel.userDescription, "New description")
    }
}
