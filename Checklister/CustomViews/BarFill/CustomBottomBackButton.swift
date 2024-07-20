//
//  CustomBottomBackButton.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 02.07.2024.
//

import SwiftUI

struct CustomBottomBackButton: View {
    private var action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button{
            action()
        }label: {
            ZStack{
                Circle().fill(Color("LightGrayBg")).stroke(Color("FontGray"), lineWidth: 4)
                Arrow()
                    .stroke(Color("FontGray"), style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                    .frame(width: 13, height: 31).rotationEffect(.degrees(180)).offset(x: -3)
            }.frame(width: 68, height: 68)
        }
    }
}
