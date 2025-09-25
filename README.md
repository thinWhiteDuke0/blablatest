# WorldCities 🌍🏙️

A modern iOS application built with SwiftUI that allows users to explore cities around the world, save favorites, and view detailed information with interactive maps.

## Features

### 🏙️ City Exploration
- Browse cities from around the world with beautiful card-based UI
- Search cities by name with real-time filtering
- Infinite scroll pagination for seamless browsing
- Detailed city information including population, coordinates, and regional data

### ⭐ Favorites Management
- Save cities to favorites from both list and detail views
- Persistent storage using UserDefaults
- Search and filter favorite cities
- Easy removal and bulk clear functionality

### 👤 User Profile
- Firebase Authentication integration
- Editable user bio/description with local storage
- Profile photo placeholder with modern design
- Secure sign-in/sign-out functionality

### 🗺️ Interactive Maps
- Native MapKit integration showing city locations
- Full-screen map view with city markers
- Coordinate display with precise location data

### 🎨 Modern Design
- Beautiful glassmorphic design with gradients
- Consistent color scheme and typography
- Smooth animations and transitions
- Dark/light theme considerations

### 🌐 Internationalization
- Multi-language support (English + Georgian)
- Localized strings for all user-facing text
- Cultural-appropriate formatting

### 📱 Device Support
- iPhone only support
- Portrait orientation by default
- Landscape support on map view
- iOS 17.0+ deployment target

## Architecture

### MVVM Pattern
The app follows the Model-View-ViewModel architecture pattern:

- **Models**: `City`, `User`, `CityResponse`
- **Views**: SwiftUI views for each screen
- **ViewModels**: Observable objects managing business logic
- **Services**: API and data management layers

### Key Components

#### Services Layer
- **CityService**: Handles API communication with RapidAPI GeoDB
- **AuthService**: Firebase Authentication integration
- **UserService**: User data management
- **ProfileService**: User profile data persistence

#### Data Management
- **FavoritesManager**: Protocol-based favorites management
- **UserDefaultsStorage**: Local data persistence
- **Repository Pattern**: Clean separation of data sources

#### Dependency Injection
- Protocol-based design for testability
- Injectable storage and service dependencies
- Clean separation of concerns

## Project Structure

```
FinaluriProeqti/
├── Services/
│   ├── CityService.swift
│   ├── AuthService.swift
│   ├── UserService.swift
│   └── ProfileService.swift
├── Views/
│   ├── Authentication/
│   │   ├── LoginView.swift
│   │   └── RegistrationView.swift
│   ├── Cities/
│   │   ├── CityListView.swift
│   │   ├── CityDetailView.swift
│   │   └── CityMapView.swift
│   ├── Profile/
│   │   └── ProfileView.swift
│   └── Components/
├── ViewModels/
│   ├── CityViewModel.swift
│   ├── ProfileViewModel.swift
│   ├── LoginViewModel.swift
│   └── RegistrationViewModel.swift
├── Models/
│   ├── City.swift
│   ├── User.swift
│   └── CityError.swift
├── Managers/
│   ├── FavoritesManager.swift
│   └── RouteLogic.swift
└── Storage/
    ├── UserDefaultsFavoritesStorage.swift
    └── UserDefaultsProfileStorage.swift
```

## API Integration

The app integrates with the **GeoDB Cities API** via RapidAPI:

### Endpoints Used
- `GET /v1/geo/cities` - Fetch cities with pagination
- `GET /v1/geo/cities?namePrefix=` - Search cities by name

### Features
- Pagination support (10 cities per page)
- Search functionality with prefix matching
- Error handling with custom error types
- Network request timeout and retry logic

## Firebase Integration

### Authentication
- Email/password authentication
- User session management
- Automatic state synchronization

### Firestore
- User profile storage
- Real-time data synchronization
- Secure user data management

## Storage Solutions

### Local Storage
- **UserDefaults**: Favorites and profile data
- **Protocol-based**: Easy testing and swapping
- **Codable**: Type-safe serialization

### Cloud Storage
- **Firestore**: User profiles and authentication
- **Real-time sync**: Automatic data updates

## Key Technical Decisions

### 1. Protocol-Oriented Programming
```swift
protocol FavoriteManaging: ObservableObject {
    var favoriteCities: Set<City> { get }
    func isFavorite(_ city: City) -> Bool
    func toggleFavorite(_ city: City)
}
```

### 2. Async/Await Pattern
```swift
@MainActor
func loadCities() async {
    do {
        let response = try await service.fetchCities(limit: pageSize, offset: 0)
        cities = response.data
    } catch {
        handleError(error)
    }
}
```

### 3. Combine Framework
```swift
private func setupSubscribers() {
    UserService.shared.$currentUser
        .sink { [weak self] user in
            self?.currentUser = user
        }
        .store(in: &cancellables)
}
```

## Requirements Fulfilled

### ✅ API Integration
- RapidAPI GeoDB Cities integration
- Pagination support
- Search functionality

### ✅ Navigation
- List to detail navigation
- Tab-based navigation
- Modal presentations

### ✅ Loading States
- Network request indicators
- Pagination loading
- Pull-to-refresh

### ✅ Favorites System
- Add/remove from list and detail views
- UserDefaults persistence
- Search favorites

### ✅ Profile Management
- User authentication
- Editable bio
- Profile image placeholder

### ✅ Map Integration
- Native MapKit usage
- City location display
- Interactive map controls

### ✅ Localization
- English and Georgian support
- Localized strings
- Cultural formatting

### ✅ Device Support
- iPhone only
- Portrait mode default
- Landscape map view

## Installation & Setup

### Prerequisites
- Xcode 15.0+
- iOS 17.0+
- Firebase project setup
- RapidAPI account and key

### Setup Steps

1. **Clone the repository**
```bash
git clone git@git.epam.com:giorgi_manjavidze/finalapp.git
cd finalapp
```

2. **Firebase Configuration**
   - Add `GoogleService-Info.plist` to the project
   - Configure Firebase Authentication
   - Set up Firestore database

3. **API Configuration**
   - Add your RapidAPI key in `CityService.swift`
   - Update API endpoints if needed

4. **Build and Run**
   - Open `FinaluriProeqti.xcodeproj`
   - Select target device
   - Build and run (⌘+R)

## Testing

The project includes comprehensive unit tests covering:

- **Service Layer**: API communication and error handling
- **Business Logic**: Favorites management and user operations
- **Data Persistence**: Storage protocols and implementations
- **ViewModels**: State management and user interactions

### Running Tests
```bash
# Run all tests
⌘+U in Xcode

# Or via command line
xcodebuild test -project FinaluriProeqti.xcodeproj -scheme FinaluriProeqti
```

## Code Quality

### Standards Applied
- No compiler warnings or errors
- Consistent code formatting and style
- No debug print statements in production
- Proper error handling throughout
- Memory management best practices

### SwiftLint Integration
The project follows Swift style guidelines and can be enhanced with SwiftLint for automated code quality checks.

## Performance Optimizations

- **Lazy Loading**: Cities loaded on demand
- **Image Caching**: Efficient image loading and caching
- **Memory Management**: Proper use of weak references
- **Network Optimization**: Request batching and error retry

## Security Considerations

- **API Keys**: Secured and not exposed in repository
- **Firebase Rules**: Proper security rules for Firestore
- **User Data**: Encrypted local storage where applicable
- **Network Security**: HTTPS-only communication

## Future Enhancements

- [ ] Offline support with Core Data
- [ ] Push notifications for favorite cities
- [ ] Weather integration
- [ ] Social sharing features
- [ ] Advanced filtering and sorting
- [ ] City comparison tools
- [ ] Travel planning features

## Contributing

This project was developed as part of an iOS development assessment. For contributions or questions, please follow the established code style and testing practices.

## License

This project is for educational and assessment purposes. All rights reserved.

---

**Developer**: Giorgi Manjavidze  
**Email**: Giorgi_manjavidze@epam.com  
**Project**: Final iOS Assessment - WorldCities App  
**Technology Stack**: SwiftUI, Firebase, MapKit, Combine, URLSession