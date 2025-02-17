//
//  AuthenticationView.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/7/25.
//

import SwiftUI

struct AuthenticationView: View {
    @ScaledMetric private var offset = 44
    let networkingModel = NetworkingModel.shared
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Image(.singleStar)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75)
                Spacer()
            }
            .padding(.bottom, 20)
            .padding(.leading, 10)
            ZStack(alignment: .bottom) {
                VStack {
                    Text("Welcome to")
                        .font(.vanilla(size: 48))
                        .foregroundColor(Color.darkBlue)
                        .padding(0)
                    Text("Pilaura")
                        .font(.bolina(size: 115))
                        .foregroundColor(Color.darkBlue)
                        .offset(y: -35)
                        .padding(.bottom, 10)
                    Text("Grant access to spotify to begin.")
                        .font(.vanilla(size: 24))
                        .foregroundColor(Color.darkBlue)
                        .padding(.bottom, 30)
                }
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .padding(60)
                .overlay(
                    RoundedRectangle(cornerRadius: 16.0)
                        .stroke(Color.darkBlue, lineWidth: 2)
                )
                Button {
                    networkingModel.authorize()
                } label: {
                    HStack {
                        Text("Connect to Spotify")
                            .font(.vanilla(size: 24))
                            .foregroundStyle(Color.offWhite)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 20)
                            .background(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(Color.midBlue)
                                    .frame(height: 50)
                            )
                    }
                    .offset(y: offset)
                }
            }



            HStack {
                Spacer()
                Image(.twoStars)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75)

            }
            .padding(.top, 20)
            .padding(.trailing, 10)
            Spacer()
        }
    }

}

#Preview {
    AuthenticationView()
}
