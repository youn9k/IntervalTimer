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
    var totalTimeText: String { get }
    var countOfSetsText: String { get }
    var timeOfWarmupText: String { get }
    var timeOfWorkoutText: String { get }
    var timeOfRestText: String { get }
}

typealias HomeViewModelType = HomeViewModelInput & HomeViewModelOutput

final class HomeViewModel: ObservableObject, HomeViewModelType {
    private var subscription = Set<AnyCancellable>()
    
    // input
    @Published var selectedCountOfSets: Int = 1
    @Published var selectedMinOfWarmup: Int = 0
    @Published var selectedSecOfWarmup: Int = 40
    @Published var selectedMinOfWorkout: Int = 0
    @Published var selectedSecOfWorkout: Int = 40
    @Published var selectedMinOfRest = 0
    @Published var selectedSecOfRest = 20
    
    // output
    @Published var totalTimeText = "00:00"
    @Published var countOfSetsText = "0"
    @Published var timeOfWarmupText = "00:00"
    @Published var timeOfWorkoutText = "00:00"
    @Published var timeOfRestText = "00:00"
    
    
    init() {
        print("✅ HomeViewModel 생성")
        bindInput()
    }
    
    deinit {
        print("❌ HomeViewModel deinit")
    }
    
    private func bindInput() {
        $selectedCountOfSets.sink { [weak self] count in
            guard let self else { return }
            let text = String(count)
            self.countOfSetsText = text
            
            let totalTime = calculateTotalTime(count: selectedCountOfSets,
                                               warmup: seconds(min: selectedMinOfWarmup, sec: selectedSecOfWarmup),
                                               workout: seconds(min: selectedMinOfWorkout, sec: selectedSecOfWorkout),
                                               rest: seconds(min: selectedMinOfRest, sec: selectedSecOfRest))
            self.totalTimeText = totalTime.toTimeFormat()
        }.store(in: &subscription)
        
        Publishers.CombineLatest($selectedMinOfWarmup, $selectedSecOfWarmup).sink { [weak self] (min, sec) in
            guard let self else { return }
            timeOfWarmupText = seconds(min: min, sec: sec).toTimeFormat()
            
            let totalTime = calculateTotalTime(count: selectedCountOfSets,
                                               warmup: seconds(min: selectedMinOfWarmup, sec: selectedSecOfWarmup),
                                               workout: seconds(min: selectedMinOfWorkout, sec: selectedSecOfWorkout),
                                               rest: seconds(min: selectedMinOfRest, sec: selectedSecOfRest))
            self.totalTimeText = totalTime.toTimeFormat()
        }.store(in: &subscription)
        
        Publishers.CombineLatest($selectedMinOfWorkout, $selectedSecOfWorkout).sink { [weak self] (min, sec) in
            guard let self else { return }
            timeOfWorkoutText = seconds(min: min, sec: sec).toTimeFormat()
            let totalTime = calculateTotalTime(count: selectedCountOfSets,
                                               warmup: seconds(min: selectedMinOfWarmup, sec: selectedSecOfWarmup),
                                               workout: seconds(min: selectedMinOfWorkout, sec: selectedSecOfWorkout),
                                               rest: seconds(min: selectedMinOfRest, sec: selectedSecOfRest))
            self.totalTimeText = totalTime.toTimeFormat()
        }.store(in: &subscription)
        
        Publishers.CombineLatest($selectedMinOfRest, $selectedSecOfRest).sink { [weak self] (min, sec) in
            guard let self else { return }
            timeOfRestText = seconds(min: min, sec: sec).toTimeFormat()
            let totalTime = calculateTotalTime(count: selectedCountOfSets,
                                               warmup: seconds(min: selectedMinOfWarmup, sec: selectedSecOfWarmup),
                                               workout: seconds(min: selectedMinOfWorkout, sec: selectedSecOfWorkout),
                                               rest: seconds(min: selectedMinOfRest, sec: selectedSecOfRest))
            self.totalTimeText = totalTime.toTimeFormat()
        }.store(in: &subscription)
        
    }
    
    private func calculateTotalTime(count: Int, warmup: Int, workout: Int, rest: Int) -> Int {
        let total = warmup + ((workout + rest) * count )
        return total
    }
    
    private func seconds(min: Int, sec: Int) -> Int {
        return min * 60 + sec
    }
    
}

extension Int {
    func toTimeFormat() -> String {
        let min = self / 60
        let sec = self % 60
        return String(format: "%02d:%02d", min, sec)
    }
}
