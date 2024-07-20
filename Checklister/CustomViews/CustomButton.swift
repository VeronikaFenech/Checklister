//
//  CustomButton.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 11.07.2024.
//

import SwiftUI

struct CustomButton: View{
    
    private var text: String?
    private var widthDif: CGFloat?
    
    public init(text: String? = nil, widthDif: CGFloat? = nil) {
        self.text = text
        self.widthDif = widthDif
    }
    
    var body: some View{
        
        ZStack(alignment: .leading){
            Text(text ?? "")
                .padding(.horizontal, 18)
                .font(.custom("Prompt-SemiBold", size: 18))
                .foregroundStyle(Color("FontGray"))
            HStack(spacing: -12){
                Frame()
                    .stroke(Color("FontGray"), lineWidth: 3)
                    .frame(width: 325 - (widthDif ?? 0), height: 53)
                
                Arrow()
                    .stroke(Color("FontGray"), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                    .frame(width: 5, height: 14)
                    .offset(x: 2)
                    .padding()
                    .frame(width: 25, height: 30)
                    .background(Ellipse().fill(Color("PinkMain")).stroke(Color("FontGray"), lineWidth: 2.5))
                
            }
        }
    }
}
