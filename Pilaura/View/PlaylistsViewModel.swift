//
//  PlaylistViewModel.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/14/25.
//

import Foundation
import SwiftUI
import MusicKit
import Combine

class PlaylistsViewModel: ObservableObject {
    let musicService = MusicService.shared
    private let player = ApplicationMusicPlayer.shared
    private var libraryPlaylists: [String: MusicKit.Playlist] = [:]
    private var cancellables = Set<AnyCancellable>()

    @Published var showPlaylists = true
    @Published var startTime = Date()

    @Published var playlists: [PlaylistSummary]?
    @Published var isLoading: Bool = true
    @Published var isPlaying: Bool = false

    init() {
        player.state.objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.isPlaying = self.player.state.playbackStatus == .playing
            }
            .store(in: &cancellables)
    }

    func loadLibrary() async {
        do {
            let userPlaylists = try await musicService.fetchLibraryPlaylists()
            await MainActor.run {
                self.libraryPlaylists = Dictionary(userPlaylists.map { ($0.id.rawValue, $0) }, uniquingKeysWith: { first, _ in first })
                self.playlists = userPlaylists.map(PlaylistSummary.init)
                self.isLoading = false
            }
        } catch {
            print("Error fetching Apple Music library: \(error)")
            await MainActor.run {
                self.isLoading = false
            }
        }
    }

    func startPlayback(for playlistID: String) {
        guard let playlist = libraryPlaylists[playlistID] else { return }
        player.queue = [playlist]
        Task {
            do {
                try await player.play()
            } catch {
                print("Failed to start playback: \(error.localizedDescription)")
            }
        }
        startTime = Date.now
        showPlaylists = false
    }

    func pause() {
        player.pause()
    }

    func resume() {
        Task {
            do {
                try await player.play()
            } catch {
                print("Failed to resume playback: \(error.localizedDescription)")
            }
        }
    }

    func playNextTrack() {
        Task {
            do {
                try await player.skipToNextEntry()
                print("Skipped to next track successfully.")
            } catch {
                print("Failed to skip to next track: \(error.localizedDescription)")
            }
        }
    }

    func playPreviousTrack() {
        Task {
            do {
                try await player.skipToPreviousEntry()
                print("Skipped to previous track successfully.")
            } catch {
                print("Failed to skip to previous track: \(error.localizedDescription)")
            }
        }
    }
}
