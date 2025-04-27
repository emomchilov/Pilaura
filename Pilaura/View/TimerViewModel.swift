//
//  TimerViewModel.swift
//  Pilaura
//
//  Created by Eden Momchilov on 4/26/25.
//

import SwiftUI

class TimerViewModel: ObservableObject {
    @Published var startTime: Date = Date()
    @Published var totalTimePaused: TimeInterval = 0
    @Published var isPaused: Bool = false

    private var pauseStartTime: Date?
    private var pausedElapsedTime: TimeInterval?
    @Published var isRunning: Bool = false

    let cycleLength: TimeInterval = 20.0
    
    func elapsedTime(currentDate: Date) -> TimeInterval {
        let rawTime = currentDate.timeIntervalSince(startTime)
        if let paused = pausedElapsedTime {
            return paused
        } else {
            return rawTime - totalTimePaused
        }
    }

    func pause(currentDate: Date) {
        isPaused = true
        pauseStartTime = currentDate
        pausedElapsedTime = elapsedTime(currentDate: currentDate)
        isRunning = false
    }

    func resume(currentDate: Date) {
        isPaused = false
        if let start = pauseStartTime {
            totalTimePaused += currentDate.timeIntervalSince(start)
        }
        clearPauseTracker()
        isRunning = true
    }

    func restart() {
        startTime = Date()
        totalTimePaused = 0
        clearPauseTracker()
        isRunning = true
    }

    private func clearPauseTracker() {
        pauseStartTime = nil
        pausedElapsedTime = nil
    }
}
