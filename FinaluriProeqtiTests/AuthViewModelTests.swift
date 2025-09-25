//
//  LoginViewModelTests.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 26.09.25.
//


import XCTest
@testable import FinaluriProeqti

//
//  AuthViewModelTests.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 26.09.25.
//

import XCTest
@testable import FinaluriProeqti



@MainActor
class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!

    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testInitialState() {
        // Then
        XCTAssertTrue(viewModel.email.isEmpty)
        XCTAssertTrue(viewModel.password.isEmpty)
    }

    func testEmailPasswordBinding() {
        // When
        viewModel.email = "test@example.com"
        viewModel.password = "password123"

        // Then
        XCTAssertEqual(viewModel.email, "test@example.com")
        XCTAssertEqual(viewModel.password, "password123")
    }
}

// MARK: - RegistrationViewModel Tests

@MainActor
class RegistrationViewModelTests: XCTestCase {
    var viewModel: RegistrationViewModel!

    override func setUp() {
        super.setUp()
        viewModel = RegistrationViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testInitialState() {
        // Then
        XCTAssertTrue(viewModel.email.isEmpty)
        XCTAssertTrue(viewModel.password.isEmpty)
        XCTAssertTrue(viewModel.fullname.isEmpty)
        XCTAssertTrue(viewModel.username.isEmpty)
    }

    func testFieldsBinding() {
        // When
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        viewModel.fullname = "Test User"
        viewModel.username = "testuser"

        // Then
        XCTAssertEqual(viewModel.email, "test@example.com")
        XCTAssertEqual(viewModel.password, "password123")
        XCTAssertEqual(viewModel.fullname, "Test User")
        XCTAssertEqual(viewModel.username, "testuser")
    }
}
