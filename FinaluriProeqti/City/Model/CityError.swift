//
//  CityError.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 24.09.25.
//


import Foundation

enum CityError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case networkError(Error)
    case invalidResponse
    case apiKeyMissing
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL provided"
        case .noData:
            return "No data received from server"
        case .decodingError:
            return "Failed to decode response data"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid response from server"
        case .apiKeyMissing:
            return "API key is missing or invalid"
        }
    }
}
