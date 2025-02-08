//
//  ContentView.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/7/25.
//

import SwiftUI

struct ContentView: View {
    private var networking = Networking()
    var body: some View {
        VStack {
        // check if user is authenticated
        // if not, show log in view
        
        
        // if authenticated, show playlist view
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .onTapGesture {
                    networking.authorize()
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
