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
    var workoutProgress: Double { get }
}

typealias WorkoutViewModelType = WorkoutViewModelInput & WorkoutViewModelOutput

class WorkoutViewModel: ObservableObject, WorkoutViewModelType {
    private var subscription = Set<AnyCancellable>()
    private var workoutState = WorkoutState.shared
    
    @Published var workoutProgress: Double
    
    init() {
        print("✅ WorkoutViewModel 생성")
        workoutProgress = 0
        
        bindOutput()
    }
    
    deinit {
        print("❌ WorkoutViewModel deinit")
        subscription.removeAll()
    }
    
    private func bindOutput() {
        workoutState.$recordTime
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
    }
    
}
