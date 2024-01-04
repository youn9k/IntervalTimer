//
//  Time.swift
//  IntervalTimer
//
//  Created by YoungK on 1/4/24.
//

import Foundation
import Combine

public struct Time {
    var minutes: Int
    var seconds: Int
}

extension Time {
    var display: String {
        return String(format: "%02d:%02d", minutes, seconds) }
    
    func toSeconds() -> Int {
        return minutes * 60 + seconds
    }
}
