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
        case .workout: return "figure.run"
        case .rest: return "pause.fill"
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
        case .sets: return Color(hex: "404040")
        case .warmup: return Color(hex: "348FFF")
        case .workout: return Color(hex: "00BF56")
        case .rest: return Color(hex: "FFC52F")
        }
    }
    
    var subTheme: Color {
        switch self {
        case .sets: return Color(hex: "BEBEBE")
        case .warmup: return Color(hex: "90CAFF")
        case .workout: return Color(hex: "DFFFEE")
        case .rest: return Color(hex: "FFF5DB")
        }
    }
    
    var setsAllCase: [Int] {
        switch self {
        case .sets:
            return Array(1...10)
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
            return Array(stride(from: 10, through: 60, by: 10))
        case .workout:
            return Array(0...11).map { $0 * 5 }
        case .rest:
            return Array(0...11).map { $0 * 5 }
        }
    }
    
}
