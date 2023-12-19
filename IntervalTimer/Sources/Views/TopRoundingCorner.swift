//
//  TopRoundingCorner.swift
//  IntervalTimer
//
//  Created by YoungK on 12/19/23.
//

import SwiftUI

struct TopRoundingCorner: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
    
}
