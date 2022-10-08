//
//  VideoPlayerView.swift
//  Videoze
//
//  Created by Rodolfo, Fred (US) on 10/8/22.
//

import SwiftUI
import GoogleSignIn
import AVKit

struct VideoPlayerView: View {
    @State var player = AVPlayer(url: URL(string: "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8")!)
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  private var user: GIDGoogleUser? {
    return GIDSignIn.sharedInstance.currentUser
  }

  var body: some View {
    return Group {
      if let userProfile = user?.profile {
        VStack(spacing: 10) {
          HStack(alignment: .top) {
            UserProfileImageView(userProfile: userProfile)
              .padding(.leading)
            VStack(alignment: .leading) {
              Text(userProfile.name)
                .font(.headline)
              Text(userProfile.email)
            }
          }
            VideoPlayer(player: player, videoOverlay: {
                       VStack(alignment: .leading) {
                           Text("Big Buck Bunny")
                               .foregroundColor(Color.gray)
                               .bold()
                               .font(Font.title2)
                               .padding(.all, 10)
                           Spacer()
                       }
                   })
            .frame(width: 400,
                   height: 300,
                   alignment: .center);
        }
        .toolbar {
          ToolbarItemGroup(placement: .navigationBarTrailing) {
            Button(NSLocalizedString("Sign Out", comment: "Sign out button"), action: signOut)
          }
        }
      } else {
        Text(NSLocalizedString("Failed to get user profile!", comment: "Empty user profile text"))
      }
    }
  }

  func signOut() {
    authViewModel.signOut()
  }
}

