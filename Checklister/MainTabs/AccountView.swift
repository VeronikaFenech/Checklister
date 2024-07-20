//
//  AccountView.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 28.06.2024.
//

import SwiftUI
import PhotosUI

struct AccountView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var name: String = "Name"
    @State private var surname: String = "Surname"
    @State private var editName: Bool = false
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background").ignoresSafeArea()
                VStack(spacing: 0){
                    AccountImage
                    AccountName
                    VStack{
                        ScrollView{
                            VStack{
                                HStack(alignment: .center){
                                    Text("ORGANIZATIONS")
                                        .font(.custom("Prompt-SemiBold", size: 12))
                                        .foregroundStyle(Color("FontGray"))
                                    Spacer()
                                    AddOrganizanionButton
                                }
                                OrganizationList
                                VStack(spacing: 13){
                                    Email
                                    ResetPassword
                                    Share
                                }
                                Spacer(minLength: 50)
                                VStack(spacing: 13){
                                    LogOut
                                    Delete
                                }
                                Spacer(minLength: 50)
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 2)
                            Spacer(minLength: 150)
                        }
                        .scrollIndicators(.hidden)
                        
                    }
                    .padding(.horizontal, 38)
                }.ignoresSafeArea()
            }
            .safeAreaInset(edge: .bottom) {
                AddChecklistButton
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    TopBackButton {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
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
            .onChange(of: name) { oldValue, newValue in
                if newValue.count > 35{
                    name = oldValue
                }
            }
            .onChange(of: surname) { oldValue, newValue in
                if newValue.count > 35{
                    surname = oldValue
                }
            }
        }
    }
    
    private var AccountImage: some View{
        ZStack{
            if let image = avatarImage{
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 330, height: 300)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(Color("FontGray"), lineWidth: 4)
                            .frame(width: 330, height: 300)
                    }
            }
            else{
                ZStack{
                    Circle()
                        .stroke(Color("FontGray"), lineWidth: 8)
                        .fill(Color("MainGreen"))
                        .frame(width: 330, height: 300)
                    Image("AccMain")
                }
            }
            PhotosPicker(selection: $avatarItem, matching: .images){
                ZStack{
                    Circle()
                        .stroke(Color("FontGray"), lineWidth: 8)
                        .fill(Color("LightGrayBg"))
                        .frame(width: 65, height: 65)
                    Image("EditAccPhoto")
                }
            }.offset(x: -110, y: 100)
            
        }.offset(x: 100, y: -20)
    }
    
    private var AccountName: some View{
        HStack{
            if editName{
                EditMode
            }else{
               ViewMode
            }
            Spacer()
        }
        .tint(Color("PinkMain"))
        .font(.custom("Prompt-SemiBold", size: 25))
        .foregroundStyle(Color("FontGray"))
        .multilineTextAlignment(.leading)
        .padding(.horizontal, 40)
        .padding(.top, -30)
    }
    
    private var ViewMode: some View{
        VStack(alignment: .leading, spacing: 0){
            Text(name)
            HStack(alignment: .bottom){
                Text(surname)
                Button{
                    editName = true
                } label: {
                    Image("EditName")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 17.6)
                }.padding(.bottom, 9)
            }
        }
    }
    
    private var EditMode: some View{
        VStack(alignment: .leading, spacing: -1.5){
            TextField("Name", text: $name)
            HStack{
                TextField("Surname", text: $surname)
                
                Button{
                    editName = false
                } label: {
                    Image("CheckSmallDark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 17.6)
                }
            }
        }.padding(.vertical, -0.75)
    }
    
    private var AddOrganizanionButton: some View{
        Button{
            
        }label:{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("FontGray"), lineWidth: 2)
                    .foregroundStyle(Color("LightGrayBg"))
                    .frame(width: 56, height: 27)
                HStack(spacing: 3){
                    Plus()
                        .stroke(Color("FontGray"), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                        .frame(width: 11, height: 11)
                    Text("Add")
                        .font(.custom("Prompt-Medium", size: 13))
                        .foregroundStyle(Color("FontGray"))
                }

            }
            
        }
    }
    
    private var AddChecklistButton: some View{
        HStack{
            Spacer()
            Button{
            }label: {
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
    
    private var OrganizationList: some View{
        VStack(spacing: 10){
            SwitchOrgRow(selected: false, role: "Member")
            SwitchOrgRow(selected: true, role: "Owner")
            
        }.padding(.top, -5).padding(.bottom, 10)
    }
    
    private var Email: some View{
        SettingsRow(image: "email", text: "john.smith@example.com", rotation: false)
    }
    
    private var ResetPassword: some View{
        SettingsRow(image: "ResetPswd", text: "Reset password", rotation: false)
    }
    
    private var Share: some View{
        SettingsRow(image: "Share", text: "Share", rotation: false)
    }
    
    private var LogOut: some View{
        SettingsRow(image: "LogOut", text: "Log out", rotation: false)
    }
    
    private var Delete: some View{
        SettingsRow(image: "Bin", text: "Delete account", rotation: false)
    }
}

#Preview {
    AccountView()
}
