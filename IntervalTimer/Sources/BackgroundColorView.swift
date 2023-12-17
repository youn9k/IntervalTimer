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
        //AngularGradient(colors: colors, center: .topLeading, angle: Angle(degrees: 55))
        AngularGradient(gradient: Gradient(colors: colors), center: .center, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360))
        //LinearGradient(gradient: Gradient(colors: colors),
        //              startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

#Preview {
    BackgroundColorView(colors: [Color.timerRed, Color.timerSkyBlue, Color.timerSkyBlue, Color.timerYellow])
}

struct BackgroundColorView2: View {
    var colors: [Color] = []
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            Circle()
                .foregroundStyle(.timerSkyBlue)
                .frame(width: 300, height: APP_HEIGHT())
                //.blur(radius: 50)
            
            Circle()
                .foregroundStyle(.timerMint)
                .frame(width: 200, height: 200)
                .blur(radius: 10)
                .offset(x: 50, y: -200)
            
            Circle()
                .foregroundStyle(.timerRed)
                .frame(width: 200, height: 200)
                .blur(radius: 10)
                .offset(x: -50, y: 200)
        }
        
        .background(.yellow)
    }
}
