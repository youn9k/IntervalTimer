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
        
        func font(size: CGFloat) -> Font {
            if let uiFont = UIFont(name: self.rawValue, size: size) {
                return Font(uiFont)
            } else {
                return Font.system(size: size)
            }
        }

        static func light(size: CGFloat) -> Font {
            return TimerFont.light.font(size: size)
        }
        
        static func medium(size: CGFloat) -> Font {
            return TimerFont.medium.font(size: size)
        }
        
        static func bold(size: CGFloat) -> Font {
            return TimerFont.bold.font(size: size)
        }
    }

}

