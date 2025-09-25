//
//  CityService.swift
//  FinalTaskApp
//
//  Created by Giorgi Manjavidze on 24.09.25.
//

//
//  CityError.swift
//  FinalTaskApp
//
//  Created by Giorgi Manjavidze on 24.09.25.
//


import Foundation

protocol CityFetching {
    func fetchCities() async throws -> [City]
    func fetchCities(limit: Int, offset: Int) async throws -> CityResponse
    func searchCities(namePrefix: String) async throws -> [City]
}

class CityService: CityFetching {
    private let apiKey = "8ab63fa88fmsh0adf8cf46068b7cp10bfd4jsna2003c4d9b16"
    private let baseURL = "https://wft-geo-db.p.rapidapi.com/v1/geo/cities"

    func fetchCities() async throws -> [City] {
        return try await fetchCities(limit: 10, offset: 0).data
    }

    func fetchCities(limit: Int, offset: Int) async throws -> CityResponse {
        guard let url = URL(string: "\(baseURL)?limit=\(limit)&offset=\(offset)") else {
            throw CityError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
        request.setValue("wft-geo-db.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.timeoutInterval = 30.0

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw CityError.invalidResponse
            }

            guard 200...299 ~= httpResponse.statusCode else {
                if httpResponse.statusCode == 401 {
                    throw CityError.apiKeyMissing
                }
                throw CityError.networkError(URLError(.badServerResponse))
            }

            guard !data.isEmpty else {
                throw CityError.noData
            }

            let decoder = JSONDecoder()
            let cityResponse = try decoder.decode(CityResponse.self, from: data)
            return cityResponse

        } catch let error as CityError {
            throw error
        } catch is DecodingError {
            throw CityError.decodingError
        } catch {
            throw CityError.networkError(error)
        }
    }

    func searchCities(namePrefix: String) async throws -> [City] {
        let trimmedPrefix = namePrefix.trimmingCharacters(in: .whitespaces)
        guard !trimmedPrefix.isEmpty else {
            return []
        }

        let encodedPrefix = trimmedPrefix.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "\(baseURL)?namePrefix=\(encodedPrefix)&limit=50") else {
            throw CityError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
        request.setValue("wft-geo-db.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.timeoutInterval = 30.0

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw CityError.invalidResponse
            }

            guard 200...299 ~= httpResponse.statusCode else {
                if httpResponse.statusCode == 401 {
                    throw CityError.apiKeyMissing
                }
                throw CityError.networkError(URLError(.badServerResponse))
            }

            let decoder = JSONDecoder()
            let cityResponse = try decoder.decode(CityResponse.self, from: data)
            return cityResponse.data

        } catch let error as CityError {
            throw error
        } catch is DecodingError {
            throw CityError.decodingError
        } catch {
            throw CityError.networkError(error)
        }
    }
}
