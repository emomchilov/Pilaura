//
//  Networking.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/7/25.
//

import SpotifyiOS
import SwiftUI

class NetworkingModel: ObservableObject {
    var clientId = ""
    let redirectUri = "com.Pilaura://callback"
    static var accessTokenKey = "access-token-key"
    static let shared = NetworkingModel()
        
    let configuration: SPTConfiguration
    
    @Published var appRemote: SPTAppRemote
    
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
        appRemote.authorizeAndPlayURI("")
    }
    
    func connectToSpotify(_ delegate: SPTAppRemoteDelegate, token: String) {
        appRemote.connectionParameters.accessToken = token
        appRemote.connect()
        appRemote.delegate = delegate
    }

}

