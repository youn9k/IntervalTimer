//
//  RectangleClockView.swift
//  IntervalTimer
//
//  Created by YoungK on 12/17/23.
//

import SwiftUI

struct RectangleClockView: View {
    var width: CGFloat
    var height: CGFloat
    var totalTime: Double = 0.0 // seconds
    var lineColors: [Color]
    var lineWidth: CGFloat
    var rectangleColor: Color
    @State private var remainingTime: TimeInterval
    
    init(width: CGFloat, height: CGFloat, totalTime: Double, lineColors: [Color] = [.blue], lineWidth: CGFloat = 5, rectangleColor: Color = .white) {
        self.width = width
        self.height = height
        self.totalTime = totalTime
        self.remainingTime = totalTime
        self.lineColors = lineColors
        self.lineWidth = lineWidth
        self.rectangleColor = rectangleColor
        self.remainingTime = remainingTime
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .trim(from: 0.0, to: lineLength())
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .fill(AngularGradient(gradient: Gradient(colors: lineColors), center: .center, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360)))
                .rotationEffect(.degrees(-90))
                .frame(width: height + lineWidth, height: width + lineWidth)
            
            
            RoundedRectangle(cornerRadius: 15)
                .frame(width: width, height: height)
                //.foregroundColor(rectangleColor)
                //.opacity(0.8)
                .background(.ultraThinMaterial)
                .shadow(radius: 3)
            
            VStack {
                Text(timeString())
                    .font(.custom("Pretendard-Bold", size: 60))
                    .kerning(-0.5)
                    .padding(.top, 10)
                Text("남은 시간")
                    .font(.subheadline)
                    .kerning(-0.5)
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
                    //remainingTime = totalTime
                }
            }
        }
    }
}

struct RectangleClockView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleClockView(width: 300, height: 300, totalTime: 10, lineColors: [.timerWhite], lineWidth: 7)
        RectangleClockView(width: 300, height: 300, totalTime: 10, lineColors: [.timerSkyBlue, .blue, .timerSkyBlue, .blue, .timerSkyBlue, .blue])
    }
}
