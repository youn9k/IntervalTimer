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
    
    @State var selectedSetupWorkoutInfo: SetupWorkoutInfo?
    @State var showDetailPage: Bool = false
    @State private var selectedMinute = 0
    @State private var selectedSecond = 30
    @State private var selectedCountOfSets = 1
    @Namespace var animation
    
    @State var animateDetailView: Bool = false
    @State var animateDetailViewContent: Bool = false
    @State var animateDetailViewBackground: Bool = false
    
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
                                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.25)) {
                                    selectedSetupWorkoutInfo = info
                                    showDetailPage = true
                                }
                            }, label: {
                                cardView(info: info)
                                    .scaleEffect(selectedSetupWorkoutInfo?.id == info.id && showDetailPage ? 1.2 : 1)
                                    .opacity(selectedSetupWorkoutInfo?.id == info.id && showDetailPage ? 0.2 : 1)
                            })
                            .buttonStyle(ScaledButtonStyle())
                            .opacity(showDetailPage ? (selectedSetupWorkoutInfo?.id == info.id ? 1 : 0) : 1)
                            .frame(width: 170, height: 120)
                        }
                    }
                    HStack(spacing: 15) {
                        ForEach(tempSetupWorkoutInfos[2...]) { info in
                            Button(action: {
                                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.25)) {
                                    selectedSetupWorkoutInfo = info
                                    showDetailPage = true
                                }
                            }, label: {
                                cardView(info: info)
                                    .scaleEffect(selectedSetupWorkoutInfo?.id == info.id && showDetailPage ? 1.2 : 1)
                                    .opacity(selectedSetupWorkoutInfo?.id == info.id && showDetailPage ? 0.2 : 1)
                            })
                            .buttonStyle(ScaledButtonStyle())
                            .opacity(showDetailPage ? (selectedSetupWorkoutInfo?.id == info.id ? 1 : 0) : 1)
                            .frame(width: 170, height: 120)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .opacity(showDetailPage ? 0 : 1)
                
                VStack {
                    startButton()
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                    
                    Spacer().frame(height: 56 + SAFEAREA_BOTTOM_HEIGHT())
                }
            }
            
            if let selectedSetupWorkoutInfo, showDetailPage {
                setupDetailView(info: selectedSetupWorkoutInfo)
                    .frame(width: APP_WIDTH())
                    .ignoresSafeArea()
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
    
    func cardView(info: SetupWorkoutInfo) -> some View {
        VStack {
            if selectedSetupWorkoutInfo?.id == info.id && showDetailPage {
                HStack {
                    Text(LocalizedStringKey(info.title))
                        .font(.TimerFont.bold(size: 16))
                        .kerning(-0.75)
                        .foregroundStyle(selectedSetupWorkoutInfo?.id == info.id && showDetailPage ? .white : .gray)
                    
                    Image(systemName: info.icon)
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundStyle(selectedSetupWorkoutInfo?.id == info.id && showDetailPage ? .white : info.theme)
                    
                    Spacer()
                }
            } else {
                HStack {
                    Text(LocalizedStringKey(info.title))
                        .font(.TimerFont.bold(size: 16))
                        .kerning(-0.75)
                        .foregroundStyle(selectedSetupWorkoutInfo?.id == info.id && showDetailPage ? .white : .gray)
                    
                    Spacer()
                    
                    Image(systemName: info.icon)
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundStyle(selectedSetupWorkoutInfo?.id == info.id && showDetailPage ? .white : info.theme)
                }
            }
            
            Text(info.time)
                .font(.TimerFont.bold(size: selectedSetupWorkoutInfo?.id == info.id && showDetailPage ? 80 : 36))
                .fontWeight(.semibold)
                .kerning(-0.75)
                .foregroundStyle(showDetailPage ? .white : info.theme)
        }
        .padding(.top, 10)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
        .background {
            if !showDetailPage {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .shadow(radius: 8)
            }
            
        }
        .matchedGeometryEffect(id: info.id, in: animation)
    }
    
    func setupDetailView(info: SetupWorkoutInfo) -> some View {
        VStack {
            Spacer().frame(height: STATUS_BAR_HEIGHT())
            cardView(info: info)
                .scaleEffect(animateDetailView ? 1 : 0.94)
            Spacer().frame(height: 40)
            
            VStack {
                Button(action: {
                    
                }, label: {
                    Text("DIRECT_INPUT")
                        .font(.TimerFont.bold(size: 20))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding()
                        .background {
                            Capsule(style: .continuous)
                                .opacity(0.3)
                        }
                }).buttonStyle(ScaledButtonStyle())
                
                
                Spacer().frame(height: 50)
                
                if info.title == "NUM_OF_SETS" {
                    Picker("SetCount", selection: $selectedCountOfSets) {
                        ForEach(0..<11) { count in
                            HStack(spacing: 20) {
                                Text("\(count)")
                                Text(LocalizedStringKey("SETS"))
                            }
                            .font(.TimerFont.bold(size: 30))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.white)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                } else {
                    HStack(spacing: 0) {
                        Picker("Minute", selection: $selectedMinute) {
                            ForEach(0..<30) { minute in
                                HStack(spacing: 20) {
                                    Text("\(minute)")
                                    Text(LocalizedStringKey("MINUTE"))
                                }
                                .font(.TimerFont.bold(size: 30))
                                .fontWeight(.bold)
                                .foregroundStyle(Color.white)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        
                        Text(":")
                            .font(.TimerFont.bold(size: 50))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.white)
                        
                        Picker("Second", selection: $selectedSecond) {
                            ForEach(0..<12) { index in
                                let second = index * 5
                                HStack(spacing: 20) {
                                    Text("\(second)")
                                    Text(LocalizedStringKey("SECONDS"))
                                }
                                .font(.TimerFont.bold(size: 30))
                                .fontWeight(.bold)
                                .foregroundStyle(Color.white)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                }
                Spacer()
            }
            .opacity(animateDetailViewContent ? 1: 0)
            .scaleEffect(animateDetailViewContent ? 1 : 0, anchor: .top)
            
            
        }
        .background {
            info.theme
                .scaleEffect(animateDetailViewBackground ? 1 : 0)
        }
        .opacity(animateDetailView ? 1 : 0)
        .scaleEffect(animateDetailView ? 1 : 0.94)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.2)) {
                animateDetailViewBackground = true
            }
            withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.25)) {
                animateDetailView = true
                animateDetailViewContent = true
            }
        }
        .onTapGesture {
            withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.25)) {
                selectedSetupWorkoutInfo = nil
                showDetailPage = false
                animateDetailView = false
                animateDetailViewContent = false
            }
            withAnimation(.easeInOut(duration: 0.2)) {
                animateDetailViewBackground = false
            }
        }
        .transition(.identity)
    }
    
}

#Preview {
    MainView()
}

struct ScaledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
