//
//  WorkoutView.swift
//  IntervalTimer
//
//  Created by YoungK on 12/16/23.
//

import SwiftUI

struct WorkoutView: View {
    @StateObject var workoutState = WorkoutState.shared
    @StateObject var viewModel: WorkoutViewModel = WorkoutViewModel()
    @State var showToast: Bool = false
    
    var body: some View {
        ZStack {
            backgroundGradientView(colors: workoutState.currentPhase.gradientColors)
                .ignoresSafeArea(edges: .top)

            VStack {
                Spacer(minLength: 24)

                remainingTimeView()
                    .frame(width: 300, height: 200)
                    .padding(.bottom, 37)
                
                CarouselView(pageCount: 2, visibleEdgeSpace: 1, spacing: APP_WIDTH() > 375 ? 60 : 45) { _ in
                    workoutInfoView(content: workoutInfoContent())
                        .frame(width: 313, height: 150)
                    
                    workoutInfoView(content: appleWatchInfoContent())
                        .frame(width: 313, height: 150)
                    
                    Spacer()
                }
                .frame(height: 150)
                .padding(.bottom, 37)

                playPauseButton()
                
                Spacer(minLength: 79)
            }
        }
        .overlay(alignment: .bottom) {
            toastMessage(message: "일시정지를 길게 누르면 운동이 종료됩니다.", time: 2)
                .opacity(showToast ? 1 : 0)
                .padding(.bottom, 20)
                
        }
        .fullScreenCover(isPresented: $viewModel.showCongratuation) {
            CongratuationView(totalWorkoutTIme: viewModel.progressTime.display, highHeartRate: nil, avgHeartRate: nil, burnKcal: nil)
        }

    }
    
    func toastMessage(message: String, time: Double) -> some View {
        Text(message)
            .font(.TimerFont.medium(size: 15))
            .foregroundStyle(.white)
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.black)
                    .opacity(0.5)
            }
            .onChange(of: showToast) {
                DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                    withAnimation { showToast = false }
                }
            }
    }
    
    func backgroundGradientView(colors: [Color]) -> some View {
        LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    func remainingTimeView() -> some View {
        LiquidView(color: .white)
            .opacity(0.6)
            .overlay {
                VStack {
                    Text(WorkoutState.shared.remainPhaseTime.display)
                        .font(.TimerFont.bold(size: 60))
                    
                    Text(WorkoutState.shared.currentPhase.title)
                        .font(.TimerFont.bold(size: 20))
                }
                .foregroundStyle(.white)
                .shadow(radius: 40, x: 0, y: 8)
            }
    }
    
    func workoutInfoView(content: some View) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(.white)
            .shadow(radius: 20, x: 0, y: 8)
            .overlay {
                content
            }
    }
    
    func workoutInfoContent() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 50) {
                VStack(spacing: 6) {
                    Text("NUM_OF_SETS")
                        .font(.TimerFont.bold(size: 20))
                        .foregroundStyle(Color(hex: "909090"))
                    Text("\(workoutState.currentSetsCount)/\(workoutState.totalSetsCount)")
                        .font(.TimerFont.bold(size: 16))
                        .foregroundStyle(Color(hex: "4B88FF"))
                }
                
                VStack(spacing: 6) {
                    Text("WORKOUT_TIME")
                        .font(.TimerFont.bold(size: 20))
                        .foregroundStyle(Color(hex: "909090"))
                    Text(viewModel.progressTime.display)
                        .font(.TimerFont.bold(size: 16))
                        .foregroundStyle(Color(hex: "4B88FF"))
                }
            }
            .padding(.top, 35)
            .padding(.bottom, 35)
            
            totalWorkoutProgressBar(progress: viewModel.workoutProgress, width: 251, height: 15)
                .padding(.bottom, 16)
        }
        
    }
    
    func appleWatchInfoContent() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 50) {
                VStack(spacing: 6) {
                    Text("HEART_RATE")
                        .font(.TimerFont.bold(size: 20))
                        .foregroundStyle(Color(hex: "909090"))
                    Text("-- BPM")
                        .font(.TimerFont.bold(size: 16))
                        .foregroundStyle(Color(hex: "FF5454"))
                }
                
                VStack(spacing: 6) {
                    Text("KCAL")
                        .font(.TimerFont.bold(size: 20))
                        .foregroundStyle(Color(hex: "909090"))
                    Text("-- Kcal")
                        .font(.TimerFont.bold(size: 16))
                        .foregroundStyle(Color(hex: "FF5454"))
                }
            }
            .padding(.top, 35)
            .padding(.bottom, 35)
            
            totalWorkoutProgressBar(progress: viewModel.workoutProgress, width: 251, height: 15)
                .padding(.bottom, 16)
        }
        
    }
    
    func playPauseButton() -> some View {
        Button(action: {
        }, label: {
            if workoutState.isPaused {
                ImageLiterals.play
                    .resizable()
                    .frame(width: 120, height: 120)
                    .shadow(radius: 20, x: 0, y: 8)
            } else {
                ImageLiterals.pause
                    .resizable()
                    .frame(width: 120, height: 120)
                    .shadow(radius: 20, x: 0, y: 8)
            }
        })
        .buttonStyle(ScaledButtonStyle())
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 2, maximumDistance: 3.0)
                .onEnded { _ in
                    if !workoutState.isPaused {
                        workoutState.clearWorkout()
                        ViewRouter.shared.change(to: .home)
                    }
                }
        )
        .highPriorityGesture(
            TapGesture()
                .onEnded { _ in
                    if workoutState.isPaused {
                        workoutState.resumeWorkout()
                    } else {
                        workoutState.pauseWorkout()
                        withAnimation { showToast = true }
                    }
                }
        )
        
    }
    
    func totalWorkoutProgressBar(progress: CGFloat, width: CGFloat, height: CGFloat) -> some View {
        return ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 50)
                .frame(width: width, height: height)
                .foregroundStyle(Color(hex: "D9D9D9"))
            
            RoundedRectangle(cornerRadius: 50)
                .frame(width: width * progress, height: height)
                .foregroundStyle(Color(hex: "4B88FF"))
                .animation(.easeIn, value: viewModel.workoutProgress)
        }
    }
    
}

#Preview {
    WorkoutView()
    //MainView()
}
