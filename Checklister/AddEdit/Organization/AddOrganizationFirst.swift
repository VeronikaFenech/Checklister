//
//  AddOrganizationFirst.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 30.06.2024.
//

import SwiftUI
import PhotosUI

struct AddOrganizationFirst: View {
    @EnvironmentObject private var tabBarVisibilityManager: TabBarVisibilityManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var organizationTitle: String = ""
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background").ignoresSafeArea()
                VStack{
                    OrganizationImage
                    OrganizationTitleField
                    Spacer()
                }
                .padding(.top, 40)
                .safeAreaInset(edge: .top) {
                    AccountTopBar(title: "Create organization")
                        .onTapGesture {
                            tabBarVisibilityManager.showTabBar()
                        }
                }
                
            }
            .safeAreaInset(edge: .bottom){
                HStack(alignment: .center){
                    CustomBottomBackButton{
                        tabBarVisibilityManager.showTabBar()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                    NavigationLink {
                        InviteMembers()
                    } label: {
                        Continue
                    }
                }
                .padding(.horizontal, 39)
                .padding(.bottom, 16)
            }
            .navigationBarBackButtonHidden()
            .onAppear{
                tabBarVisibilityManager.hideTabBar()
            }
            .onChange(of: avatarItem) {
                        Task {
                            if let loaded = try? await avatarItem?.loadTransferable(type: Image.self) {
                                avatarImage = loaded
                            } else {
                                print("Failed")
                            }
                        }
                    }
        }
    }
    
    private var OrganizationImage: some View{
        ZStack{
            if let image = avatarImage{
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 258, height: 168)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("FontGray"), lineWidth: 3)
                            .frame(width: 258, height: 168)
                    }
            }
            else{
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("FontGray"), lineWidth: 6)
                        .fill(Color("LightGrayBg"))
                        .frame(width: 258, height: 168)
                    Image("OrgLarge")
                }
            }
            PhotosPicker(selection: $avatarItem, matching: .images){
                ZStack{
                    Circle()
                        .stroke(Color("FontGray"), lineWidth: 6)
                        .fill(Color("LightGrayBg"))
                        .frame(width: 50)
                    Image("EditOrgPhoto")
                }
            }.offset(x: 120, y: 75)
        }
    }
    
    private var OrganizationTitleField: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 3).frame(width: 326, height: 56)
                
            TextField("Organization title", text: $organizationTitle)
                .tint(Color("PinkMain"))
                .font(.custom("Prompt-Medium", size: 20))
                .foregroundStyle(Color("FontGray"))
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 15)
        }
        .frame(width: 326, height: 56)
        .padding()
        .padding(.top)
    }
    
    private var Continue: some View{
        MainContinueButton(text: "Continue")
    }
}

//#Preview {
//    AddOrganizationFirst()
//}
