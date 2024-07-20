//
//  SettingsRow.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 01.07.2024.
//

import SwiftUI

struct SettingsRow: View{
    private var image: String
    private var text: String
    private var rotation: Bool
    
    public init(image: String, text: String, rotation: Bool) {
        self.image = image
        self.text = text
        self.rotation = rotation
    }
    
    var body: some View{
        HStack(spacing: 20){
            Image(image)
                .frame(width: 30, height: 30)
            Text(text)
                .font(.custom("Prompt-SemiBold", size: 18))
                .foregroundStyle(Color("FontGray"))
                .lineLimit(1)
            Spacer()
            Arrow()
                .stroke(Color("FontGray"), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                .frame(width: 5, height: 14)
                .offset(x: 2)
                .padding(.trailing, 20)
        }
    }
}
