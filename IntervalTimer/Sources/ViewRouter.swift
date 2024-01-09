//
//  ViewRouter.swift
//  IntervalTimer
//
//  Created by YoungK on 1/4/24.
//

import Foundation

enum ViewType {
    case home, workout, congratuation, setting
}

class ViewRouter: ObservableObject {
    static let shared = ViewRouter()
    
    @Published var viewType: ViewType
    
    private init() {
        print("✅ ViewRouter init")
        self.viewType = .workout
    }
    
    deinit { print("❌ ViewRouter deinit") }
    
    func change(to viewType: ViewType) {
        self.viewType = viewType
    }
    
    
}
