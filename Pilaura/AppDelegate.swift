//
//  AppDelegate.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/8/25.
//


import UIKit
import SpotifyiOS

class AppDelegate: UIResponder, UIApplicationDelegate {
    let networkingModel = NetworkingModel.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?)
    -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}
