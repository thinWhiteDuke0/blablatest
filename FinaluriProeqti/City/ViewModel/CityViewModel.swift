//
//  CityViewModel.swift
//  FinalTaskApp
//
//  Created by Giorgi Manjavidze on 24.09.25.
//


import Foundation

@MainActor
class CityViewModel: ObservableObject {
    @Published var cities: [City] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var hasMoreData: Bool = true
    @Published var searchText: String = "" {
        didSet {
            if searchText != oldValue {
                searchTask?.cancel()
                if searchText.isEmpty {
                    resetToInitialState()
                } else {
                    searchTask = Task {
                        await searchCities()
                    }
                }
            }
        }
    }

    private let service: CityFetching
    private var currentOffset = 0
    private let pageSize = 10
    private var totalCount: Int = 0
    private var searchTask: Task<Void, Never>?

    init(service: CityFetching = CityService()) {
        self.service = service
    }

    // MARK: - Load cities
    func loadCities() async {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        do {
            let response = try await service.fetchCities(limit: pageSize, offset: 0)
            cities = response.data
            currentOffset = response.data.count
            totalCount = response.metadata.totalCount
            hasMoreData = currentOffset < totalCount
        } catch {
            handleError(error)
        }

        isLoading = false
    }

    // MARK: - Pagination
    func loadMoreCities() async {
        guard !isLoading, hasMoreData, searchText.isEmpty else { return }

        isLoading = true
        errorMessage = nil

        do {
            let response = try await service.fetchCities(limit: pageSize, offset: currentOffset)
            cities.append(contentsOf: response.data)
            currentOffset += response.data.count
            hasMoreData = currentOffset < response.metadata.totalCount
        } catch {
            handleError(error)
        }

        isLoading = false
    }

    // MARK: - Refresh
    func refreshCities() async {
        currentOffset = 0
        hasMoreData = true
        cities.removeAll()
        await loadCities()
    }

    // MARK: - Search
    private func searchCities() async {
        let trimmed = searchText.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }

        isLoading = true
        errorMessage = nil

        // Small delay for smoother UX
        try? await Task.sleep(nanoseconds: 300_000_000) // 0.3 seconds

        do {
            let searchResults = try await service.searchCities(namePrefix: trimmed)
            cities = searchResults
            hasMoreData = false // Searches are not paginated
        } catch {
            if !Task.isCancelled {
                handleError(error)
            }
        }

        isLoading = false
    }

    // MARK: - Reset state
    private func resetToInitialState() {
        searchTask?.cancel()
        currentOffset = 0
        hasMoreData = true
        cities.removeAll()
        errorMessage = nil

        Task {
            await loadCities()
        }
    }

    // MARK: - Error handling
    private func handleError(_ error: Error) {
        if let cityError = error as? CityError {
            errorMessage = cityError.errorDescription
        } else {
            errorMessage = "An unexpected error occurred: \(error.localizedDescription)"
        }

        print("CityViewModel Error: \(error)")
    }

    func clearError() {
        errorMessage = nil
    }

    func retry() async {
        if searchText.isEmpty {
            await refreshCities()
        } else {
            await searchCities()
        }
    }
}
