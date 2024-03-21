//
//  SettingViewModel.swift
//  IntervalTimer
//
//  Created by YoungK on 1/25/24.
//

import Foundation
import Combine

public protocol SettingViewModelInput {
}

public protocol SettingViewModelOutput {

}

typealias SettingViewModelType = SettingViewModelInput & SettingViewModelOutput

final class SettingViewModel: ObservableObject, SettingViewModelType {
    private var subscription = Set<AnyCancellable>()
    
    @Published var language = "12"
    
    init() {
        print("✅ SettingViewModel 생성")
    }
    
    deinit {
        print("❌ SettingViewModel deinit")
        subscription.removeAll()
    }
    
    
}
