//
//  ProgressBar.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 02.07.2024.
//

import SwiftUI

struct ProgressBar: View {
    @Binding private var value: Float
    
    public init(value: Binding<Float>) {
        self._value = value
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .stroke(Color("FontGray"), lineWidth: 2)
                    .frame(width: geometry.size.width , height: geometry.size.height)
                    .foregroundColor(.white)
                    
                
                Capsule()
                    .fill(Color("MainGreen"))
                    .stroke(Color("FontGray"), lineWidth: 2)
                    .frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .animation(.linear, value: value)
            }
        }
    }
}
