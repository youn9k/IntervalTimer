//
//  SettingView.swift
//  IntervalTimer
//
//  Created by YoungK on 1/12/24.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        VStack {
            
            titleBar()
                .frame(height: 40)
            
            languageSettingView()
                .frame(height: 50)
            
            
            Spacer()
            
        }
        .background(backgroundGradientView().ignoresSafeArea(edges: .top))
        
        
    }
    
    func backgroundGradientView() -> some View {
        LinearGradient(colors: [Color.white, Color(hex: "D9D9D9")], startPoint: .top, endPoint: .bottom)
    }
    
    func titleBar() -> some View {
        Rectangle()
            .foregroundStyle(Color(hex: "D9D9D9"))
            .overlay(alignment: .leading) {
                Text("Preferences")
                    .font(.TimerFont.bold(size: 15))
                    .foregroundStyle(.white)
                    .padding(.leading, 20)
            }
    }
    
    func languageSettingView() -> some View {
        HStack {
            Image(systemName: "globe")
                .resizable()
                .frame(width: 30, height: 30)
                .padding(.trailing, 10)
            
            Text(Strings.language.localized)
                .font(.TimerFont.bold(size: 15))
                .foregroundStyle(.black)
            
            Spacer()
            
            Text(UserState.shared.isSoundEnabled.description)
            
        }
        .padding(.horizontal, 10)
    }
    
    
}

#Preview {
    SettingView()
}
