//
//  SceneDelegate.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/8/25.
//

import UIKit
import SpotifyiOS
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate {
    var window: UIWindow?
    let networkingModel = NetworkingModel.shared

    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        networkingModel.appRemote = appRemote
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: (any Error)?) {
        //
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: (any Error)?) {
        //
    }
    
    func playerStateDidChange(_ playerState: any SPTAppRemotePlayerState) {
        //
    }
        
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let contentView = HomeView()
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            if let token = networkingModel.accessToken {
                networkingModel.connectToSpotify(self, token: token)
            }
            window.makeKeyAndVisible()
        }
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }

        let parameters = networkingModel.appRemote.authorizationParameters(from: url);

        if let token = parameters?[SPTAppRemoteAccessTokenKey] {
            networkingModel.connectToSpotify(self, token: token)
            networkingModel.accessToken = token
        } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
            print("ERROR: \(error_description)")
        }
    }
}
