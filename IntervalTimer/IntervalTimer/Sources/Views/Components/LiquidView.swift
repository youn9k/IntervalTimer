//
//  SlimeView.swift
//  IntervalTimer
//
//  Created by YoungK on 1/5/24.
//

import SwiftUI
import Liquid

struct LiquidView: View {
    var color: Color = .blue
    var body: some View {
        Liquid(samples: 6, period: 1)
            .foregroundStyle(color)
    }
}

#Preview {
    VStack {
        LiquidView(color: ColorLiterals.timerBlue)
            .frame(width: 300, height: 200)
    }.frame(width: APP_WIDTH(), height: APP_HEIGHT())
    
}
