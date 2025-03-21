//
//  TimerItem.swift
//  Timelist
//
//  Created by Jason Qiu on 3/21/25.
//


import Foundation

class TimerItem: Identifiable, ObservableObject, Codable {
    let id: UUID
    @Published var title: String
    @Published var duration: TimeInterval
    @Published var remainingTime: TimeInterval
    @Published var isPaused: Bool

    init(title: String, duration: TimeInterval, isPaused: Bool = true) {
        self.id = UUID()
        self.title = title
        self.duration = duration
        self.remainingTime = duration
        self.isPaused = isPaused
    }

    enum CodingKeys: String, CodingKey {
        case id, title, duration, remainingTime, isPaused
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        duration = try container.decode(TimeInterval.self, forKey: .duration)
        remainingTime = try container.decode(TimeInterval.self, forKey: .remainingTime)
        isPaused = try container.decode(Bool.self, forKey: .isPaused)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(duration, forKey: .duration)
        try container.encode(remainingTime, forKey: .remainingTime)
        try container.encode(isPaused, forKey: .isPaused)
    }

    func tick() {
        guard !isPaused else { return }
        if remainingTime > 0 {
            remainingTime -= 1
        }
    }

    var formattedTime: String {
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
