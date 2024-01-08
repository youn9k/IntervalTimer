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
    
    init(minutes: Int, seconds: Int) {
        self.minutes = minutes
        self.seconds = seconds
    }
    
    init(seconds: Int) {
        self.minutes = seconds / 60
        self.seconds = seconds % 60
    }
}

extension Time {
    var display: String {
        return String(format: "%02d:%02d", minutes, seconds) }
    
    func toSeconds() -> Int {
        return minutes * 60 + seconds
    }
}
