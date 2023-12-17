//
//  MainView.swift
//  IntervalTimer
//
//  Created by YoungK on 12/16/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            BackgroundColorView(colors: [.timerMint])
            VStack {
                titleView()
                Spacer().frame(height: 80)
                totalTimeView()
                Spacer()
            }
            
        }
        
    }
    
    func titleView() -> some View {
        Text(APP_NAME())
            .font(.TimerFont.bold(size: 24))
            .foregroundStyle(.white)
            .kerning(-1.5)
    }
    
    func totalTimeView() -> some View {
        Text("18:40")
            .font(.TimerFont.bold(size: 80))
            .foregroundStyle(.white)
            .kerning(-1.5)
    }
}

#Preview {
    MainView()
}
