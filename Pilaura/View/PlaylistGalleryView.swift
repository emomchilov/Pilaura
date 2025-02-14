//
//  PlaylistGalleryView.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/7/25.
//

import SwiftUI

struct PlaylistGalleryView: View {
    let networkingModel = NetworkingModel.shared
    @State var playlists: [Playlist]?
    @State private var displayName: String = ""
    @State private var isLoading: Bool = true

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    var body: some View {
        VStack {
            if let playlists = playlists {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(playlists) { playlist in
                            playlistView(playlist: playlist)
                        }
                    }
                }
            } else {
                ProgressView("Loading Playlists...")
            }
        }
        .task {
            await loadSpotifyData()
        }
    }
    
    private func playlistView(playlist: Playlist) -> some View {
        VStack {
            // TODO: Just need the first image, could refactor how this is decoded?
            if let url = playlist.images.first?.url {
                AsyncImage(url: URL(string: url)!) { image in
                    image.resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                Text(playlist.name)
                    .font(.largeTitle)
            }
        }
        .padding(20)
    }
    
    private func loadSpotifyData() async {
        do {
            let userProfile = try await networkingModel.fetchUserProfile()
            displayName = userProfile.display_name
            let userPlaylists = try await networkingModel.fetchPlaylists(for: userProfile.id)
            playlists = userPlaylists
            isLoading = false
        } catch {
            print("Error fetching Spotify data: \(error)")
            isLoading = false
        }
    }
}

#Preview {
    PlaylistGalleryView(playlists: Playlist.listOfMockPlaylists)
}
