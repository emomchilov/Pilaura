//
//  PlaylistGalleryView.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/7/25.
//

import SwiftUI
import MusicKit

struct PlaylistGalleryView: View {
    @EnvironmentObject var playlistsVM: PlaylistsViewModel

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    private var fontSize: CGFloat {
        UIDevice.current.systemName == "iOS" ? 14 : 30
    }

    var body: some View {
        VStack {
            if playlistsVM.isLoading {
                ProgressView("Loading Playlists...")
            } else if let playlists = playlistsVM.playlists, !playlists.isEmpty {
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
            await playlistsVM.loadLibrary()
        }
    }

    private func playlistView(playlist: PlaylistSummary) -> some View {
        VStack {
            // Library artwork uses a musicKit:// URL that AsyncImage can't load, so render it with ArtworkImage.
            Color.clear
                .aspectRatio(1, contentMode: .fit)
                .overlay {
                    GeometryReader { geometry in
                        if let artwork = playlist.artwork {
                            ArtworkImage(artwork, width: geometry.size.width, height: geometry.size.width)
                        } else {
                            ZStack {
                                Color.midBlue
                                Image(systemName: "music.note.list")
                                    .foregroundStyle(Color.offWhite)
                            }
                        }
                    }
                }
                .frame(maxWidth: 200)
                .clipped()
            Text(playlist.name)
                .font(.alika(size: fontSize))
                .lineLimit(1)
        }
        .padding(20)
    }
}

    struct PlaylistGalleryView_Previews: PreviewProvider {
        static var previews: some View {
            let vm: PlaylistsViewModel = {
                let playlistVM = PlaylistsViewModel()
                playlistVM.playlists = [PlaylistSummary.mockPlaylist1, PlaylistSummary.mockPlaylist2, PlaylistSummary.mockPlaylist3, PlaylistSummary.mockPlaylist4]
                return playlistVM
            }()
            VStack {
                PlaylistGalleryView()
                    .environmentObject(vm)
            }
        }
    }
