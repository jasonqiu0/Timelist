//
//  TimerManager.swift
//  Timelist
//
//  Created by Jason Qiu on 3/21/25.
//


import Foundation
import Combine

class TimerManager: ObservableObject {
    @Published var timers: [TimerItem] = [] {
        didSet {
            saveTimers()
        }
    }
    @Published var statusIconName: String = "clock.fill"

    private var cancellables: Set<AnyCancellable> = []
    private var updateTimer: Timer?
    private let timersKey = "savedTimers"

    init() {
        loadTimers()
        startUpdating()
    }

    func addTimer(title: String, duration: TimeInterval) {
        let newTimer = TimerItem(title: title, duration: duration, isPaused: true)
        timers.append(newTimer)
    }

    func deleteTimer(_ timer: TimerItem) {
        timers.removeAll { $0.id == timer.id }
    }

    func startUpdating() {
        updateTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            var hasRunning = false
            var hasFinished = false

            for timer in self.timers {
                timer.tick()
                if timer.remainingTime == 0 {
                    hasFinished = true
                } else if !timer.isPaused {
                    hasRunning = true
                }
            }

            if hasFinished {
                self.statusIconName = "clock.badge.exclamationmark.fill"
            } else if hasRunning {
                self.statusIconName = "clock.badge.fill"
            } else {
                self.statusIconName = "clock.fill"
            }

            self.objectWillChange.send()
        }
    }

    func pauseTimer(_ timer: TimerItem) {
        timer.isPaused = true
    }

    func continueTimer(_ timer: TimerItem) {
        timer.isPaused = false
    }

    func editTimer(_ timer: TimerItem, newTitle: String, newDuration: TimeInterval) {
        timer.title = newTitle
        timer.duration = newDuration
        timer.remainingTime = newDuration
    }

    private func saveTimers() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(timers) {
            UserDefaults.standard.set(data, forKey: timersKey)
        }
    }

    private func loadTimers() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: timersKey),
           let decoded = try? decoder.decode([TimerItem].self, from: data) {
            timers = decoded
        }
    }
}
