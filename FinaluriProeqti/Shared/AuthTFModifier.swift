//
//  Modifier.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 24.09.25.
//

import SwiftUI

struct AuthTFModifier: ViewModifier{
  func body(content: Content) -> some View {
    content
      .font(.subheadline)
      .padding(12)
      .background(Color(.systemGray6))
      .cornerRadius(10)
      .padding(.horizontal, 24)
  }
}

struct PrettyTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .medium))
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.white)
                    .shadow(color: AppColors.cardShadow.opacity(0.1), radius: 8, x: 0, y: 4)
            )
    }
}
