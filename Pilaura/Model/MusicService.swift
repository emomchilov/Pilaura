//
//  MusicService.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/7/25.
//

import MusicKit
import SwiftUI
import Combine

class MusicService: ObservableObject {
    static let shared = MusicService()

    @Published private(set) var authorizationStatus: MusicAuthorization.Status = MusicAuthorization.currentStatus
    @Published private(set) var canPlayCatalogContent: Bool = false
    @Published var userBypassedAuthentication: Bool = false

    @Published private(set) var isMusicConnected: Bool = false
    @Published private(set) var isAuthenticated: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        Publishers
            .CombineLatest($authorizationStatus, $canPlayCatalogContent)
            .map { status, canPlay in
                return status == .authorized && canPlay
            }
            .sink { [weak self] connected in
                self?.isMusicConnected = connected
            }
            .store(in: &cancellables)

        Publishers
            .CombineLatest($isMusicConnected, $userBypassedAuthentication)
            .map { connected, userBypassed in
                return connected || userBypassed
            }
            .sink { [weak self] auth in
                self?.isAuthenticated = auth
            }
            .store(in: &cancellables)

        Task {
            for await subscription in MusicSubscription.subscriptionUpdates {
                await MainActor.run {
                    self.canPlayCatalogContent = subscription.canPlayCatalogContent
                }
            }
        }
    }

    func authorize() async {
        let status = await MusicAuthorization.request()
        let subscription = status == .authorized ? try? await MusicSubscription.current : nil
        await MainActor.run {
            self.authorizationStatus = status
            self.canPlayCatalogContent = subscription?.canPlayCatalogContent ?? false
        }
    }

    func fetchLibraryPlaylists() async throws -> MusicItemCollection<MusicKit.Playlist> {
        var request = MusicLibraryRequest<MusicKit.Playlist>()
        request.sort(by: \.lastPlayedDate, ascending: false)
        request.limit = 30
        let response = try await request.response()
        return response.items
    }
}
