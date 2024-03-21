//
//  CongratuationViewModel.swift
//  IntervalTimer
//
//  Created by YoungK on 1/12/24.
//

import Foundation
import Combine

public protocol CongratuationViewModelInput {
}

public protocol CongratuationViewModelOutput {
}

typealias CongratuationViewModelType = CongratuationViewModelInput & CongratuationViewModelOutput

class CongratuationViewModel: ObservableObject, CongratuationViewModelType {
    private var subscription = Set<AnyCancellable>()

    init() {
        print("✅ HomeViewModel 생성")
    }
    
    deinit {
        print("❌ HomeViewModel deinit")
        subscription.removeAll()
    }
    
}
