//
//  VisualizerView.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/13/25.
//

import SwiftUI
import SpotifyiOS

struct VisualizerView: View {
    @EnvironmentObject var playlistsVM: PlaylistsViewModel
    let networkingModel = NetworkingModel.shared
    let cycleLength = 20.0
    
    private var playPauseIconName: String {
        playlistsVM.isPlaying ? "pause.fill" : "play.fill"
    }
    
    @State var totalTimePaused: TimeInterval = 0
    @State var pauseStartTime: Date?
    @State var pausedElapsedTime: TimeInterval?

    var body: some View {
        TimelineView(.animation) { context in
            let rawTime = context.date.timeIntervalSince(playlistsVM.startTime)
            let elapsedTime = if let timeAtPause = pausedElapsedTime {
                timeAtPause
            } else {
                rawTime - totalTimePaused
            }
            
            let cycle = elapsedTime.truncatingRemainder(dividingBy: cycleLength) / cycleLength
            
            let startIndex = Int((elapsedTime / cycleLength).truncatingRemainder(dividingBy: Double(Color.gradientSets.count)))
            let nextIndex = (startIndex + 1) % Color.gradientSets.count
            
            let currentGradient = Color.gradientSets[startIndex]
            let nextGradient = Color.gradientSets[nextIndex]
            
            let interpolatedColors = zip(currentGradient, nextGradient).map {
                Color.interpolate(from: $0.0, to: $0.1, progress: cycle)
            }
            
            let formattedTime = formatTimeInterval(elapsedTime)

            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        VisualizerButton(iconName: "music.note.list") {
                            playlistsVM.showPlaylists.toggle()
                        }
                    }
                    .padding()
                    Spacer()
                    HStack {
                        VisualizerButton(iconName: "arrowtriangle.left.fill") {
                            playlistsVM.playPreviousTrack()
                        }
                        VisualizerButton(iconName: playPauseIconName) {
                            if playlistsVM.isPlaying {
                                playlistsVM.pause()
                                self.pauseStartTime = Date.now
                                self.pausedElapsedTime = elapsedTime
                            } else {
                                playlistsVM.resume()
                                if let start = pauseStartTime {
                                    totalTimePaused += Date.now.timeIntervalSince(start)
                                }
                                clearPauseTracker()
                            }
                        }
                        VisualizerButton(iconName: "arrowtriangle.right.fill") {
                            playlistsVM.playNextTrack()
                        }
                    }
                    .padding()
                    
                }
                .zIndex(3)
                Text(formattedTime)
                    .foregroundColor(Color.white)
                    .font(.alika(size: 100))
                    .bold()
                    .zIndex(2)
                VStack {
                    interpolatedColors.last ?? Color.black
                }
                .edgesIgnoringSafeArea(.all)
                
                ForEach(0..<4, id: \.self) { index in
                    Circle()
                        .fill(RadialGradient(
                            gradient: Gradient(colors: interpolatedColors), center: .center, startRadius: CGFloat(50 + index * 30), endRadius: CGFloat(500 - index * 40)))
                        .blur(radius: 20)
                        .opacity(0.5)
                }
            }
            .onChange(of: playlistsVM.startTime) { _ in
                clearPauseTracker()
                self.totalTimePaused = 0
            }
        }
    }
    
    private func clearPauseTracker() {
        self.pauseStartTime = nil
        self.pausedElapsedTime = nil
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
        .environmentObject(PlaylistsViewModel())
}
