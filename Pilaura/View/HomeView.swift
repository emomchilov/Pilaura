//
//  HomeView.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/7/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var playlistsVM: PlaylistsViewModel
    @ObservedObject var networkingModel = NetworkingModel.shared
        
    @State private var isSheetPresented = true
    
    var body: some View {
        VStack {
            // TODO: Add a loading indicator or launch screen while checking for inital token
            VisualizerView()
        }
        .onReceive(networkingModel.$isAuthenticated
            .combineLatest(playlistsVM.$showPlaylists, networkingModel.$userBypassedAuthentication)) { isAuthenticated, showPlaylists, userBypassed in
                if isAuthenticated {
                    if userBypassed {
                        isSheetPresented = false
                    } else {
                        isSheetPresented = showPlaylists
                    }
                }
        }
        .sheet(isPresented: $isSheetPresented , onDismiss: {
            playlistsVM.showPlaylists = false
        }) {
            VStack {
                if networkingModel.isAuthenticated {
                    if networkingModel.appRemote.isConnected {
                        PlaylistGalleryView()
                    } else {
                        AuthenticationView()
                    }
                } else {
                    AuthenticationView()
                }

            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(PlaylistsViewModel())
}
