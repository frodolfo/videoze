//
//  ContentView.swift
//  Videoze
//
//  Created by Rodolfo, Fred (US) on 10/7/22.
//

import SwiftUI
import GoogleSignIn

struct ContentView: View {
  @EnvironmentObject var authViewModel: AuthenticationViewModel

  var body: some View {
    return Group {
      NavigationView {
        switch authViewModel.state {
        case .signedIn:
          VideoPlayerView()
            .navigationTitle(
              NSLocalizedString(
                "Videoze Player",
                comment: "Remote Video Player"
              ))
        case .signedOut:
          SignInView()
            .navigationTitle(
              NSLocalizedString(
                "Sign-in with Google",
                comment: "Sign-in navigation title"
              ))
        }
      }
      .navigationViewStyle(StackNavigationViewStyle())
    }
  }
}
