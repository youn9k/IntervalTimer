//
//  SetupWorkoutInfo.swift
//  IntervalTimer
//
//  Created by YoungK on 12/21/23.
//

import Foundation
import SwiftUI

enum SetupWorkoutType {
    case sets, warmup, workout, rest
    
    var icon: String {
        switch self {
        case .sets: return "arrow.counterclockwise.circle.fill"
        case .warmup: return "figure.walk.circle.fill"
        case .workout: return "figure.run.circle.fill"
        case .rest: return "pause.circle.fill"
        }
    }
    
    var title: String {
        switch self {
        case .sets: return "NUM_OF_SETS"
        case .warmup: return "WARM_UP"
        case .workout: return "WORKOUT"
        case .rest: return "REST"
        }
    }
    
    var theme: Color {
        switch self {
        case .sets: return .timerGray
        case .warmup: return .blue
        case .workout: return .green
        case .rest: return .yellow
        }
    }
    
    var setsAllCase: [Int] {
        switch self {
        case .sets:
            return Array(0...10)
        default:
            return []
        }
    }
    
    var minAllCase: [Int] {
        switch self {
        case .sets:
            return []
        case .warmup:
            return Array(0...30)
        case .workout:
            return Array(0...30)
        case .rest:
            return Array(0...30)
        }
    }
    
    var secAllCase: [Int] {
        switch self {
        case .sets:
            return []
        case .warmup:
            return Array(0...11).map { $0 * 5 }
        case .workout:
            return Array(0...11).map { $0 * 5 }
        case .rest:
            return Array(0...11).map { $0 * 5 }
        }
    }
    
}
