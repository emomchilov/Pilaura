//
//  AuthenticationView.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/7/25.
//

import SwiftUI

struct AuthenticationView: View {
    let networkingModel = NetworkingModel.shared
    var body: some View {
        VStack {
            Spacer()
            Text("Welcome to Pil-aura!")
                .font(.title)
            Text("You'll need to grant access to spotify to begin.")
                .font(.subheadline)
                .padding(.bottom, 30)
            Button {
                networkingModel.authorize()
            } label: {
                Text("Connect to Spotify")
                    .font(.title3).bold()
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        RoundedRectangle(cornerRadius: 10.0)
                            .frame(height: 50)
                    )
            }
            Spacer()
        }
        .padding(0)
    }
}

#Preview {
    AuthenticationView()
}
