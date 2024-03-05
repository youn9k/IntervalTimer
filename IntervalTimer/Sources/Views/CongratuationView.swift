//
//  CongratuationView.swift
//  IntervalTimer
//
//  Created by YoungK on 1/12/24.
//

import SwiftUI

struct CongratuationView: View {
    @Environment(\.dismiss) private var dismiss
    
    let totalWorkoutTIme: String?
    let highHeartRate: String?
    let avgHeartRate: String?
    let burnKcal: String?
    
    init(totalWorkoutTIme: String? = nil, highHeartRate: String?  = nil, avgHeartRate: String?  = nil, burnKcal: String?  = nil) {
        self.totalWorkoutTIme = totalWorkoutTIme
        self.highHeartRate = highHeartRate
        self.avgHeartRate = avgHeartRate
        self.burnKcal = burnKcal
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            Spacer(minLength: 32)
            
            ImageLiterals.checkGreen
                .resizable()
                .frame(width: 80, height: 80)
                .shadow(radius: 20, x: 0, y: 4)
                .padding(.bottom, 36)
            
            Text(Strings.congratuation.localized)
                .font(.TimerFont.bold(size: 16))
                .foregroundStyle(Color(hex: "9D9D9D"))
            
            Text(Strings.workoutFinish.localized)
                .font(.TimerFont.bold(size: 36))
                .foregroundStyle(Color.black)
                .padding(.bottom, 28)
            
            VStack(spacing: 15) {
                divider()
                
                workoutInfo(title: Strings.totalWorkoutTime.localized, content: totalWorkoutTIme ?? "", isHighlited: true)
                
                divider()
                                
                workoutInfo(title: Strings.highHeartRate.localized, content: highHeartRate ?? "--" + " BPM")
                
                divider()
                
                workoutInfo(title: Strings.avgHeartRate.localized, content: avgHeartRate ?? "--" + " BPM")
                
                divider()
                
                workoutInfo(title: Strings.burnKcal.localized, content: burnKcal ?? "--" + " Kcal")
                
                divider()
            }
            .padding(.horizontal, 60)
            .padding(.bottom, 44)
            
            confirmButton()
                .frame(width: 325, height: 80)
            
            Spacer(minLength: 83)
            
        }
    }
    
    func divider() -> some View {
        Color(hex: "9E9E9E").frame(height: 1)
    }

    
    func workoutInfo(title: LocalizedStringKey, content: String, isHighlited: Bool = false) -> some View {
        HStack {
            Text(title)
                .font(.TimerFont.bold(size: 16))
                .foregroundStyle(Color(hex: "9D9D9D"))
            Spacer()
            Text(content)
                .font(.TimerFont.bold(size: 16))
                .foregroundStyle(isHighlited ? Color(hex: "FF543C") : Color.black)
        }
    }
    
    func confirmButton() -> some View {
        Button(action: {
            dismiss()
            ViewRouter.shared.change(to: .home)
        }, label: {
            RoundedRectangle(cornerRadius: 25)
                .overlay {
                    Text(Strings.confirm.localized)
                        .font(.TimerFont.bold(size: 20))
                        .foregroundStyle(Color.white)
                }
                .foregroundStyle(Color(hex: "8FE681"))
                .shadow(radius: 20, x: 0, y: 8)
        })
        .buttonStyle(ScaledButtonStyle())
    }
}

#Preview {
    CongratuationView(totalWorkoutTIme: "42분 32초", highHeartRate: "180 BPM", avgHeartRate: "158 BPM", burnKcal: "562 Kcal")
}
