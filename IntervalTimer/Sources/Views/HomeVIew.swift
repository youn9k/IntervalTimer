//
//  HomeVIew.swift
//  IntervalTimer
//
//  Created by YoungK on 12/18/23.
//

import SwiftUI

struct SetupWorkoutInfo: Identifiable {
    var id = UUID()
    var icon: String
    var title: String
    var time: String
    var theme: Color
}

struct HomeView: View {
    let tempSetupWorkoutInfos = [
        SetupWorkoutInfo(icon: "arrow.counterclockwise.circle.fill", title: "NUM_OF_SETS", time: "5", theme: .timerGray),
        SetupWorkoutInfo(icon: "figure.walk.circle.fill", title: "WARM_UP", time: "00:40", theme: .blue),
        SetupWorkoutInfo(icon: "figure.run.circle.fill", title: "WORKOUT", time: "00:40", theme: .green),
        SetupWorkoutInfo(icon: "pause.circle.fill", title: "REST", time: "00:20", theme: .yellow)
    ]
    
    
    var body: some View {
        ZStack {
            BackgroundColorView(colors: [.timerMint, .timerBlue, .timerMint])
            VStack {
                Spacer().frame(height: 30)
                totalTimeView()
                Spacer()
                
                VStack(spacing: 20) {
                    HStack(spacing: 15) {
                        ForEach(tempSetupWorkoutInfos[0..<2]) { info in
                            Button(action: {
                                print(APP_HEIGHT())
                            }, label: {
                                setupView(info: info)
                            })
                            .buttonStyle(ScaledButtonStyle())
                            .frame(width: 170, height: 120)
                        }
                    }
                    HStack(spacing: 15) {
                        ForEach(tempSetupWorkoutInfos[2...]) { info in
                            Button(action: {
                                print(APP_HEIGHT())
                            }, label: {
                                setupView(info: info)
                            })
                            .buttonStyle(ScaledButtonStyle())
                            .frame(width: 170, height: 120)
                        }
                    }
                }.padding(.horizontal, 20)
                
                VStack {
                    startButton()
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                    
                    Spacer().frame(height: 56 + SAFEAREA_BOTTOM_HEIGHT())
                }
            }
            
        }
        
    }
    
    func totalTimeView() -> some View {
        
        VStack {
            Text("TOTAL_WORKOUT_TIME")
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
                .foregroundStyle(LinearGradient(colors: [.indigo, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                .shadow(radius: 8)
                .overlay {
                    Text("WORKOUT_START")
                        .font(.TimerFont.bold(size: 24))
                        .fontWeight(.bold)
                        .kerning(-0.75)
                        .foregroundStyle(.white)
                }
        })
        .buttonStyle(ScaledButtonStyle())
    }
    
    func setupView(info: SetupWorkoutInfo) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(.white)
            .shadow(radius: 8)
            .overlay {
                GeometryReader { proxy in
                    let size = proxy.size
                    VStack {
                        HStack {
                            Text(LocalizedStringKey(info.title))
                                .font(.TimerFont.bold(size: 16))
                                .kerning(-0.75)
                                .foregroundStyle(.gray)
                            
                            Spacer()
                            
                            Image(systemName: info.icon)
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundStyle(info.theme)
                        }
                        
                        Text(info.time)
                            .font(.TimerFont.bold(size: 36))
                            .fontWeight(.semibold)
                            .kerning(-0.75)
                            .foregroundStyle(info.theme)
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .frame(height: size.height)
                }
                
            }
    }
    
}

#Preview {
    MainView()
}

struct ScaledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.85 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
