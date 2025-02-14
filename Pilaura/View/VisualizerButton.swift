//
//  VisualizerButton.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/14/25.
//

import SwiftUI

struct VisualizerButton: View {
    let iconName: String
    let action: () -> ()
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .shadow(radius: 10)
        }

    }
}

#Preview {
    VisualizerButton(iconName: "music.note.list") {
        print("pressed")
    }
}
