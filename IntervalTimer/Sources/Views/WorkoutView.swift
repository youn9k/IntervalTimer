//
//  WorkoutView.swift
//  IntervalTimer
//
//  Created by YoungK on 12/16/23.
//

import SwiftUI

struct WorkoutView: View {
    @State var workoutProgress: Double = 0.0
    
    let info1 = [WorkoutInfo(title: "세트", Content: "4/8"), WorkoutInfo(title: "운동시간", Content: "05:36"), WorkoutInfo(title: "심박수", Content: "124")]
    let info2 = [WorkoutInfo(title: "세트수", Content: "4/8"), WorkoutInfo(title: "운동시간", Content: "05:36"), WorkoutInfo(title: "칼로리", Content: "2456 Kcal")]
    
    var body: some View {
        ZStack {
            BackgroundColorView(colors: [Color.timerBlue])
//            Image(.test)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .ignoresSafeArea()
            
            VStack {
                TitleView("운동")
                
                Spacer().frame(height: 60)
                
                GlassRemainingTimeView(width: APP_WIDTH() - 80, height: 300, totalTime: 10, fillLineColors: [.indigo], lineWidth: 3)
                
                Spacer().frame(height: 15)
                
                CarouselView(pageCount: 2, visibleEdgeSpace: 1, spacing: 60) { _ in
                    GlassWorkoutInfoView(width: APP_WIDTH() - 80, height: 100, workoutInfos: info1)
                    GlassWorkoutInfoView(width: APP_WIDTH() - 80, height: 100, workoutInfos: info2)
                    Spacer()
                }
                .frame(height: 100)
                //.background(.yellow)

                Spacer()
                
                playPauseButtonView(isPlaying: true)
                    .frame(width: 100, height: 100)
                
                Spacer()
            }
        }

    }
    
    func TitleView(_ title: String) -> some View {
        Text(title)
            .font(.TimerFont.bold(size: 24))
            .kerning(-0.75)
            .foregroundStyle(.white)
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
