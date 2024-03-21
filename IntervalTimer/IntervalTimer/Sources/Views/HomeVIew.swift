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
    @State var showPicker: Bool = false

    var body: some View {
        ZStack {
            backgroundGradientView()
                .ignoresSafeArea(edges: .top)
            
            VStack {
                Spacer(minLength: 45)
                totalTimeView()
                Spacer()
                
                VStack(spacing: 15) {
                    HStack {
                        setupButton(type: .sets, label: capsuleView(type: .sets, width: 130, height: 40))
                        Spacer()
                        setupButton(type: .warmup, label: capsuleView(type: .warmup, width: 130, height: 40))
                    }
                    
                    setupButton(type: .workout, label: cardView(type: .workout, width: 353, height: 100))
                    
                    setupButton(type: .rest, label: cardView(type: .rest, width: 353, height: 100))
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                
                startButton()
                    .padding(.horizontal, 20)
                
                Spacer().frame(height: 100)
                
            }
            
        }
        .onTapGesture {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.25)) {
                if selectedSetupWorkoutType != nil {
                    self.selectedSetupWorkoutType = nil
                    showPicker = false
                }
            }
            
        }
        
    }
    
    func backgroundGradientView() -> some View {
        LinearGradient(colors: [Color(hex: "90CAFF"), Color.white], startPoint: .top, endPoint: .bottom)
    }
    
    func totalTimeView() -> some View {
        VStack {
            Text("TOTAL_WORKOUT_TIME")
                .font(.TimerFont.medium(size: 20))
                .foregroundStyle(.white)
                .kerning(-1)
                .shadow(radius: 40, x: 0, y: 8)
            
            Text(viewModel.totalTime.display)
                .font(.TimerFont.medium(size: 60))
                .foregroundStyle(.white)
                .kerning(-1)
                .shadow(radius: 40, x: 0, y: 8)
        }
    }
    
    private func setupButton(type: SetupWorkoutType, label: some View) -> some View {
        Button(action: {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.25)) {
                if selectedSetupWorkoutType != nil {
                    self.selectedSetupWorkoutType = nil
                } else {
                    self.selectedSetupWorkoutType = type
                }
                showPicker.toggle()
            }
        }) {
            label
                .scaleEffect(selectedSetupWorkoutType == type && showPicker ? 1.1 : 1)
        }
        .buttonStyle(ScaledButtonStyle())
    }
    
    func capsuleView(type: SetupWorkoutType, width: CGFloat, height: CGFloat) -> some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(showPicker && selectedSetupWorkoutType == type ? type.subTheme : .white)
                .shadow(radius: 8, x: 0, y: 4)
                .frame(width: showPicker && selectedSetupWorkoutType == type ? width * 1.5 : width, height: showPicker && selectedSetupWorkoutType == type ? height * 1.5 : height)
                .overlay {
                    HStack {
                        Text(LocalizedStringKey(type.title))
                            .font(.TimerFont.bold(size: 12))
                            .lineLimit(1)
                            .foregroundStyle(showPicker && selectedSetupWorkoutType == type ? .white : Color(hex: "9D9D9D"))
                        
                        Spacer()
                        
                        ZStack {
                            if showPicker && selectedSetupWorkoutType == type {
                                setupPicker(type: type)
                                    .opacity(showPicker ? 1 : 0)
                                    .scaleEffect(showPicker ? 1 : 0.94)
                                    .onTapGesture {
                                        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.25)) {
                                            self.selectedSetupWorkoutType = nil
                                            showPicker = false
                                        }
                                    }
                                    .transition(.identity)
                            } else {
                                Text(type == .sets ? String(viewModel.countOfSets) :
                                        type == .warmup ? viewModel.timeOfWarmup.display :
                                        type == .workout ? viewModel.timeOfWorkout.display :
                                        type == .rest ? viewModel.timeOfRest.display : "")
                                    .font(.TimerFont.bold(size: 12))
                                    .foregroundStyle(showPicker && selectedSetupWorkoutType == type ? .white : type.theme)
                            }
                        }
                        
                    }
                    .padding(.horizontal, 10)
                }

        }
        .matchedGeometryEffect(id: type.title, in: animation)
    }
    
    func startButton() -> some View {
        Button(action: {
            viewModel.workoutStart()
            ViewRouter.shared.change(to: .workout)
        }, label: {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 60)
                .foregroundStyle(LinearGradient(colors: [.indigo, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                .shadow(radius: 20, x: 0, y: 8)
                .overlay {
                    Text("WORKOUT_START")
                        .font(.TimerFont.bold(size: 16))
                        .foregroundStyle(.white)
                }
        })
        .buttonStyle(ScaledButtonStyle())
    }
    
    func cardView(type: SetupWorkoutType, width: CGFloat, height: CGFloat) -> some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(selectedSetupWorkoutType?.title == type.title && showPicker ? type.theme : type.subTheme)
                .shadow(radius: 8, x: 0, y: 4)
                .frame(width: width, height: height)
                .overlay {
                    HStack {
                        Circle()
                            .foregroundStyle(type.theme)
                            .frame(width: 40, height: 40)
                            .overlay {
                                Image(systemName: type.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.white)
                                    .frame(width: type == .rest ? 18 : 24,
                                           height: type == .rest ? 18 : 24)
                            }
                            .padding(.trailing, 10)
                        
                        Text(LocalizedStringKey(type.title))
                            .font(.TimerFont.bold(size: 20))
                            .foregroundStyle(selectedSetupWorkoutType?.title == type.title && showPicker ? .white : type.theme)
                        
                        Spacer()
                        
                        ZStack {
                            if showPicker && selectedSetupWorkoutType == type  {
                                
                                setupPicker(type: type)
                                    .opacity(showPicker ? 1 : 0)
                                    .scaleEffect(showPicker ? 1 : 0.94)
                                    .onTapGesture {
                                        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.25)) {
                                            self.selectedSetupWorkoutType = nil
                                            showPicker = false
                                        }
                                    }
                                    .transition(.identity)
                            }
                            
                            Text(type == .sets ? String(viewModel.countOfSets) :
                                    type == .warmup ? viewModel.timeOfWarmup.display :
                                    type == .workout ? viewModel.timeOfWorkout.display :
                                    type == .rest ? viewModel.timeOfRest.display : "")
                            .font(.TimerFont.bold(size: 36))
                            .foregroundStyle(showPicker && selectedSetupWorkoutType == type ? .white : type.theme)
                            .opacity(showPicker && selectedSetupWorkoutType == type ? 0 : 1)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    
                    
                }
            
        }
        .matchedGeometryEffect(id: type.title, in: animation)
    }
    
    func setupPicker(type: SetupWorkoutType) -> some View {
        VStack {
            switch type {
            case .sets:
                Picker("SetCount", selection: $viewModel.countOfSets) {
                    ForEach(type.setsAllCase, id: \.self) { count in
                        HStack(spacing: 0) {
                            Text("\(count)")
                            Text(LocalizedStringKey("SETS"))
                        }
                        .font(.TimerFont.bold(size: 12))
                        .foregroundStyle(Color.white)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                
            case .warmup:
                Picker("Second", selection: $viewModel.timeOfWarmup.seconds) {
                    ForEach(type.secAllCase, id: \.self) { second in
                        HStack {
                            Text("00:\(second)")
                        }
                        .font(.TimerFont.bold(size: 12))
                        .foregroundStyle(Color.white)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                
            case .workout:
                HStack(spacing: 0) {
                    Picker("Minute", selection: $viewModel.timeOfWorkout.minutes) {
                        ForEach(type.minAllCase, id: \.self) { minute in
                            HStack {
                                Text("\(minute)")
                            }
                            .font(.TimerFont.bold(size: 30))
                            .foregroundStyle(Color.white)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    
                    Text(":")
                        .font(.TimerFont.bold(size: 50))
                        .foregroundStyle(Color.white)
                    
                    Picker("Second", selection: $viewModel.timeOfWorkout.seconds) {
                        ForEach(type.secAllCase, id: \.self) { second in
                            HStack {
                                Text("\(second)")
                            }
                            .font(.TimerFont.bold(size: 30))
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
                            }
                            .font(.TimerFont.bold(size: 30))
                            .foregroundStyle(Color.white)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    
                    Text(":")
                        .font(.TimerFont.bold(size: 50))
                        .foregroundStyle(Color.white)
                    
                    Picker("Second", selection: $viewModel.timeOfRest.seconds) {
                        ForEach(type.secAllCase, id: \.self) { second in
                            HStack(spacing: 20) {
                                Text("\(second)")
                            }
                            .font(.TimerFont.bold(size: 30))
                            .foregroundStyle(Color.white)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
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
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
