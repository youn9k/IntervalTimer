//
//  WorkoutView.swift
//  IntervalTimer
//
//  Created by YoungK on 12/16/23.
//

import SwiftUI

struct WorkoutView: View {
    @State var workoutProgress: Double = 0.0
    
    var body: some View {
        ZStack {
            BackgroundColorView(colors: [Color.timerSkyBlue, Color.timerMint, Color.timerSkyBlue])
            VStack {
                TitleView("운동")
                    .kerning(-0.5)
                
                Spacer()
                
                RectangleClockView(width: APP_WIDTH() - 80, height: 300, totalTime: 10, lineColors: [.white], lineWidth: 7, rectangleColor: .timerIvory)
                
                InfoView()
                    .frame(width: APP_WIDTH() - 80, height: 100)

                Spacer()
                
                playPauseButtonView(isPlaying: true)
                    .frame(width: 100, height: 100)
                
                Spacer().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }

    }
    
    func TitleView(_ title: String) -> some View {
        Text(title)
            .font(.TimerFont.bold(size: 24))
            .foregroundStyle(.white)
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
            
            VStack(spacing: 2) {
                HStack(spacing: 0) {
                    Text("124")
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(.red)
                }
                Text("심박수")
            }
            
            VStack {
                Text("245 Kcal")
                Text("칼로리")
            }
            
            Spacer()
            
            Image(systemName: "arrow.right")
        }
    }
    
    func playPauseButtonView(isPlaying: Bool) -> some View {
        return isPlaying ? Button(action: {
            
        }, label: {
            Image(systemName: "pause.circle.fill")
                .resizable()
                .foregroundStyle(.white)
                .shadow(radius: 5)
                
        }) : Button(action: {
            
        }, label: {
            Image(systemName: "play.circle.fill")
                .resizable()
                .foregroundStyle(.white)
                .shadow(radius: 5)
                
        })
    }
}

#Preview {
    WorkoutView()
}
