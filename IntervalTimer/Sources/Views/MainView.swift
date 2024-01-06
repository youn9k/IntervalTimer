//
//  MainView.swift
//  IntervalTimer
//
//  Created by YoungK on 12/16/23.
//

import SwiftUI
import BottomSheet

struct MainView: View {
    @StateObject var viewRouter = ViewRouter.shared
    @State var bottomSheetPosition: BottomSheetPosition = .absolute(0.4)
    
    var body: some View {
        ZStack {
            switch viewRouter.viewType {
            case .home:
                HomeView()
                
            case .workout:
                WorkoutView()
                
            case .setting:
                Text("setting")
            }
            
        }
        .bottomSheet(bottomSheetPosition: $bottomSheetPosition, switchablePositions: [.absolute(0.4), .relativeTop(0.6), .relativeTop(1)],
            headerContent: {
                bottomSheetHeaderContent()
            }, mainContent: {
                bottomSheetMainContent()
            })
        .customBackground {
            Color.white
                .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 30))
                .shadow(radius: 20, x: 8, y: 0)
        }
        .enableAppleScrollBehavior()
        .enableBackgroundBlur()
        .backgroundBlurMaterial(.systemDark)
    }
    
    func bottomSheetHeaderContent() -> some View {
        HStack(spacing: 40) {
            Spacer()
            Image(.recordGray)
                .resizable()
                .frame(width: 32, height: 32)
                .padding(.horizontal, 40)
                .onTapGesture {
                    self.bottomSheetPosition = .relativeTop(0.9)
                }
            
            Image(.gearGray)
                .resizable()
                .frame(width: 32, height: 32)
                .padding(.horizontal, 40)
                .onTapGesture {
                    self.bottomSheetPosition = .relativeTop(0.9)
                }
            Spacer()
        }.padding(.bottom, 5)
    }
    
    func bottomSheetMainContent() -> some View {
        ScrollView {
            ForEach(0..<10) { _ in
                Text("임시 텍스트")
            }
        }
    }
}


#Preview {
    MainView()
}
