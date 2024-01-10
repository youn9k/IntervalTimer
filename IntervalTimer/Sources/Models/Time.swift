//
//  Time.swift
//  IntervalTimer
//
//  Created by YoungK on 1/4/24.
//

import Foundation
import Combine

public struct Time: Hashable {
    var minutes: Int
    var seconds: Int
    var totalSeconds: Int { minutes * 60 + seconds }
    
    init(minutes: Int, seconds: Int) {
        self.minutes = minutes
        self.seconds = seconds
    }
    
    init(seconds: Int) {
        self.minutes = seconds / 60
        self.seconds = seconds % 60
    }
    
    init() {
        self.init(minutes: 0, seconds: 0)
    }
}

extension Time {
    mutating func plus(_ seconds: Int) {
        let totalSeconds = self.totalSeconds + seconds
        self.minutes = totalSeconds / 60
        self.seconds = totalSeconds % 60
    }
    
    mutating func minus(_ seconds: Int) {
        let totalSeconds = self.totalSeconds - seconds
        self.minutes = max(0, totalSeconds / 60)
        self.seconds = max(0, totalSeconds % 60)
    }
}

extension Time {
    var display: String {
        return String(format: "%02d:%02d", minutes, seconds) }
}
