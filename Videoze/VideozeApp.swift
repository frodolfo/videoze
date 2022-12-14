//
//  VideozeApp.swift
//  Videoze
//
//  Created by Rodolfo, Fred (US) on 10/7/22.
//

import GoogleSignIn
import SwiftUI

@main
struct VideozeApp: App {
    @StateObject var authViewModel = AuthenticationViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
                .onAppear {
                    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                        if let user = user {
                            self.authViewModel.state = .signedIn(user)
                        } else if let error = error {
                            self.authViewModel.state = .signedOut
                            print("There was an error restoring the previous sign-in: \(error)")
                        } else {
                            self.authViewModel.state = .signedOut
                        }
                    }
                }
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
