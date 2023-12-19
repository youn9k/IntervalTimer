//
//  HomeVIew.swift
//  IntervalTimer
//
//  Created by YoungK on 12/18/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            BackgroundColorView(colors: [.timerMint, .timerBlue, .timerMint])
            VStack {
                Spacer().frame(height: 30)
                totalTimeView()
                Spacer()
                //.frame(height: 60)
                
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        Button(action: {
                            print(APP_HEIGHT())
                        }, label: {
                            setupView(icon: "arrow.counterclockwise.circle.fill", title: "세트 수", time: "5", color: .timerGray)
                        }).frame(width: 170, height: 120)
                        
                        Button(action: {
                            
                        }, label: {
                            setupView(icon: "figure.walk.circle.fill", title: "준비 운동", time: "00:40", color: .blue)
                        }).frame(width: 170, height: 120)
                    }
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            
                        }, label: {
                            setupView(icon: "figure.run.circle.fill", title: "운동", time: "00:40", color: .green)
                        }).frame(width: 170, height: 120)
                        
                        Button(action: {
                            
                        }, label: {
                            setupView(icon: "pause.circle.fill", title: "휴식", time: "00:20", color: .yellow)
                        }).frame(width: 170, height: 120)
                    }
                    
                    startButton()
                        .padding(.top, 10)
                    
                    Spacer().frame(height: 56 + SAFEAREA_BOTTOM_HEIGHT())
                }
            }
            
        }
        
    }
    
    func totalTimeView() -> some View {
        
        VStack {
            Text("총 운동 시간")
                .font(.TimerFont.bold(size: 20))
                .foregroundStyle(.white)
                .kerning(-1.5)
                .opacity(0.8)
            
            Text("18:40")
                .font(.TimerFont.bold(size: 80))
                .foregroundStyle(.white)
                .kerning(-1.5)
        }
        
        
    }
    
    func startButton() -> some View {
        Button(action: {
            
        }, label: {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 80)
                .padding(.horizontal, 20)
                .foregroundStyle(.green)
                .shadow(radius: 8)
                .overlay {
                    Text("운동 시작")
                        .font(.TimerFont.bold(size: 28))
                        .fontWeight(.bold)
                        .kerning(-0.75)
                        .foregroundStyle(.white)
                }
        })
    }
    
    func setupView(icon: String, title: String, time: String, color: Color) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(.white)
            .shadow(radius: 8)
            .overlay {
                GeometryReader { proxy in
                    let size = proxy.size
                    VStack {
                        HStack {
                            Text(title)
                                .font(.TimerFont.bold(size: 16))
                                .kerning(-0.75)
                                .foregroundStyle(.gray)
                            
                            Spacer()
                            
                            Image(systemName: icon)
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundStyle(color)
                        }
                        
                        Text(time)
                            .font(.TimerFont.bold(size: 36))
                            .fontWeight(.semibold)
                            .kerning(-0.75)
                            .foregroundStyle(color)
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .frame(width: size.width, height: size.height)
                }
                
            }
    }
    
}

#Preview {
    
    HomeView()
    
}
