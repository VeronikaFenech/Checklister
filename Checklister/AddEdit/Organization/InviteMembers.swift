//
//  AddOrganizationSecond.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 30.06.2024.
//

import SwiftUI

struct InviteMembers: View {
    @EnvironmentObject private var tabBarVisibilityManager: TabBarVisibilityManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var organizationTitle: String = ""
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background").ignoresSafeArea()
                
                VStack{
                    InstractionsText
                    InviteImage
                    InviteTextField
                    SmallInviteButton
                    Spacer()
                }.padding(.top, 20)
                .safeAreaInset(edge: .top) {
                    AccountTopBar(title: "Invite Members")
                }
            }
            .safeAreaInset(edge: .bottom){
                HStack(alignment: .center){
                    CustomBottomBackButton {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                    NavigationLink{
                        SuccessView()
                    } label: {
                        MainContinueButton(text: "Create")
                    }
                }
                .padding(.horizontal, 39)
                .padding(.bottom, 16)
            }
            .navigationBarBackButtonHidden()
            .onAppear{
                tabBarVisibilityManager.hideTabBar()
            }
        }
    }
    
    private var InstractionsText: some View{
        Text("Invited members can use the link to join the organization by the unique organization code in the invitation message. \n*You have to accept doing requests in settings later.")
            .font(.custom("Prompt-Medium", size: 15))
            .foregroundStyle(Color("FontGray"))
            .padding(.horizontal, 30)
    }
    
    private var InviteImage: some View{
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 3).frame(width: 326, height: 56)
                .padding(.leading, 5)
            ZStack{
                Circle()
                    .fill(Color("LightGrayBg"))
                    .stroke(Color("FontGray"), lineWidth: 3)
                    .frame(width: 73, height: 73)
                Image("InviteMembers").offset(x: 4)
            }
            HStack{
                Text("Invite Members")
                    .font(.custom("Prompt-SemiBold", size: 20))
                    .foregroundStyle(Color("FontGray"))
                    .padding(.leading, 75)
            }.padding(.horizontal, 15)
        }.frame(width: 326, height: 56).padding()
    }
    
    private var InviteTextField: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 3)
            Text("Join SushiWine now with organization code: 1378. Please use the following link: {link to login}")
                .font(.custom("Prompt-Regular", size: 15))
                .foregroundStyle(Color("LighterGray"))
                .padding(.horizontal, 10)
                .padding(.vertical, 7)
        }.frame(width: 326).scaledToFit()
    }
    
    private var SmallInviteButton: some View{
        HStack{
            Spacer()
            Button{
                
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 13)
                        .fill(Color("MainGreen"))
                        .stroke(Color("FontGray"), lineWidth: 3)
                    Text("Invite")
                        .foregroundStyle(Color("LightGrayBg"))
                        .font(.custom("Prompt-SemiBold", size: 19))
                    
                }.frame(width: 122, height: 35)
            }
        }
        .padding(.horizontal, 30)
        .padding(.top, 10)
    }
}

//#Preview {
//    AddOrganizationSecond()
//}
