//
//  BackgroundColorView.swift
//  IntervalTimer
//
//  Created by YoungK on 12/17/23.
//

import SwiftUI

struct BackgroundColorView: View {
    var colors: [Color] = []
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: colors),
                       startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

#Preview {
    BackgroundColorView(colors: [Color.timerSkyBlue, Color.timerMint, Color.timerSkyBlue])
}
