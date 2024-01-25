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
    
    @Published var currentPhase: Phase
    @Published var workoutPhases: [PhaseInfo]
    @Published var remainPhaseTime: Time // 현재 페이즈에서 남은 시간
    @Published var progressTime: Time // 진행한 시간
    @Published var totalSetsCount: Int
    @Published var currentSetsCount: Int
    @Published var totalWorkoutTime: Time // 전체 운동 시간
    
    var workoutFinished: PassthroughSubject<Bool, Never>
    var phaseChanged: PassthroughSubject<Bool, Never>
    
    private var phaseTimerSubscription: AnyCancellable?
    private var progressTimerSubscription: AnyCancellable?
    
    @Published private(set) var isPaused: Bool
    private var tempPhase: Phase?
    
    private var subscriptions = Set<AnyCancellable>()

    private init() {
        print("✅ WorkoutState init")
        self.remainPhaseTime = Time()
        self.progressTime = Time()
        self.currentPhase = .warmup
        self.workoutPhases = []
        self.isPaused = false
        self.totalSetsCount = 0
        self.currentSetsCount = 0
        self.totalWorkoutTime = Time()
        self.workoutFinished = .init()
        self.phaseChanged = .init()
    }
    
    deinit { print("❌ WorkoutState deinit") }
    
}

// MARK: - 외부에서 접근가능한 메소드들

extension WorkoutState {
    func startWorkout(sets: Int, warmupTime: Time, workoutTime: Time, restTime: Time) {
        clearWorkout()
        
        createPhases(sets: sets, warmupTime: warmupTime, workoutTime: workoutTime, restTime: restTime)
        self.totalSetsCount = sets
        self.totalWorkoutTime = calculateTotalWorkoutTime(sets: sets, warmup: warmupTime, workout: workoutTime, rest: restTime)
        
        if !workoutPhases.isEmpty { // 남은 페이즈가 있으면
            let newPhase = popWorkoutPhase()
            updatePhase(newPhase.state)
            remainPhaseTime = newPhase.time
            startPhaseTimer()
            startProgressTimer()
        }
    }
    
    func pauseWorkout() {
        isPaused = true
        self.tempPhase = currentPhase
        self.currentPhase = .pause
    }
    
    func resumeWorkout() {
        isPaused = false
        if let tempPhase {
            self.currentPhase = tempPhase
        }
    }
    
    func clearWorkout() {
        self.cancelPhaseTimer()
        self.cancelProgressTimer()
        
        self.remainPhaseTime = Time()
        self.progressTime = Time()
        self.currentPhase = .warmup
        self.workoutPhases = []
        self.isPaused = false
        self.totalSetsCount = 0
        self.currentSetsCount = 0
        self.totalWorkoutTime = Time()
        self.workoutFinished = .init()
        self.phaseChanged = .init()
    }
    
    func calculateTotalWorkoutTime(sets: Int, warmup: Time, workout: Time, rest: Time) -> Time {
        let warmup = warmup.totalSeconds
        let workout = workout.totalSeconds
        let rest = rest.totalSeconds
        
        let total = warmup + ((workout + rest) * sets )
        let min = total / 60
        let sec = total % 60
        return Time(minutes: min, seconds: sec)
    }
    
}

// MARK: - 타이머 관련

extension WorkoutState {
    private func startPhaseTimer() {
        phaseTimerSubscription = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self, !self.isPaused else { return }
                self.handleTimerTick()
            }
    }
    
    private func cancelPhaseTimer() {
        phaseTimerSubscription?.cancel()
        phaseTimerSubscription = nil
    }
    
    private func handleTimerTick() {
        if remainPhaseTime.totalSeconds > 0 {
            remainPhaseTime.minus(1)
        } else { // 페이즈 타이머 종료 시 처리
            cancelPhaseTimer()
            
            if !workoutPhases.isEmpty { // 남은 페이즈가 있으면
                let newPhase = popWorkoutPhase()
                updatePhase(newPhase.state)
                remainPhaseTime = newPhase.time
                if newPhase.state == .workout { self.currentSetsCount += 1 }
                startPhaseTimer()
                
            } else { // 남은 페이즈가 없음 -> 운동 종료
                workoutFinished.send(true)
                cancelPhaseTimer()
                cancelProgressTimer()
            }
        }
    }
    
    private func startProgressTimer() {
        progressTimerSubscription = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self, !self.isPaused else { return }
                self.progressTime.plus(1)
            }
    }
    
    private func cancelProgressTimer() {
        progressTimerSubscription?.cancel()
        progressTimerSubscription = nil
    }
}

// MARK: - Phase 관련

extension WorkoutState {
    struct PhaseInfo {
        var state: Phase
        var time: Time
    }
    
    private func createPhases(sets: Int, warmupTime: Time, workoutTime: Time, restTime: Time) {
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
    
    private func popWorkoutPhase() -> PhaseInfo {
        return workoutPhases.removeFirst()
    }
    
    private func updatePhase(_ newState: Phase) {
        self.currentPhase = newState
        self.phaseChanged.send(true)
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
        
        var gradientColors: [Color] {
            switch self {
            case .warmup:
                return [Color(hex: "8FE681"), Color(hex: "CEFFC6")]
            case .workout:
                return [Color(hex: "54B3F4"), Color(hex: "AFFCEA")]
            case .rest:
                return [Color(hex: "FFB13B"), Color(hex: "FFEDA4")]
            case .pause:
                return [Color(hex: "FF5138"), Color(hex: "FF7561")]
            }
        }
    }
}
