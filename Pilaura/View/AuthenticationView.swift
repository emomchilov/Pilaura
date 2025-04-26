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
            HStack {
                Image(.singleStar)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75)
                Spacer()
            }
            .padding(.bottom, 20)
            .padding(.leading, 10)
            Spacer()

            ZStack(alignment: .bottom) {
                VStack {
                    Text("Welcome to")
                        .font(.alika(size: 48))
                        .foregroundColor(Color.darkBlue)
                        .padding(0)
                    Text("Pilaura")
                        .font(.bolina(size: 115))
                        .foregroundColor(Color.darkBlue)
                        .offset(y: -35)
                        .padding(.bottom, 10)
                    Text("Grant access to spotify to begin.")
                        .font(.alika(size: 24))
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
                            .font(.alika(size: 24))
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
                        
            VStack(spacing: 0) {
                Text("or")
                    .font(.alika(size: 20))
                    .foregroundStyle(Color.midBlue)

                Button {
                    networkingModel.userBypassedAuthentication = true
                } label: {
                    HStack {
                        Text("Use Timer Only")
                            .font(.alika(size: 24))
                            .foregroundStyle(Color.midBlue)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 20)
                            .background(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .strokeBorder(Color.midBlue, lineWidth: 1)
                                    .frame(height: 50)
                            )
                    }
                }
            }
            .offset(y: offset)
            Spacer()
            HStack {
                Spacer()
                Image(.twoStars)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75)

            }
            .padding(.top, 20)
            .padding(.trailing, 10)
        }
    }

}

#Preview {
    AuthenticationView()
}
