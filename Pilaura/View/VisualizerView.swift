//
//  VisualizerView.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/13/25.
//

import SwiftUI

struct VisualizerView: View {
    @EnvironmentObject var playlistsVM: PlaylistsViewModel
    let cycleLength = 20.0
    
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation) { context in
            let time = context.date.timeIntervalSince(startTime)
            let cycle = time.truncatingRemainder(dividingBy: cycleLength) / cycleLength
            
            let startIndex = Int((time / cycleLength).truncatingRemainder(dividingBy: Double(Color.gradientSets.count)))
            let nextIndex = (startIndex + 1) % Color.gradientSets.count
            
            let currentGradient = Color.gradientSets[startIndex]
            let nextGradient = Color.gradientSets[nextIndex]
            
            let interpolatedColors = zip(currentGradient, nextGradient).map {
                Color.interpolate(from: $0.0, to: $0.1, progress: cycle)
            }
            let formattedTime = formatTimeInterval(time)
            
            ZStack {
                Text(formattedTime)
                    .foregroundColor(Color.white)
                    .font(.title)
                    .bold()
                    .zIndex(2)
                VStack {
                    interpolatedColors.last ?? Color.black
                }
                .edgesIgnoringSafeArea(.all)
                
                ForEach(0..<4, id: \.self) { index in
                    Circle()
                        .fill(RadialGradient(
                            gradient: Gradient(colors: interpolatedColors), center: .center, startRadius: CGFloat(100 + index * 30), endRadius: CGFloat(500 - index * 40)))
                        .blur(radius: 20)
                        .opacity(0.5)
                }
            }
            .onChange(of: playlistsVM.isPlayingSession, perform: { value in
                if value {
                    startTime = Date.now
                }
            })
        }
    }
    
    private func formatTimeInterval(_ interval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: interval) ?? "00:00"
    }
}

#Preview {
    VisualizerView()
}
