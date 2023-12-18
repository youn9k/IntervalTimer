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
            //bottomTabBar(selection: tab)
            CustomTabBar(tab: $tab)
        }
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
            return "house.circle.fill"
        case .setting:
            return "gearshape.circle.fill"

        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            Button(action: {
                tab = .home
            }){
                Image(systemName: tab == .home ? fillIconImage(tab: self.tab) : "house.circle")
                    .resizable()
                    .scaledToFit()
                    .tint(.timerIvory)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .frame(height: 40)
                    .padding(20)
            }
            Spacer()
            Button(action: {
                tab = .setting
            }){
                Image(systemName: tab == .setting ? fillIconImage(tab: self.tab) : "gearshape.circle")
                    .resizable()
                    .scaledToFit()
                    .tint(.white)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .frame(height: 40)
                    .padding(20)
            }
            Spacer()
        }
    }
}
