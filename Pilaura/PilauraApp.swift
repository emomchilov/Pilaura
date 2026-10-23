//
//  PilauraApp.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/7/25.
//

import SwiftUI

@main
struct PilauraApp: App {
    @StateObject private var timerViewModel = TimerViewModel()
    @StateObject private var playlistsViewModel = PlaylistsViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(timerViewModel)
                .environmentObject(playlistsViewModel)
        }
    }
}
