//
//  Networking.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/7/25.
//

import SpotifyiOS
import SwiftUI

class NetworkingModel: ObservableObject {
    private var clientId = ""
    private let redirectUri = "com.Pilaura://callback"
    private let baseURL = "https://api.spotify.com/v1/"

    static var accessTokenKey = "access-token-key"
    static let shared = NetworkingModel()
        
    let configuration: SPTConfiguration
    
    @Published var appRemote: SPTAppRemote
    @Published var playlists: [Playlist] = []

    
    var accessToken = UserDefaults.standard.string(forKey: NetworkingModel.accessTokenKey) {
        didSet {
            let defaults = UserDefaults.standard
            defaults.set(accessToken, forKey: NetworkingModel.accessTokenKey)
        }
    }
    
    init() {
        if let infoDictionary: [String: Any] = Bundle.main.infoDictionary, let id: String = infoDictionary["Secret"] as? String {
            self.clientId = id
        }
        self.configuration = SPTConfiguration(clientID: clientId, redirectURL: URL(string: redirectUri)!)
        self.appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
    }
    
    func authorize() {
        appRemote.authorizeAndPlayURI("spotify:track:0")
    }
    
    func connectToSpotify(_ delegate: SPTAppRemoteDelegate, token: String) {
        appRemote.connectionParameters.accessToken = token
        appRemote.connect()
        appRemote.delegate = delegate
    }
    
    func fetchUserProfile() async throws -> SpotifyUserProfile {
        let url = URL(string: "\(baseURL)me")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if let token = accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(SpotifyUserProfile.self, from: data)
    }

    
    func fetchPlaylists(for userId: String) async throws -> [Playlist] {
        guard let url = URL(string: "\(baseURL)users/\(userId)/playlists?limit=30") else { return [] }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if let token = accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(SpotifyPlaylistsResponse.self, from: data)
            return decodedResponse.items
        } catch {
            print("Error fetching playlists: \(error)")
            return []
        }
    }
}

