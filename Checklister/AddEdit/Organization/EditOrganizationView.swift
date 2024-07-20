//
//  EditOrganizationView.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 28.06.2024.
//

import SwiftUI
import PhotosUI

struct EditOrganizationView: View {
    @State var orgName: String = "Sushi&Wine"
    @EnvironmentObject private var tabBarVisibilityManager: TabBarVisibilityManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @Binding private var showAlert: Bool
    public init(showAlert: Binding<Bool>){
        self._showAlert = showAlert
    }
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background").ignoresSafeArea()
                VStack{
                    ScrollView{
                        VStack{
                            EditOrganizationImage
                            Spacer(minLength: 20)
                            VStack(spacing: 0){
                                Title
                                NavigationLink {
                                    MembersView()
                                } label: {
                                    MembersButton
                                }
                                NavigationLink {
                                    InviteMembers()
                                } label: {
                                    InviteButton
                                }
                                NavigationLink {
                                    WaitingRequestsView()
                                } label: {
                                    WaitingRequests
                                }
                            }
                            Spacer(minLength: 30)
                            DeleteButton
                            
                        }.padding()
                        Spacer(minLength: 50)
                    }
                    .scrollIndicators(.hidden)
                    
                }.padding(.vertical)
            }
            .safeAreaInset(edge: .top){
                AccountTopBar(title: "Edit organization")
            }
            .safeAreaInset(edge: .bottom){
                HStack(alignment: .center){
                    CustomBottomBackButton {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                    MainContinueButton(text: "Save")
                }
                .padding(.horizontal, 39)
                .padding(.bottom, 16)
            }
            .onAppear{
                tabBarVisibilityManager.hideTabBar()
            }
            .navigationBarBackButtonHidden(true)
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
    
    private var EditOrganizationImage: some View{
        ZStack{
            if let image = avatarImage{
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 258, height: 168)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("FontGray"), lineWidth: 3))
            }else{
                Image("OrgLarge")
                    .padding()
                    .frame(width: 258, height: 168)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("FontGray"), lineWidth: 3))
            }
            PhotosPicker(selection: $avatarItem, matching: .images){
                ZStack{
                    Circle()
                        .stroke(Color("FontGray"), lineWidth: 6)
                        .fill(Color("LightGrayBg"))
                        .frame(width: 50, height: 50)
                    Image("EditOrgPhoto")
                }
            }.offset(x: 120, y: 70)
        }
    }
    
    private var Title: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 3).frame(width: 313, height: 56)
            TextField("Organization name", text: $orgName)
                .tint(Color("PinkMain"))
                .font(.custom("Prompt-Medium", size: 20))
                .foregroundStyle(Color("FontGray"))
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 29)
        }.padding()
    }
    
    private var MembersButton: some View{
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 3).frame(width: 308, height: 56)
                .padding(.leading, 5)
            ZStack{
                Circle()
                    .fill(Color("MainGreen"))
                    .stroke(Color("FontGray"), lineWidth: 3)
                    .frame(width: 73, height: 73)
                Image("Members")
            }
            HStack{
                Text("Members")
                    .font(.custom("Prompt-SemiBold", size: 20))
                    .foregroundStyle(Color("FontGray"))
                    .padding(.leading, 75)
                Spacer()
                Arrow()
                    .stroke(Color("FontGray"), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                    .frame(width: 5, height: 14)
                    .offset(x: 2)
            }.padding(.horizontal, 15)
        }.frame(width: 308, height: 56).padding()
    }
    
    private var InviteButton: some View{
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 3).frame(width: 308, height: 56)
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
                Spacer()
                Arrow()
                    .stroke(Color("FontGray"), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                    .frame(width: 5, height: 14)
                    .offset(x: 2)
            }.padding(.horizontal, 15)
        }.frame(width: 308, height: 56).padding()
    }
    
    private var WaitingRequests: some View{
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 3).frame(width: 308, height: 56)
                .padding(.leading, 5)
            ZStack{
                Circle()
                    .fill(Color("LightGrayBg"))
                    .stroke(Color("FontGray"), lineWidth: 3)
                    .frame(width: 73, height: 73)
                Image("WaitingRequests")
            }
            HStack{
                Text("Waiting Requests")
                    .font(.custom("Prompt-SemiBold", size: 20))
                    .foregroundStyle(Color("FontGray"))
                    .padding(.leading, 75)
                Spacer()
                Arrow()
                    .stroke(Color("FontGray"), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                    .frame(width: 5, height: 14)
                    .offset(x: 2)
            }.padding(.horizontal, 15)
        }.frame(width: 308, height: 56).padding()
    }
    
    private var DeleteButton: some View{
        HStack{
            ZStack{
                Circle()
                    .fill(Color("PinkMain"))
                    .stroke(Color("FontGray"), lineWidth: 3)
                    .frame(width: 29, height: 29)
                Minus()
                    .stroke(Color("LightGrayBg"), style: StrokeStyle(lineWidth: 3, lineCap: .round))
                    .frame(width: 14)
            }
            Text("Delete Organization")
                .font(.custom("Prompt-SemiBold", size: 17))
                .foregroundStyle(Color("PinkMain"))
                .underline()
                .padding(.horizontal, 7)
            Spacer()
        }.padding(.horizontal, 40)
    }
}

