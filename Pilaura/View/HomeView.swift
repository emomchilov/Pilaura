//
//  HomeView.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/7/25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var networkingModel = NetworkingModel.shared
    var body: some View {
        VStack {
            // TODO: Add a loading indicator or launch screen while checking for inital token
            VisualizerView()
        }
        // TODO: Add logic to present sheet when not authenticated OR viewing playlists
        .sheet(isPresented: .constant(true)) {
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
}
