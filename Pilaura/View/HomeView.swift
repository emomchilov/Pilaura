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
        
    private var isSheetPresented: Binding<Bool> {
        Binding (
            get: {
                !networkingModel.appRemote.isConnected || playlistsVM.showPlaylists
            },
            set: { _ in }
        )
    }
    
    var body: some View {
        VStack {
            // TODO: Add a loading indicator or launch screen while checking for inital token
            VisualizerView()
        }
        .sheet(isPresented: isSheetPresented , onDismiss: {
            playlistsVM.showPlaylists = false
        }) {
            VStack {
                if networkingModel.appRemote.isConnected {
                    PlaylistGalleryView()
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
