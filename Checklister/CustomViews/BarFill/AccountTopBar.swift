//
//  AccountTopBar.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 01.07.2024.
//

import SwiftUI
import Foundation
import UIKit

struct AccountTopBar: View{
    private var title: String
    private var ownerMode: Bool
    private var switchOrgAvailable: Bool
    private var spacer: Bool
    @Binding private var showAlert: Bool
    
    public init(title: String, ownerMode: Bool = false, spacer: Bool = true, switchOrgAvailable: Bool = false, showAlert: Binding<Bool> = .constant(false)) {
        self.title = title
        self.ownerMode = ownerMode
        self.spacer = spacer
        self.switchOrgAvailable = switchOrgAvailable
        self._showAlert = showAlert
    }
    var body: some View{
            HStack(alignment:.center){
                HStack(spacing: 2){
                    if ownerMode{
                        NavigationLink(destination: EditOrganizationView(showAlert: $showAlert)) {
                            Image("OrgSettings")
                                .frame(width: 30, height: 30)
                        }
                    }
                    Text(title)
                        .font(.custom("Prompt-Bold", size: 27))
                        .foregroundStyle(Color("FontGray"))
                        .lineLimit(1)
                        
                    if switchOrgAvailable{
                        Button{
                            showAlert = true
                        }label: {
                            Arrow()
                                .stroke(Color("FontGray"), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                                .frame(width: 5, height: 14)
                                .offset(x: 2)
                                .padding(10)
                                .rotationEffect(.degrees(90))
                        }
                    }
                }.padding(.leading, 35)
                .padding(.trailing, -5)
                Spacer()
                NavigationLink(destination: AccountView()) {
                    ZStack{
                        Circle().fill(Color("MainGreen")).stroke(Color("FontGray"), lineWidth: 2)
                        Image("AccIcon")
                    }.frame(width: 51, height: 51)
                }
            }
            .padding(.trailing, 35)
    }
}
