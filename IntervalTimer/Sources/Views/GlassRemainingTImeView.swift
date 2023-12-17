//
//  GlassRemainingTimeView.swift
//  IntervalTimer
//
//  Created by YoungK on 12/17/23.
//

import SwiftUI

struct GlassRemainingTimeView: View {
    var width: CGFloat
    var height: CGFloat
    var totalTime: Double = 0.0 // seconds
    var fillLineColors: [Color]
    var lineWidth: CGFloat
    @State private var remainingTime: TimeInterval
    
    init(width: CGFloat, height: CGFloat, totalTime: Double, fillLineColors: [Color] = [.blue], lineWidth: CGFloat = 5) {
        self.width = width
        self.height = height
        self.totalTime = totalTime
        self.remainingTime = totalTime
        self.fillLineColors = fillLineColors
        self.lineWidth = lineWidth
        self.remainingTime = remainingTime
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.white, lineWidth: lineWidth)
                .frame(width: width, height: height)
                .foregroundColor(.clear)
            
            RoundedRectangle(cornerRadius: 17)
                .trim(from: 0.0, to: lineLength())
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .fill(AngularGradient(gradient: Gradient(colors: fillLineColors), center: .center, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360)))
                .rotationEffect(.degrees(-90))
                .frame(width: height + lineWidth, height: width + lineWidth)
            
            
            Rectangle()
                .frame(width: width, height: height)
                .foregroundColor(.clear)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            VStack {
                Text(timeString())
                    .font(.TimerFont.bold(size: 80))
                    .foregroundStyle(.white)
                    .kerning(-0.75)
                Text("남은 시간")
                    .font(.TimerFont.medium(size: 16))
                    .foregroundStyle(.white)
                    .kerning(-0.75)
            }
        }
        
        .onAppear {
            startTimer()
        }
    }
    
    func lineLength() -> CGFloat {
        let progress = 1.0 - (remainingTime / totalTime)
        return progress
    }
    
    func timeString() -> String {
        let remainingTime = max(remainingTime, 0)
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func startTimer() {
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            withAnimation {
                if remainingTime > 0 {
                    remainingTime -= 1.0
                } else {
                    timer.invalidate()
                }
            }
        }
    }
}

struct RectangleClockView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            WorkoutView()
            //GlassRemainingTimeView(width: 300, height: 300, totalTime: 10, lineColors: [.indigo], lineWidth: 5)
        }
        
    }
}
