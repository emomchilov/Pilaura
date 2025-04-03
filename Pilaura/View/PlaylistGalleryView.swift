//
//  PlaylistGalleryView.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/7/25.
//

import SwiftUI

struct PlaylistGalleryView: View {
    @EnvironmentObject var playlistsVM: PlaylistsViewModel
    let networkingModel = NetworkingModel.shared
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private var fontSize: CGFloat {
        UIDevice.current.systemName == "iOS" ? 14 : 30
    }
    
    private var maxImageSize: CGFloat {
        UIDevice.current.systemName == "iOS" ? 100 : 200
    }

    
    var body: some View {
        VStack {
            if playlistsVM.isLoading {
                ProgressView("Loading Playlists...")
            } else if let playlists = playlistsVM.playlists {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(playlists) { playlist in
                            playlistView(playlist: playlist)
                                .onTapGesture {
                                    playlistsVM.startPlayback(for: playlist.id)
                                }
                        }
                    }
                }
            } else {
                Text("No playlists found.")
            }
        }
        .task {
            await playlistsVM.loadSpotifyData()
        }
    }
    
    private func playlistView(playlist: Playlist) -> some View {
        VStack {
            // TODO: Just need the first image, could refactor how this is decoded?
            if let url = playlist.images.first?.url {
                AsyncImage(url: URL(string: url)!) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(maxWidth: 200)
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: 200)
                }
                Text(playlist.name)
                    .font(.alika(size: fontSize))
                    .lineLimit(1)

            }
        }
        .padding(20)
    }
    
    private func loadSpotifyData() async {
        do {
            let userProfile = try await networkingModel.fetchUserProfile()
            playlistsVM.displayName = userProfile.display_name
            let userPlaylists = try await networkingModel.fetchPlaylists(for: userProfile.id)
            playlistsVM.playlists = userPlaylists
            playlistsVM.isLoading = false
        } catch {
            print("Error fetching Spotify data: \(error)")
            playlistsVM.isLoading = false
        }
    }
}
    
    struct PlaylistGalleryView_Previews: PreviewProvider {
        static var previews: some View {
            let vm: PlaylistsViewModel = {
                let playlistVM = PlaylistsViewModel()
                playlistVM.playlists = [Playlist.mockPlaylist1, Playlist.mockPlaylist2, Playlist.mockPlaylist3, Playlist.mockPlaylist4]
                return playlistVM
            }()
            VStack {
                PlaylistGalleryView()
                    .environmentObject(vm)
            }
        }
    }
