//
//  GlassWorkoutInfoView.swift
//  IntervalTimer
//
//  Created by YoungK on 12/17/23.
//

import SwiftUI

struct WorkoutInfo: Identifiable {
    var id = UUID()
    var title: String
    var Content: String
}

struct GlassWorkoutInfoView: View {
    var width: CGFloat
    var height: CGFloat
    @State var workoutInfos: [WorkoutInfo]
    
    var body: some View {
        GlassView(width: width, height: height, content: {
            HStack {
                Spacer().frame(width: 15)
                
                ForEach(workoutInfos) { info in
                    VStack {
                        Text(info.Content)
                        Text(info.title)
                    }
                    .frame(width: 80)
                }
                
                Spacer().frame(width: 15)
            }
            .foregroundStyle(.white)
            .font(.TimerFont.medium(size: 16))
            .kerning(-0.75)
            .lineLimit(1)
        })
    }
}

#Preview {
    WorkoutView()
}
