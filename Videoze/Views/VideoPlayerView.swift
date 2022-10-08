//
//  VideoPlayerView.swift
//  Videoze
//
//  Created by Rodolfo, Fred (US) on 10/8/22.
//

import AVKit
import GoogleSignIn
import SwiftUI

struct VideoPlayerView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @State var player = AVPlayer(url: URL(string: "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8")!)

    private var user: GIDGoogleUser? {
        return GIDSignIn.sharedInstance.currentUser
    }

    var body: some View {
        player.play()
        return Group {
            if let userProfile = user?.profile {
                VStack(spacing: 4) {
                    HStack(alignment: .top) {
                        UserProfileImageView(userProfile: userProfile)
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
                           alignment: .top)
                }
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(NSLocalizedString("Sign Out", comment: "Sign out button"), action: signOut)
                    }
                }
                Spacer()
            } else {
                Text(NSLocalizedString("Failed to get user profile!", comment: "Empty user profile text"))
            }
        }
    }

    func signOut() {
        authViewModel.signOut()
    }
}
