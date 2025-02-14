//
//  PlaylistResponse.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/14/25.
//


struct SpotifyPlaylistsResponse: Codable {
    let items: [Playlist]
}

struct Playlist: Codable, Identifiable {
    let id: String
    let name: String
    let images: [PlaylistImage]

    struct PlaylistImage: Codable {
        let url: String
    }
    
    static var mockPlaylist1 = Playlist(id: "1a7MNhk3aHFNueF6mJB3Hg", name: "onyx reformer 2/3", images: [PlaylistImage(url: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000da84a47fc38c80093da757cdc46f")])
    
    static var mockPlaylist2 = Playlist(id: "1zNJXD0Ne7WHMMPu4YrxYE", name: "onyx reformer 11/24", images: [PlaylistImage(url: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000da843d6d556c28ee4b228c087ca9")])
    
    static var mockPlaylist3 = Playlist(id: "6K0KxFAvhvUgkZIC0kwCzN", name:  "sabrina class 💋", images: [PlaylistImage(url: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000da848d7cc94a7a54a751e7d70945")])
    
    static var mockPlaylist4 = Playlist(id: "2phU1fIIXtbLFmaDpGn8IY", name:  "onyx reformer 10/1", images: [PlaylistImage(url: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000da84b7ab04304c049a472541218f")])
    
    static var mockPlaylist5 = Playlist(id: "3JE4A6a6ZEKkO8idr0TPzm", name:  "onyx reformer 9/10", images: [PlaylistImage(url: "https://image-cdn-fa.spotifycdn.com/image/ab67706c0000da84713dd50248e90b50b6ecdac8")])
    
    static var listOfMockPlaylists = [mockPlaylist1, mockPlaylist2, mockPlaylist3, mockPlaylist4, mockPlaylist5]
}
