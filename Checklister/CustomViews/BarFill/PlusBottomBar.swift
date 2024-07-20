//
//  PlusBottomBar.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 01.07.2024.
//

import SwiftUI

struct PlusBottomBar: View {
    @Binding private var showAlert: Bool
    public init(showAlert: Binding<Bool>) {
        self._showAlert = showAlert
    }
    var body: some View {
        HStack{
            Spacer()
            NavigationLink{
                AddChecklist(showAlert: $showAlert)
            } label: {
                ZStack{
                    Circle().fill(Color("LightGrayBg")).stroke(Color("FontGray"), lineWidth: 4)
                    Plus()
                        .stroke(Color("FontGray"), style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                        .frame(width: 35, height: 35)
                }.frame(width: 68, height: 68)
            }
            .padding(.trailing, 39)
            .padding(.bottom, 16)
        }
        
    }
}
