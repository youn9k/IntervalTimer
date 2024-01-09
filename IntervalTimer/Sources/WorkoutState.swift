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
    
    @Published var phase: Phase
    @Published var remainTotalTime: Time
    @Published var workoutPhases: [PhaseInfo]
    private var timerSubscription: AnyCancellable?

    private init() {
        print("✅ WorkoutState init")
        self.remainTotalTime = Time(seconds: 0)
        self.phase = .warmup
        self.workoutPhases = []
    }
    
    deinit { print("❌ WorkoutState deinit") }
    
}

extension WorkoutState {
    func startWorkout(time: Time) {
        cancelTimer()
        popWorkoutPhase()
        startTimer()
    }
    
    private func startTimer() {
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
        } else { // 타이머 종료 시 처리
            cancelTimer()
            if !workoutPhases.isEmpty { // 남은 페이즈가 있으면
                popWorkoutPhase()
                startTimer()
            }
        }
    }
    
    private func popWorkoutPhase() {
        let newPhase = workoutPhases.removeFirst()
        updateState(newPhase.state)
        remainTotalTime = newPhase.time
        
    }
    
    private func updateState(_ newState: Phase) {
        self.phase = newState
    }
}

extension WorkoutState {
    struct PhaseInfo {
        var state: Phase
        var time: Time
    }
    
    func createPhases(sets: Int, warmupTime: Time, workoutTime: Time, restTime: Time) {
        var phases: [PhaseInfo] = []
        
        phases.append(PhaseInfo(state: .warmup, time: warmupTime))
        
        for setIndex in 0..<sets {
            phases.append(PhaseInfo(state: .workout, time: workoutTime))
            
            if setIndex < sets - 1 {
                phases.append(PhaseInfo(state: .rest, time: restTime))
            }
        }
        
        self.workoutPhases = phases
    }
}

extension WorkoutState {
    enum Phase {
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
