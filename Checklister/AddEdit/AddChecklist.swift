//
//  AddChecklist.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 30.06.2024.
//

import SwiftUI
import PhotosUI

struct AddChecklist: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var tabBarVisibilityManager: TabBarVisibilityManager
    @EnvironmentObject private var vm: MainViewState
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var checklistTitle: String = ""
    @Binding private var showAlert: Bool
    init(showAlert: Binding<Bool>){
        self._showAlert = showAlert
    }
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background").ignoresSafeArea()
                VStack{
                    HStack{
                        Text("Add new checklist for “Sushi&Wine”:")
                            .font(.custom("Prompt-Medium", size: 15))
                            .foregroundStyle(Color("FontGray"))
                        Spacer()
                    }.padding(.horizontal, 33)
                    
                    EditChecklistImage
                    ChecklistTitleField
                    Spacer()
                }
                
            }
            .safeAreaInset(edge: .top){
                AccountTopBar(title: "Sushi&Wine", ownerMode: true, switchOrgAvailable: true, showAlert: $showAlert)
            }
            .safeAreaInset(edge: .bottom){
                HStack(alignment: .center){
                    CustomBottomBackButton {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                    Button {
                        vm.fillView()
                    } label: {
                        MainContinueButton(text: "Add")
                    }

                }
                .padding(.horizontal, 39)
                .padding(.bottom, 16)
            }
            .onAppear{
                 tabBarVisibilityManager.hideTabBar()
            }
            .onDisappear{
                  tabBarVisibilityManager.showTabBar()
            }
            .navigationBarBackButtonHidden()
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
    
    private var EditChecklistImage: some View{
        ZStack{
            if let image = avatarImage{
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 161, height: 161)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(Color("FontGray"), lineWidth: 3)
                    }
            }
            else{
                ZStack{
                    Circle()
                        .stroke(Color("FontGray"), lineWidth: 6)
                        .fill(Color("LightGrayBg"))
                        .frame(width: 161)
                    Image("ChecklistLarge")
                }
            }
            PhotosPicker(selection: $avatarItem, matching: .images){
                ZStack{
                    Circle()
                        .stroke(Color("FontGray"), lineWidth: 6)
                        .fill(Color("LightGrayBg"))
                        .frame(width: 50)
                    
                    Image("EditChecklistImage")
                }
            }.offset(x: 60, y: 60)
        }
    }
    
    private var ChecklistTitleField: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 3).frame(width: 326, height: 56)
            TextField("Checklist title", text: $checklistTitle)
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
}

