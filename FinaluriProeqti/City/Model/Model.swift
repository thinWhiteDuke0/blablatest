//
//  CityResponse.swift
//  FinalTaskApp
//
//  Created by Giorgi Manjavidze on 24.09.25.
//


import Foundation

struct CityResponse: Codable {
    let data: [City]
    let links: [Link]?
    let metadata: Metadata
}

struct City: Codable, Identifiable, Hashable, Equatable {
    let id: Int
    let wikiDataId: String?
    let type: String
    let city: String
    let name: String
    let country: String
    let countryCode: String
    let region: String
    let regionCode: String
    let latitude: Double
    let longitude: Double
    let population: Int?


    var coordinates: String {
        return String(format: "%.4f, %.4f", latitude, longitude)
    }

    var populationFormatted: String {
        guard let population = population else { return "N/A" }

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: population)) ?? "\(population)"
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id
    }
  
}

struct Link: Codable {
    let rel: String
    let href: String
}

struct Metadata: Codable {
    let currentOffset: Int
    let totalCount: Int
}
