//
//  CircularPrograssBar.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 01.07.2024.
//

import SwiftUI

struct CircularProgressBar: View {
    internal var progress: Float
    
    public init(progress: Float) {
        self.progress = progress
    }
    
    var body: some View {
        ZStack {
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 3.7, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("MainGreen"))
                .rotationEffect(.degrees(-90))
                .animation(.linear, value: progress)
        }
        .frame(width: 64)
        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
    }
}
