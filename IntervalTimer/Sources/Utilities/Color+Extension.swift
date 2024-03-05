//
//  Color.swift
//  IntervalTimer
//
//  Created by YoungK on 1/6/24.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = (rgbValue & 0xff0000) >> 16
        let green = (rgbValue & 0xff00) >> 8
        let blue = rgbValue & 0xff
        
        self.init(red: Double(red)/0xff, green: Double(green)/0xff, blue: Double(blue)/0xff)
    }
    
}
