//
//  FirstScreen.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 25.09.25.
//

import SwiftUI

struct FirstScreen: View {

  @StateObject var routeLogic = RouteLogic()

  var body: some View {

    Group {
      if routeLogic.userSession != nil {
        ContentView()
      } else {
        LoginView()
      }
    }

  }
}
