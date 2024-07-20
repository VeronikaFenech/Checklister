//
//  SwitchOrgRow.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 11.07.2024.
//

import SwiftUI

struct SwitchOrgRow: View{
    private var selected: Bool
    private var role: String
    
    public init(selected: Bool, role: String) {
        self.selected = selected
        self.role = role
    }
    
    var body: some View{
        ZStack{
            CustomButton()
            HStack{
                ZStack{
                    Circle()
                        .fill(Color("LightGrayBg"))
                        .stroke(Color("FontGray"), lineWidth: 2)
                        .frame(width: 30, height: 30)
                    if selected{
                        Image("CheckSmallDark")
                    }
                }.padding(.horizontal, 12)
                Image("OrgSmall")
                    .padding()
                    .frame(width: 54, height: 35)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("FontGray"), lineWidth: 1.5)
                        .foregroundStyle(Color("LightGrayBg")))
                    .padding(.trailing, 5)
                    .padding(.leading, -5)
                VStack(alignment: .leading, spacing: -3){
                    Text("Organization")
                        .font(.custom("Prompt-Bold", size: 18))
                        .foregroundStyle(Color("FontGray"))
                    Text(role)
                        .font(.custom("Prompt-Medium", size: 8))
                        .foregroundStyle(Color("FontGray"))
                }
                Spacer()
            }
            .frame(width: 313, height: 56)
        }
        
    }
}
