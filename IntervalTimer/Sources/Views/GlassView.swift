//
//  GlassView.swift
//  IntervalTimer
//
//  Created by YoungK on 12/17/23.
//

import SwiftUI

struct GlassView<Content: View>: View {
    var width: CGFloat
    var height: CGFloat
    var cornerRadius: CGFloat
    @ViewBuilder let content:() -> Content
    
    init(width: CGFloat, height: CGFloat, cornerRadius: CGFloat = 15, content: @escaping () -> Content) {
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.content = content
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(.white, lineWidth: 3)
                .frame(width: width, height: height)
                .foregroundColor(.clear)
            
            Rectangle()
                .frame(width: width, height: height)
                .foregroundColor(.clear)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .overlay {
                    content()
                }
            //content()
        }
    }
}

#Preview {
    ZStack {
        //Image(.test).ignoresSafeArea()
        Color.blue.ignoresSafeArea()
        GlassView(width: APP_WIDTH()-80, height: 200, content: {
            Text("Glass").foregroundStyle(.yellow).background()
        })
    }
    
}
