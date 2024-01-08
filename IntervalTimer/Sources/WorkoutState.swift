//
//  WorkoutState.swift
//  IntervalTimer
//
//  Created by YoungK on 1/8/24.
//

import SwiftUI
import Combine



final class WorkoutState: ObservableObject {
    static let shared = WorkoutState()
    
    @Published var state: State
    @Published var remainTotalTime: Time
    @Published var workoutPhases: [WorkoutPhase]
    private var timerSubscription: AnyCancellable?

    private init() {
        print("✅ WorkoutState init")
        self.remainTotalTime = Time(seconds: 0)
        self.state = .warmup
        self.workoutPhases = []
    }
    
    deinit { print("❌ WorkoutState deinit") }
    
}

extension WorkoutState {
    func startWorkout(time: Time) {
        updateState(.warmup)
        
    }
    
    private func updateState(_ newState: State) {
        self.state = newState
    }
    
    private func startTimer() {
        cancelTimer() // 이전 타이머 취소
        
        timerSubscription = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.handleTimerTick()
            }
            
    }
    
    private func cancelTimer() {
        timerSubscription?.cancel()
    }
    
    private func handleTimerTick() {
        if remainTotalTime.totalSeconds > 0 {
            remainTotalTime.minus(1)
        } else {
//            switch state {
//            case .warmup:
//                
//            case .workout:
//                
//            case .rest:
//                
//            case .pause:
//                
//            }
        }
    }
}

extension WorkoutState {
    struct WorkoutPhase {
        var state: State
        var time: Time
    }
}

extension WorkoutState {
    enum State {
        case warmup, workout, rest, pause
        
        var title: LocalizedStringKey {
            switch self {
            case .warmup:
                return "WARM_UP"
            case .workout:
                return "WORK_OUT"
            case .rest:
                return "REST"
            case .pause:
                return "PAUSE"
            }
        }
        
        var gradientColors: (first: Color, second: Color) {
            switch self {
            case .warmup:
                return (Color(hex: "8FE681"), Color(hex: "CEFFC6"))
            case .workout:
                return (Color(hex: "54B3F4"), Color(hex: "AFFCEA"))
            case .rest:
                return (Color(hex: "FFB13B"), Color(hex: "FFEDA4"))
            case .pause:
                return (Color(hex: "FF5138"), Color(hex: "FF7561"))
            }
        }
    }
}
