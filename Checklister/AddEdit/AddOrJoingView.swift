//
//  AddOrJoingView.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 27.06.2024.
//

import SwiftUI

struct AddOrJoingView: View {
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background").ignoresSafeArea()
                VStack(spacing: 20){
                    Spacer()
                    Image("OrgPart")
                        .padding(40)
                    Text("You are not a part of any \n organization yet")
                        .foregroundStyle(Color("FontGray"))
                        .font(.custom("Prompt-Medium", size: 20))
                        .multilineTextAlignment(.center)
                        .environment(\._lineHeightMultiple, 0.8)
                    JoinButton
                    
                    Text("OR")
                        .foregroundStyle(Color("FontGray"))
                        .font(.custom("Prompt-Medium", size: 20))
                    NavigationLink {
                        AddOrganizationFirst()
                    } label: {
                        CreateButton
                    }
                    Spacer()
                }
            }
            .safeAreaInset(edge: .bottom){
                AccountBottomBar()
            }
            .navigationBarBackButtonHidden()
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Text("Checkliter")
                        .font(.custom("Prompt-Bold", size: 25))
                        .foregroundStyle(Color("FontGray"))
                        .padding(20)
                }
            }
        }
    }
    
    private var JoinButton: some View{
        Button{
            
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 17)
                    .stroke(Color("FontGray"), lineWidth: 3)
                Text("Join organization")
                    .foregroundStyle(Color("FontGray"))
                    .font(.custom("Prompt-Medium", size: 20))
                
            }.frame(width: 330, height: 53)
        }.padding(5)
    }
    
    private var CreateButton: some View{
        
        ZStack{
            RoundedRectangle(cornerRadius: 17)
                .stroke(Color("FontGray"), lineWidth: 3)
            Text("Create organization")
                .foregroundStyle(Color("FontGray"))
                .font(.custom("Prompt-Medium", size: 20))
        }
        .frame(width: 330, height: 53)
        .padding(5)
    }
}

//#Preview {
//    AddOrJoingView()
//}
