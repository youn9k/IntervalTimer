//
//  CarouselView.swift
//  IntervalTimer
//
//  Created by YoungK on 12/17/23.
//

import SwiftUI

struct CarouselView<Content: View>: View {
    typealias PageIndex = Int
    
    let pageCount: Int
    let visibleEdgeSpace: CGFloat
    let spacing: CGFloat
    let content: (PageIndex) -> Content
    
    @GestureState var dragOffset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    init(
        pageCount: Int,
        visibleEdgeSpace: CGFloat,
        spacing: CGFloat,
        @ViewBuilder content: @escaping (PageIndex) -> Content
    ) {
        self.pageCount = pageCount
        self.visibleEdgeSpace = visibleEdgeSpace
        self.spacing = spacing
        self.content = content
    }
    
    var body: some View {
        GeometryReader { proxy in
            let baseOffset: CGFloat = spacing + visibleEdgeSpace
            let pageWidth: CGFloat = proxy.size.width - (visibleEdgeSpace + spacing) * 2
            let offsetX: CGFloat = baseOffset + CGFloat(currentIndex) * -pageWidth + CGFloat(currentIndex) * -spacing + dragOffset
            
            HStack(spacing: spacing) {
                ForEach(0..<pageCount, id: \.self) { pageIndex in
                    self.content(pageIndex)
                        .frame(
                            width: pageWidth,
                            height: proxy.size.height
                        )
                }
                .contentShape(Rectangle())
            }
            .offset(x: offsetX)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, out, _ in
                        out = value.translation.width
                    }
                    .onEnded { value in
                        let offsetX = value.translation.width
                        let progress = -offsetX / pageWidth
                        let increment = Int(progress.rounded())
                        withAnimation(.spring(response: 0.25)) {
                            currentIndex = max(min(currentIndex + increment, pageCount - 1), 0)
                        }
                    }
            )
        }
    }
}

#Preview {
    ZStack {
        Color.green.ignoresSafeArea()
        CarouselView(pageCount: 2, visibleEdgeSpace: 1, spacing: 60, content: {_ in
            GlassWorkoutInfoView(width: APP_WIDTH()-80, height: 200, workoutInfos: [])
            GlassWorkoutInfoView(width: APP_WIDTH()-80, height: 200, workoutInfos: [])
            Spacer()
        })
        .background(Color.yellow)
    }
    
}
