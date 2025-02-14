//
//  PlaylistViewModel.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/14/25.
//

import Foundation
import SwiftUI

class PlaylistsViewModel: ObservableObject {
    let networkingModel = NetworkingModel.shared
    
    @Published var isPlayingSession = false

    @Published var playlists: [Playlist]?
    @Published var displayName: String = ""
    @Published var isLoading: Bool = true
    
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
}
