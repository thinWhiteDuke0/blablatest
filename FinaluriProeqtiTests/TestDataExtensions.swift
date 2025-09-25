//
//  TestDataExtensions.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 26.09.25.
//

import XCTest
@testable import FinaluriProeqti

extension City {
    static func mock(
        id: Int = 1,
        wikiDataId: String? = nil,
        type: String = "CITY",
        city: String = "Test City",
        name: String = "Test City",
        country: String = "Test Country",
        countryCode: String = "TC",
        region: String = "Test Region",
        regionCode: String = "TR",
        latitude: Double = 0.0,
        longitude: Double = 0.0,
        population: Int? = 100000
    ) -> City {
        return City(
            id: id,
            wikiDataId: wikiDataId,
            type: type,
            city: city,
            name: name,
            country: country,
            countryCode: countryCode,
            region: region,
            regionCode: regionCode,
            latitude: latitude,
            longitude: longitude,
            population: population
        )
    }
}

extension User {
    static func mock(
        id: String = "test-user-id",
        fullname: String = "Test User",
        email: String = "test@example.com",
        username: String = "testuser",
        profileImageUrl: String? = nil,
        bio: String? = nil
    ) -> User {
        return User(
            id: id,
            fullname: fullname,
            email: email,
            username: username,
            profileImageUrl: profileImageUrl,
            bio: bio
        )
    }
}

// MARK: - Mock CityResponse with correct Metadata
extension CityResponse {
    static func mock(
        cities: [City] = [City.mock()],
        totalCount: Int? = nil
    ) -> CityResponse {
        let count = totalCount ?? cities.count
        return CityResponse(
            data: cities,
            links: nil,
            metadata: Metadata(currentOffset: 0, totalCount: count)
        )
    }
}

// MARK: - Additional Mock Extensions for Testing
extension Metadata {
    static func mock(
        currentOffset: Int = 0,
        totalCount: Int = 100
    ) -> Metadata {
        return Metadata(
            currentOffset: currentOffset,
            totalCount: totalCount
        )
    }
}
