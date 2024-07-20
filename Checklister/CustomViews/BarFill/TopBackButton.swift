//
//  TopBackButton.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 10.07.2024.
//

import SwiftUI

struct TopBackButton: View{
    private var action: () -> Void
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    var body: some View{
        Button{
            action()
        } label:{
            Arrow()
                .stroke(Color("FontGray"), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                .frame(width: 7, height: 21)
                .rotationEffect(.degrees(180))
                .offset(x: -2)
                .padding()
                .background(
                    Circle()
                    .fill(Color("LightGrayBg"))
                    .stroke(Color("FontGray"), lineWidth: 3)
                    .frame(width: 40))
            
        }.padding(20)
    }
}
