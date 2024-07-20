//
//  ContinueButtons.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 01.07.2024.
//

import SwiftUI

struct ContinueButton: View{
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 17)
                .fill(Color("MainGreen"))
                .stroke(Color("FontGray"), lineWidth: 4)
            Text("Continue")
                .foregroundStyle(Color("LightGrayBg"))
                .font(.custom("Prompt-SemiBold", size: 25))
            
        }.frame(width: 230, height: 56)
    }
}

struct MainContinueButton: View{
    private var text: String
    
    public init(text: String) {
        self.text = text
    }
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("MainGreen"))
                .stroke(Color("FontGray"), lineWidth: 4)
            Text(text)
                .foregroundStyle(Color("LightGrayBg"))
                .font(.custom("Prompt-SemiBold", size: 25))
            
        }.frame(width: 220, height: 64)
    }
}
