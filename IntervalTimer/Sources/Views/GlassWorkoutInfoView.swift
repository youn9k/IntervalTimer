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
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.white, lineWidth: 3)
                .frame(width: width, height: height)
                .foregroundColor(.clear)
            
            Rectangle()
                .frame(width: width, height: height)
                .foregroundColor(.clear)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay {
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
                }
        }
    }
}

#Preview {
    WorkoutView()
}
