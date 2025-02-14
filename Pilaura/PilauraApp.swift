//
//  PilauraApp.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/7/25.
//

import SwiftUI
import SpotifyiOS

@main
struct PilauraApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            // TODO: Come back to this!! Don't love this solution, but need to remove the duplicate HomeView that I overlooked earlier when using SceneDelegate
            EmptyView()
        }
    }
}
