//
//  UserState.swift
//  IntervalTimer
//
//  Created by YoungK on 1/25/24.
//

import Foundation

class UserState: ObservableObject {
    static let shared = UserState()
    
    @Published var language: Language
    @Published var isSoundEnabled: Bool
    @Published var isVibrationEnabled: Bool
    
    private init() {
        print("✅ UserState init")
        self.language = .ko
        self.isSoundEnabled = true
        self.isVibrationEnabled = true
        
        getLanguage()
    }
    
    deinit { print("❌ UserState deinit") }
    
}

extension UserState {
    func getLanguage() {
        let language = UserDefaults.standard.array(forKey: "AppleLanguages")?.first as! String // 초기에 "ko-KR" , "en-KR" 등으로 저장되어있음
        let index = language.index(language.startIndex, offsetBy: 2)
        let languageCode = String(language[..<index]) //"ko" , "en" 등
        
        print("🚀", languageCode)
    }
    
    func setLanguage(to language: Language) {
        UserDefaults.standard.set([language.rawValue], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
}
