//
//  WorkoutView.swift
//  IntervalTimer
//
//  Created by YoungK on 12/16/23.
//

import SwiftUI

struct WorkoutView: View {
    var body: some View {
        ZStack {
            backgroundColorView(.cyan)
            VStack {
                TitleView("운동")
                
                Spacer()
                TimerView()
                    .frame(width: APP_WIDTH() - 80, height: 300)
                
                InfoView()
                    .frame(width: APP_WIDTH() - 80, height: 100)
                    //.background(.green)
                
                Spacer()
                
                playPauseButtonView()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                
                Spacer().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
        //.ignoresSafeArea()
        
        
    }
    
    func backgroundColorView(_ color: Color) -> some View {
        color.ignoresSafeArea()
    }
    
    func TitleView(_ title: String) -> some View {
        Text(title)
            .font(.TimerFont.bold(size: 20))
    }
    
    func TimerView() -> some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 15, height: 15), style: .continuous)
                .foregroundStyle(.white)
                .opacity(0.8)
                .shadow(radius: 10)
            VStack {
                Text("00:09")
                    .font(.custom("Pretendard-Bold", size: 60))
                    .padding(.top, 10)
                Text("남은 시간")
                    .font(.subheadline)
            }
        }
    }
    
    func InfoView() -> some View {
        HStack {
            Image(systemName: "arrow.left")
            
            Spacer()
            
            VStack {
                Text("4/8")
                Text("세트")
            }
            
            Spacer()
            
            VStack {
                Text("05:36")
                Text("운동 시간")
            }

            Spacer()
            
            VStack {
                Text("124")
                Image(systemName: "heart").foregroundStyle(.red)
            }
            
            VStack {
                Text("245 Kcal")
                Text("칼로리")
            }
            
            Spacer()
            
            Image(systemName: "arrow.right")
        }
    }
    
    func playPauseButtonView() -> some View {
        Button(action: {
            
        }, label: {
            Image(systemName: "pause.circle.fill")
                .resizable()
                .foregroundStyle(.white)
                
        })
    }
}

#Preview {
    WorkoutView()
}
