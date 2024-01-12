//
//  LocalizedStrings.swift
//  IntervalTimer
//
//  Created by YoungK on 1/12/24.
//

import SwiftUI

public enum LocalizedStrings: String {
    case totalWorkoutTime = "TOTAL_WORKOUT_TIME"
    case workoutTIme = "WORKOUT_TIME"
    case numOFSets = "NUM_OF_SETS"
    case warmUp = "WARM_UP"
    case workout = "WORKOUT"
    case rest = "REST"
    case workoutStart = "WORKOUT_START"
    case minute = "MINUTE"
    case seconds = "SECONDS"
    case sets = "SETS"
    case pause = "PAUSE"
    case heartRate = "HEART_RATE"
    case kcal = "KCAL"
    case congratuation = "CONGRATUATION!"
    case workoutFinish = "WORKOUT_FINISH🔥"
    case highHeartRate = "HIGH_HEART_RATE"
    case avgHeartRate = "AVG_HEART_RATE"
    case burnKcal = "BURN_KCAL"
    case confirm = "CONFIRM"
    
    var localized: LocalizedStringKey {
        return LocalizedStringKey(self.rawValue)
    }
}
