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
                titleView()
                Spacer().frame(height: 80)
                totalTimeView()
                Spacer().frame(height: 80)
                GlassView(width: APP_WIDTH(), height: 500, cornerRadius: 30) {
                    VStack(spacing: 20) {
                        GlassCardButton(width: APP_WIDTH() - 60, height: 100, icon: "play.circle.fill", title: "준비 운동", content: "00:10", color: .timerGray)
                         GlassCardButton(width: APP_WIDTH() - 60, height: 100, icon: "play.circle.fill", title: "운동", content: "00:10", color: .green)
                         GlassCardButton(width: APP_WIDTH() - 60, height: 100, icon: "play.circle.fill", title: "휴식", content: "00:10", color: .yellow)
                     }
                }
//               VStack(spacing: 20) {
//                   GlassCardButton(width: APP_WIDTH() - 60, height: 100, icon: "play.circle.fill", title: "준비 운동", content: "00:10", color: .timerGray)
//                    GlassCardButton(width: APP_WIDTH() - 60, height: 100, icon: "play.circle.fill", title: "운동", content: "00:10", color: .green)
//                    GlassCardButton(width: APP_WIDTH() - 60, height: 100, icon: "play.circle.fill", title: "휴식", content: "00:10", color: .yellow)
//                }
                Spacer()
            }.ignoresSafeArea(edges: .bottom)
            
        }
        
    }
    
    func titleView() -> some View {
        Text(APP_NAME())
            .font(.TimerFont.bold(size: 24))
            .foregroundStyle(.white)
            .kerning(-1.5)
    }
    
    func totalTimeView() -> some View {
        Text("18:40")
            .font(.TimerFont.bold(size: 80))
            .foregroundStyle(.white)
            .kerning(-1.5)
    }
    
    func gridButtonView() -> some View {
        VStack {
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                })
            }
            
            HStack {
                
            }
            
            HStack {
                
            }
        }
    }
}

#Preview {
    HomeView()
}

struct GlassCardButton: View {
    let width: CGFloat
    let height: CGFloat
    let icon: String
    let title: String
    var content: String
    let color: Color
    
    var body: some View {
        Button(action: {
            
        }, label: {
            GlassView(width: width, height: height) {
                ZStack {
                    color.opacity(0.15)
                    
                    HStack {
                        Label( title: {
                            Text(title)
                                .font(.TimerFont.bold(size: 24))
                                .kerning(-0.75)
                                .foregroundStyle(.black)
                        }, icon: {
                            Image(systemName: icon)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(color)
                        })
                        
                        Spacer()
                        
                        Text(content)
                            .font(.TimerFont.bold(size: 28))
                            .fontWeight(.bold)
                            .kerning(-0.75)
                            .foregroundStyle(color)
                    }
                    .padding(.horizontal, 20)
                    .frame(width: width-20, height: height - 20)
                }
                
                
            }
        })
        
    }
}
