//
//  HomeVIew.swift
//  IntervalTimer
//
//  Created by YoungK on 12/18/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    
    @Namespace var animation
    @State var selectedSetupWorkoutType: SetupWorkoutType?
    @State var showDetailPage: Bool = false
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
                        setupButton(type: .sets, label: cardView(type: .sets), width: 170, height: 120)
                        setupButton(type: .warmup, label: cardView(type: .warmup), width: 170, height: 120)
                    }
                    HStack(spacing: 15) {
                        setupButton(type: .workout, label: cardView(type: .workout), width: 170, height: 120)
                        setupButton(type: .rest, label: cardView(type: .rest), width: 170, height: 120)
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
            
            if let selectedSetupWorkoutType, showDetailPage {
                setupDetailView(type: selectedSetupWorkoutType)
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
            
            Text(viewModel.totalTime.display)
                .font(.TimerFont.bold(size: 80))
                .foregroundStyle(.white)
                .kerning(-1.5)
        }
        
        
    }
    
    private func setupButton(type: SetupWorkoutType, label: some View, width: CGFloat, height: CGFloat) -> some View {
        Button(action: {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.25)) {
                selectedSetupWorkoutType = type
                showDetailPage = true
            }
        }) {
            label
                .scaleEffect(selectedSetupWorkoutType == type && showDetailPage ? 1.2 : 1)
                .opacity(selectedSetupWorkoutType == type && showDetailPage ? 0.2 : 1)
        }
        .buttonStyle(ScaledButtonStyle())
        .opacity(showDetailPage ? (selectedSetupWorkoutType == type ? 1 : 0) : 1)
        .frame(width: width, height: height)
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
    
    func cardView(type: SetupWorkoutType) -> some View {
        VStack {
            if selectedSetupWorkoutType?.title == type.title && showDetailPage {
                HStack {
                    Text(LocalizedStringKey(type.title))
                        .font(.TimerFont.bold(size: 16))
                        .kerning(-0.75)
                        .foregroundStyle(selectedSetupWorkoutType?.title == type.title && showDetailPage ? .white : .gray)
                    
                    Image(systemName: type.icon)
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundStyle(selectedSetupWorkoutType?.title == type.title && showDetailPage ? .white : type.theme)
                    
                    Spacer()
                }
            } else {
                HStack {
                    Text(LocalizedStringKey(type.title))
                        .font(.TimerFont.bold(size: 16))
                        .kerning(-0.75)
                        .foregroundStyle(selectedSetupWorkoutType?.title == type.title && showDetailPage ? .white : .gray)
                    
                    Spacer()
                    
                    Image(systemName: type.icon)
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundStyle(selectedSetupWorkoutType?.title == type.title && showDetailPage ? .white : type.theme)
                }
            }
            
            Text(type == .sets ? String(viewModel.countOfSets) :
                    type == .warmup ? viewModel.timeOfWarmup.display :
                    type == .workout ? viewModel.timeOfWorkout.display :
                    type == .rest ? viewModel.timeOfRest.display : "")
                .font(.TimerFont.bold(size: selectedSetupWorkoutType?.title == type.title && showDetailPage ? 80 : 36))
                .fontWeight(.semibold)
                .kerning(-0.75)
                .foregroundStyle(showDetailPage ? .white : type.theme)
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
        .matchedGeometryEffect(id: type.title, in: animation)
    }
    
    func setupDetailView(type: SetupWorkoutType) -> some View {
        VStack {
            Spacer().frame(height: STATUS_BAR_HEIGHT())
            cardView(type: type)
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
                
                switch type {
                case .sets:
                    Picker("SetCount", selection: $viewModel.countOfSets) {
                        ForEach(type.setsAllCase, id: \.self) { count in
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
                case .warmup:
                    HStack(spacing: 0) {
                        Picker("Minute", selection: $viewModel.timeOfWarmup.minutes) {
                            ForEach(type.minAllCase, id: \.self) { minute in
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
                        
                        Picker("Second", selection: $viewModel.timeOfWarmup.seconds) {
                            ForEach(type.secAllCase, id: \.self) { second in
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
                case .workout:
                    HStack(spacing: 0) {
                        Picker("Minute", selection: $viewModel.timeOfWorkout.minutes) {
                            ForEach(type.minAllCase, id: \.self) { minute in
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
                        
                        Picker("Second", selection: $viewModel.timeOfWorkout.seconds) {
                            ForEach(type.secAllCase, id: \.self) { second in
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
                case .rest:
                    HStack(spacing: 0) {
                        Picker("Minute", selection: $viewModel.timeOfRest.minutes) {
                            ForEach(type.minAllCase, id: \.self) { minute in
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
                        
                        Picker("Second", selection: $viewModel.timeOfRest.seconds) {
                            ForEach(type.secAllCase, id: \.self) { second in
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
            type.theme.scaleEffect(animateDetailViewBackground ? 1 : 0)
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
                selectedSetupWorkoutType = nil
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
