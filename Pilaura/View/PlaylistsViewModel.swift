//
//  PlaylistViewModel.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/14/25.
//

import Foundation
import SwiftUI
import SpotifyiOS

class PlaylistsViewModel: ObservableObject {
    let networkingModel = NetworkingModel.shared
    
    @Published var showPlaylists = true
    @Published var startTime = Date()

    @Published var playlists: [Playlist]?
    @Published var displayName: String = ""
    @Published var isLoading: Bool = true
    @Published var isPlaying: Bool = false
    
    func loadSpotifyData() async {
        do {
            let userProfile = try await networkingModel.fetchUserProfile()
            DispatchQueue.main.async {
                self.displayName = userProfile.display_name
            }
            let userPlaylists = try await networkingModel.fetchPlaylists(for: userProfile.id)
            DispatchQueue.main.async {
                self.playlists = userPlaylists
                self.isLoading = false
            }
        } catch {
            print("Error fetching Spotify data: \(error)")
            isLoading = false
        }
    }
    
    func startPlayback(for playlistID: String) {
        networkingModel.appRemote.playerAPI?.play("spotify:playlist:\(playlistID)")
        startTime = Date.now
        showPlaylists = false
    }
    
    func pause() {
        networkingModel.appRemote.playerAPI?.pause()
    }
    
    func resume() {
        networkingModel.appRemote.playerAPI?.resume()
    }
    
    func playNextTrack() {
        networkingModel.appRemote.playerAPI?.skip(toNext: { _ , error in
            if let error = error {
                print("Failed to skip to next track: \(error.localizedDescription)")
            } else {
                print("Skipped to next track successfully.")
            }
        })
    }
    
    func playPreviousTrack() {
        networkingModel.appRemote.playerAPI?.skip(toPrevious: { _ , error in
            if let error = error {
                print("Failed to skip to previous track: \(error.localizedDescription)")
            } else {
                print("Skipped to previous track successfully.")
            }
        })
    }
}
