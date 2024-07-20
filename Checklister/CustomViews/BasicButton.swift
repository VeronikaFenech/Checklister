//
//  BasicButton.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 11.07.2024.
//

import SwiftUI

struct BasicButton: View{
    
    private var image: String
    private var text: String
    
    public init(image: String, text: String) {
        self.image = image
        self.text = text
    }
    
    var body: some View{
        Button{} label:{
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 3).frame(width: 313, height: 56)
                HStack{
                    Image(image)
                        .frame(width: 42, height: 42)
                        .padding(.horizontal, 17)
                    Text(text)
                        .font(.custom("Prompt-SemiBold", size: 18))
                        .foregroundStyle(Color("FontGray"))
                }
            }
        }
    }
}
