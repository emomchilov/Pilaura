//
//  PlaylistSummary.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/14/25.
//

import MusicKit

struct PlaylistSummary: Identifiable {
    let id: String
    let name: String
    let artwork: Artwork?

    init(id: String, name: String, artwork: Artwork? = nil) {
        self.id = id
        self.name = name
        self.artwork = artwork
    }

    init(_ playlist: MusicKit.Playlist) {
        self.init(id: playlist.id.rawValue, name: playlist.name, artwork: playlist.artwork)
    }

    // MusicKit artwork can't be constructed by hand, so mocks render the placeholder.
    static var mockPlaylist1 = PlaylistSummary(id: "1", name: "onyx refo")

    static var mockPlaylist2 = PlaylistSummary(id: "2", name: "onyx reformer 11/24")

    static var mockPlaylist3 = PlaylistSummary(id: "3", name: "sabrina class 💋")

    static var mockPlaylist4 = PlaylistSummary(id: "4", name: "onyx reformer 10/1")

    static var mockPlaylist5 = PlaylistSummary(id: "5", name: "onyx reformer 9/10")

    static var listOfMockPlaylists = [mockPlaylist1, mockPlaylist2, mockPlaylist3, mockPlaylist4, mockPlaylist5]
}
