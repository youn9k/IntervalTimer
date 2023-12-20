//
//  MainView.swift
//  IntervalTimer
//
//  Created by YoungK on 12/16/23.
//

import SwiftUI

enum Tab {
    case home, setting
}

struct MainView: View {
    @State var tab: Tab = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            HomeView()
            CustomTabBar(tab: $tab)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}


#Preview {
    MainView()
}

extension MainView {
    @ViewBuilder
    func view(tab: Tab) -> some View {
        switch tab {
        case .home:
            HomeView()
        case .setting:
            HomeView()
        }
    }
}


struct CustomTabBar: View {
    @Binding var tab: Tab
    
    func fillIconImage(tab: Tab) -> String {
        switch tab {
        case .home:
            return "house.fill"
        case .setting:
            return "person.fill"
        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            Button(action: {
                print("홈눌림")
                print(SAFEAREA_BOTTOM_HEIGHT())
                tab = .home
            }){
                Image(systemName: tab == .home ? fillIconImage(tab: self.tab) : "house")
                    .resizable()
                    .scaledToFit()
                    .tint(.timerBlue)
                    .frame(height: 30)
                    .padding(20)
            }
            Spacer()
            Button(action: {
                print("세팅눌림")
                tab = .setting
            }){
                Image(systemName: tab == .setting ? fillIconImage(tab: self.tab) : "person")
                    .resizable()
                    .scaledToFit()
                    .tint(.timerBlue)
                    .frame(height: 30)
                    .padding(20)
            }
            Spacer()
        }
        .padding(.bottom, SAFEAREA_BOTTOM_HEIGHT())
        .frame(width: APP_WIDTH(), height: 56 + SAFEAREA_BOTTOM_HEIGHT())
        .background(
            Rectangle()
                .foregroundStyle(.white)
                .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 15))
        )
        .shadow(color: Color(.sRGBLinear, red: 0, green: 0, blue: 0, opacity: 0.12), radius: 7, x: 0, y: -3)
        .mask(Rectangle().padding(.top, -20)) // 아래쪽 그림자를 없애기 위해
        
    }
}
