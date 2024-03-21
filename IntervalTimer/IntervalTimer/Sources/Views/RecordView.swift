//
//  RecordView.swift
//  IntervalTimer
//
//  Created by YoungK on 1/12/24.
//

import SwiftUI

struct RecordView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                ScrollView {
                    HStack {
                        Spacer()
                        NavigationLink(destination: RecordMoreView()) {
                            Text("더 보기")
                                .font(.TimerFont.bold(size: 15))
                                .foregroundStyle(Color(hex: "00BF56"))
                                .padding(10)
                        }
                    }
                    .padding(.bottom, 5)
                    .padding(.horizontal, 20)
                    
                    
                    VStack(spacing: 15) {
                        ForEach(0..<8) { _ in
                            NavigationLink {
                                RecordDetailView()
                            } label: {
                                recordInfoView(sets: 5, totalTime: "0:20:30", date: "2024. 1. 12.")
                            }
                            
                        }
                        
                    }
                    .padding(.horizontal, 20)
                    
                }

            }
            .background(
                backgroundGradientView()
                    .ignoresSafeArea(edges: .bottom)
            )
        }
        
    }
    
    func backgroundGradientView() -> some View {
        LinearGradient(colors: [Color.white, Color(hex: "D9D9D9")], startPoint: .top, endPoint: .bottom)
    }
    
    func recordInfoView(sets: Int, totalTime: String, date: String) -> some View {
        RoundedRectangle(cornerRadius: 25)
            .frame(height: 80)
            .foregroundStyle(.white)
            .shadow(radius: 20, x: 0, y: 8)
            .overlay {
                HStack(alignment: .bottom, spacing: 0) {
                    
                    rectangleRunIcon()
                        .padding(.trailing, 20)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 0) {
                            Text("\(sets) ")
                            Text(Strings.sets.localized)
                        }
                        .font(.TimerFont.bold(size: 12))
                        .foregroundStyle(Color(hex: "909090"))
                        
                        Text(totalTime)
                            .font(.TimerFont.bold(size: 20))
                            .foregroundStyle(Color(hex: "00BF56"))
                    }
                    
                    Spacer()
                    
                    Text(date)
                        .font(.TimerFont.medium(size: 10))
                        .foregroundStyle(Color(hex: "909090"))
                    

                    
                }
                .padding(.horizontal, 20)
            }
    }
    
    func rectangleRunIcon() -> some View {
        Circle()
            .frame(width: 40, height: 40)
            .foregroundStyle(Color(hex: "00BF56"))
            .overlay {
                Image(systemName: "figure.run")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18)
                    .foregroundStyle(.white)
            }
    }
}

#Preview {
    RecordView()
}
