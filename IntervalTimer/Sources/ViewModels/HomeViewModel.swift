//
//  HomeViewModel.swift
//  IntervalTimer
//
//  Created by YoungK on 12/20/23.
//

import Foundation
import SwiftUI
import Combine

public protocol HomeViewModelInput {
}

public protocol HomeViewModelOutput {
    var countOfSets: Int { get }
    var timeOfWarmup: Time { get }
    var timeOfWorkout: Time { get }
    var timeOfRest: Time { get }
    var totalTime: Time { get }
}

typealias HomeViewModelType = HomeViewModelInput & HomeViewModelOutput

final class HomeViewModel: ObservableObject, HomeViewModelType {
    private var subscription = Set<AnyCancellable>()
    
    @Published var countOfSets: Int = 1
    @Published var timeOfWarmup: Time = .init(minutes: 0, seconds: 10)
    @Published var timeOfWorkout: Time = .init(minutes: 0, seconds: 40)
    @Published var timeOfRest: Time = .init(minutes: 0, seconds: 20)
    @Published var totalTime: Time = .init(minutes: 0, seconds: 0)
    
    init() {
        print("✅ HomeViewModel 생성")
        bindInput()
    }
    
    deinit {
        print("❌ HomeViewModel deinit")
    }
    
    private func bindInput() {
        let calculateAndFormatTotalTime: () -> Void = {
            let total = WorkoutState.shared.calculateTotalWorkoutTime(
                sets: self.countOfSets,
                warmup: self.timeOfWarmup,
                workout: self.timeOfWorkout,
                rest: self.timeOfRest
            )
            self.totalTime = total
        }
        
        Publishers.CombineLatest4(
            $countOfSets,
            $timeOfWarmup,
            $timeOfWorkout,
            $timeOfRest
        )
        .receive(on: DispatchQueue.main)
        .sink { output in
            calculateAndFormatTotalTime()
        }
        .store(in: &subscription)
    }
    
    func workoutStart() {
        WorkoutState.shared.startWorkout(sets: countOfSets, warmupTime: timeOfWarmup, workoutTime: timeOfWorkout, restTime: timeOfRest)
    }
    
}
