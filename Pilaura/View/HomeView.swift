//
//  HomeView.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/7/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var playlistsVM: PlaylistsViewModel
    @EnvironmentObject var timerVM: TimerViewModel
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
                        timerVM.restart()
                    } else {
                        isSheetPresented = showPlaylists
                    }
                } else {
                    isSheetPresented = true
                }
        }
        .sheet(isPresented: $isSheetPresented) {
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
        .environmentObject(TimerViewModel())
        .environmentObject(PlaylistsViewModel())
}
