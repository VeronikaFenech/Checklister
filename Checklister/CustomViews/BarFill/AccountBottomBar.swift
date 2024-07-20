//
//  AccountBottomBar.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 01.07.2024.
//

import SwiftUI

struct AccountBottomBar: View {
    var body: some View {
        HStack{
            Spacer()
            NavigationLink(destination: AccountView()) {
                ZStack{
                    Circle().fill(Color("MainGreen")).stroke(Color("FontGray"), lineWidth: 4)
                    Image("AccIconMain")
                }.frame(width: 68, height: 68)
                
                
            }
        }
        .padding(.trailing, 39)
        .padding(.bottom, 16)
    }
}


