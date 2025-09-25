//
//  LocalizationKey.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 25.09.25.
//


//
//  LocalizationHelper.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 25.09.25.
//

import Foundation

// MARK: - String Extension for Localization
extension String {
    /// Returns the localized version of the string
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    /// Returns the localized version of the string with formatting arguments
    func localized(with arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
}

// MARK: - Localization Keys
struct LocalizationKey {
    // App & Branding
    static let appTitle = "app_title"
    static let appSubtitle = "app_subtitle"
    
    // Authentication
    static let loginTitle = "login_title"
    static let createAccountTitle = "create_account_title"
    static let joinCommunity = "join_community"
    static let emailPlaceholder = "email_placeholder"
    static let passwordPlaceholder = "password_placeholder"
    static let fullnamePlaceholder = "fullname_placeholder"
    static let usernamePlaceholder = "username_placeholder"
    static let forgotPassword = "forgot_password"
    static let loginButton = "login_button"
    static let signupButton = "signup_button"
    static let dontHaveAccount = "dont_have_account"
    static let alreadyHaveAccount = "already_have_account"
    static let signIn = "sign_in"
    
    // Profile
    static let profileTitle = "profile_title"
    static let editPhoto = "edit_photo"
    static let about = "about"
    static let signOut = "sign_out"
    static let signOutAlertTitle = "sign_out_alert_title"
    static let signOutAlertMessage = "sign_out_alert_message"
    static let cancel = "cancel"
    static let loading = "loading"
    
    // Cities List
    static let citiesInfo = "cities_info"
    static let citiesLoaded = "cities_loaded"
    static let searchCitiesPlaceholder = "search_cities_placeholder"
    static let exploreWorldCities = "explore_world_cities"
    static let cities = "cities"
    static let featured = "featured"
    static let browse = "browse"
    static let search = "search"
    static let global = "global"
    static let active = "active"
    static let loadingMoreCities = "loading_more_cities"
    static let exploringWorld = "exploring_world"
    
    // Empty States
    static let noCitiesFound = "no_cities_found"
    static let unableToLoadCities = "unable_to_load_cities"
    static let retry = "retry"
    static let noResults = "no_results"
    static let noCitiesMatch = "no_cities_match"
    
    // City Details
    static let cityOverview = "city_overview"
    static let locationDetails = "location_details"
    static let fullName = "full_name"
    static let countryCode = "country_code"
    static let region = "region"
    static let coordinates = "coordinates"
    static let populationCount = "population_count"
    static let population = "population"
    static let country = "country"
    static let explore = "explore"
    static let discoverCity = "discover_city"
    static let findAmazingPlaces = "find_amazing_places"
    static let favorites = "favorites"
    static let saveCity = "save_city"
    static let keepTrackCities = "keep_track_cities"
    static let viewOnMap = "view_on_map"
    static let done = "done"
    
    // Favorites
    static let myFavorites = "my_favorites"
    static let favoriteCities = "favorite_cities"
    static let searchFavoritesPlaceholder = "search_favorites_placeholder"
    static let noFavoritesYet = "no_favorites_yet"
    static let startExploringCities = "start_exploring_cities"
    static let clearAllFavorites = "clear_all_favorites"
    static let clearAllFavoritesMessage = "clear_all_favorites_message"
    static let clearAll = "clear_all"
    static let recent = "recent"
    static let all = "all"
    
    // Stats & Numbers
    static let citiesCount = "cities_count"
    static let populationFormatMillions = "population_format_millions"
    static let populationFormatThousands = "population_format_thousands"
    static let notAvailable = "not_available"
    
    // Common Actions
    static let edit = "edit"
    static let save = "save"
    static let delete = "delete"
    static let share = "share"
    static let close = "close"
}

