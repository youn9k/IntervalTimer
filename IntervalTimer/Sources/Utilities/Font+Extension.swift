//
//  FontSystem.swift
//  IntervalTimer
//
//  Created by YoungK on 12/16/23.
//

import Foundation
import SwiftUI

public extension Font {
    enum TimerFont: String {
        case light = "Inter-Light"
        case medium = "Inter-Medium"
        case bold = "Inter-Bold"
        
        func font(size: CGFloat, weight: Font.Weight) -> Font {
            if let uiFont = UIFont(name: self.rawValue, size: size) {
                return Font(uiFont).weight(weight)
            } else {
                return Font.system(size: size).weight(weight)
            }
        }

        static func light(size: CGFloat) -> Font {
            return TimerFont.light.font(size: size, weight: .light)
        }
        
        static func medium(size: CGFloat) -> Font {
            return TimerFont.medium.font(size: size, weight: .medium)
        }
        
        static func bold(size: CGFloat) -> Font {
            return TimerFont.bold.font(size: size, weight: .bold)
        }
    }

}

