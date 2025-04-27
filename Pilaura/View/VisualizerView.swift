//
//  VisualizerView.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/13/25.
//

import SwiftUI
import SpotifyiOS

struct VisualizerView: View {
    @EnvironmentObject var timerVM: TimerViewModel
    @EnvironmentObject var playlistsVM: PlaylistsViewModel
    let networkingModel = NetworkingModel.shared
    let cycleLength = 20.0
    
    private var playPauseIconName: String {
        timerVM.isRunning ? "pause.fill" : "play.fill"
    }
    
    private var sheetIcon: String {
        networkingModel.userBypassedAuthentication ? "music.note" : "music.note.list"
    }

    var body: some View {
        TimelineView(.animation) { context in
            
            let elapsedTime = timerVM.elapsedTime(currentDate: context.date)
            
            let cycle = elapsedTime.truncatingRemainder(dividingBy: timerVM.cycleLength) / timerVM.cycleLength
            
            let startIndex = Int((elapsedTime / timerVM.cycleLength).truncatingRemainder(dividingBy: Double(Color.gradientSets.count)))
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
                        if networkingModel.userBypassedAuthentication {
                            VisualizerButton(iconName: "gobackward") {
                                timerVM.restart()
                            }
                        }
                        Spacer()
                        VisualizerButton(iconName: sheetIcon) {
                            if networkingModel.userBypassedAuthentication {
                                networkingModel.userBypassedAuthentication = false
                            } else {
                                playlistsVM.showPlaylists = true
                            }
                        }
                    }
                    .padding()
                    Spacer()
                    HStack {
                        if !networkingModel.userBypassedAuthentication {
                            VisualizerButton(iconName: "arrowtriangle.left.fill") {
                                playlistsVM.playPreviousTrack()
                            }
                        }
                        VisualizerButton(iconName: playPauseIconName) {
                            if timerVM.isRunning {
                                playlistsVM.pause()
                                timerVM.pause(currentDate: Date())
                            } else {
                                playlistsVM.resume()
                                timerVM.resume(currentDate: Date())
                            }
                        }
                        if !networkingModel.userBypassedAuthentication {
                            VisualizerButton(iconName: "arrowtriangle.right.fill") {
                                playlistsVM.playNextTrack()
                            }
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
                timerVM.restart()
            }
            .onAppear {
                timerVM.isRunning = true
            }
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
        .environmentObject(TimerViewModel())
        .environmentObject(PlaylistsViewModel())
}
