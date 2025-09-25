//
//  CityCard.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 25.09.25.
//

import SwiftUI

struct CityCard: View {
    let city: City
    let index: Int
    let favoritesManager: any FavoriteManaging
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 12) {
                HStack {
                    Text(city.countryCode)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(AppColors.primaryGreen)
                        )

                    Spacer()

                    FavoriteButton(
                        city: city,
                        favoritesManager: favoritesManager,
                        style: .listCard
                    )
                }

                // City info
                VStack(alignment: .leading, spacing: 6) {
                    Text(city.city)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(AppColors.primaryText)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)

                    Text(city.country)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(AppColors.secondaryText)
                        .lineLimit(1)

                    if city.population != nil {
                        HStack {
                            Image(systemName: "person.2.fill")
                                .font(.system(size: 10))
                                .foregroundColor(AppColors.primaryGreen)

                            Text(city.populationFormatted)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(AppColors.secondaryText)
                        }
                    }
                }

                Spacer()

                // Coordinates
                HStack {
                    Image(systemName: "location.fill")
                        .font(.system(size: 10))
                        .foregroundColor(AppColors.primaryGreen)

                    Text(city.coordinates)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(AppColors.secondaryText)
                        .lineLimit(1)

                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .shadow(color: AppColors.shadowColor.opacity(0.1), radius: 8, x: 0, y: 4)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
