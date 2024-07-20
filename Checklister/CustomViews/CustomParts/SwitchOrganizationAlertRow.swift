//
//  SwitchOrganizationAlertRow.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 01.07.2024.
//

import SwiftUI

struct SwitchOrganizationAlertRow: View{
    private var selected: Bool
    private var role: String
    
    public init(selected: Bool, role: String) {
        self.selected = selected
        self.role = role
    }
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 19)
                .stroke(Color("FontGray"), lineWidth: 3)
                .fill(Color("LightGrayBg"))
                .frame(width: 295, height: 53)
            HStack{
                ZStack{
                    Circle()
                        .fill(Color("LightGrayBg"))
                        .stroke(Color("FontGray"), lineWidth: 2)
                        .frame(width: 30, height: 30)
                    if selected{
                        Image("CheckSmallDark")
                    }
                }.padding(.trailing, 12)
                
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
                Arrow()
                    .stroke(Color("FontGray"), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                    .frame(width: 5, height: 14)
                    .offset(x: 2)
            }.padding(.horizontal, 15)
        }.frame(width: 295, height: 53)
    }
}
