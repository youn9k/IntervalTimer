//
//  WorkoutViewModel.swift
//  IntervalTimer
//
//  Created by YoungK on 12/20/23.
//

import Foundation
import Combine

public protocol WorkoutViewModelInput {
}

public protocol WorkoutViewModelOutput {
    var progressTime: Time { get }
    var workoutProgress: Double { get }
}

typealias WorkoutViewModelType = WorkoutViewModelInput & WorkoutViewModelOutput

class WorkoutViewModel: ObservableObject, WorkoutViewModelType {
    private var subscription = Set<AnyCancellable>()
    private var workoutState = WorkoutState.shared
    
    @Published var progressTime: Time
    @Published var workoutProgress: Double
    @Published var showCongratuation: Bool
    
    init() {
        print("✅ WorkoutViewModel 생성")
        progressTime = .init()
        workoutProgress = 0
        showCongratuation = false
        bindOutput()
    }
    
    deinit {
        print("❌ WorkoutViewModel deinit")
        subscription.removeAll()
    }
    
    private func bindOutput() {
        workoutState.$progressTime
            .assign(to: \.progressTime, on: self)
            .store(in: &subscription)
        
        workoutState.$progressTime
            .filter { [weak self] _ in
                return (self?.workoutState.totalWorkoutTime.totalSeconds ?? 0 > 0)
            }
            .sink { [weak self] time in
                guard let self else { return }
                let total = self.workoutState.totalWorkoutTime.totalSeconds
                let current = time.totalSeconds
                let progress = Double(current) / Double(total)
                self.workoutProgress = progress
            }
            .store(in: &subscription)
        
        workoutState.workoutFinished.sink { [weak self] _ in
            self?.showCongratuation = true
        }.store(in: &subscription)
    }
    
}
