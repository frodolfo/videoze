//
//  UserProfileImageView.swift
//  Videoze
//
//  Created by Rodolfo, Fred (US) on 10/8/22.
//

import GoogleSignIn
import SwiftUI

struct UserProfileImageView: View {
    @ObservedObject var userProfileImageLoader: UserProfileImageLoader

    init(userProfile: GIDProfileData) {
        self.userProfileImageLoader = UserProfileImageLoader(userProfile: userProfile)
    }

    var body: some View {
        if userProfileImageLoader.image != nil {
            Image(uiImage: userProfileImageLoader.image!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 45, height: 45, alignment: .center)
                .scaledToFit()
                .clipShape(Circle())
                .accessibilityLabel(Text("User profile image."))
        }
    }
}
