//
//  CityMapView.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 24.09.25.
//
//
//  CityMapView.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 24.09.25.
//

import SwiftUI
import MapKit

struct CityMapView: View {
    let city: City
    @Environment(\.dismiss) private var dismiss
    @State private var region: MKCoordinateRegion

    init(city: City) {
        self.city = city
        self._region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: city.latitude,
                longitude: city.longitude
            ),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }

    var body: some View {
        NavigationView {
            Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: [city]) { city in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: city.latitude, longitude: city.longitude)) {
                    VStack {
                        // Custom pin
                        ZStack {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 30, height: 30)
                                .shadow(radius: 3)

                            Image(systemName: "location.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .bold))
                        }

                        // City name
                        Text(city.city)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                    }
                }
            }
            .navigationTitle(city.city)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                  Button(LocalizationKey.done) {
                        dismiss()
                    }
                }
            }
        }
    }
}
