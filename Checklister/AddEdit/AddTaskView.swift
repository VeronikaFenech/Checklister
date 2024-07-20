//
//  AddTaskView.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 29.06.2024.
//

import SwiftUI
import PhotosUI
import Nuke
import NukeUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    private let columns = Array(repeating: GridItem(.flexible()), count: 3)
    @State private var taskName: String = ""
    @State private var description: String = ""
    @State private var photoNeeded: Bool = false
    @Binding private var showAlert: Bool
    @State private var photoItems: [PhotosPickerItem] = []
    @State private var photoImages: [HashableImage] = []
    @State private var isShowingPhoto: Bool = false
    public init(showAlert: Binding<Bool>){
        self._showAlert = showAlert
    }
    var body: some View {
        NavigationStack{
            ZStack{
                ScrollView{
                    VStack{
                        HStack{
                            Text("Add new task in section Cleaning:")
                                .font(.custom("Prompt-Medium", size: 15))
                                .foregroundStyle(Color("FontGray"))
                            Spacer()
                        }.padding(.horizontal, 33)
                        
                        Title
                        Description
                        PhotoConfirmation
                        PhotoSector
                    }.padding(5)
                    Spacer(minLength: 150)
                }
                .scrollIndicators(.hidden)
            }
            .navigationDestination(isPresented: $isShowingPhoto) {
                GalleryView(
                    urls: photoImages.map { ($0.url, PacketType.image) },
                    selected: 0,
                    configuration: GalleryConfiguration(errorImage: UIImage(systemName: "photo")!)
                )
            }
            .navigationBarBackButtonHidden()
            .safeAreaInset(edge: .top){
                AccountTopBar(title: "Sushi&Wine", ownerMode: true, switchOrgAvailable: true, showAlert: $showAlert)
            }
            .safeAreaInset(edge: .bottom){
                HStack(alignment: .center){
                    CustomBottomBackButton {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                    MainContinueButton(text: "Add")
                }
                .padding(.horizontal, 39)
                .padding(.bottom, 16)
            }
            .onChange(of: photoItems) {
                Task {
                    photoImages = []
                    for item in photoItems{
                        if let loadedImage = try? await item.loadTransferable(type: Image.self){
                            getURL(item: item) { result in
                                switch result {
                                case .success(let url):
                                    // Use the URL as you wish.
                                    photoImages.append(HashableImage(image: loadedImage, url: url))
                                case .failure(let failure):
                                    print(failure.localizedDescription)
                                }
                            }
                        }else {
                            print("Failed")
                        }
                    }
                }
            }
        }
    }
    
    private var Title: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 3).frame(width: 326, height: 56)
            TextField("Task title", text: $taskName)
                .tint(Color("PinkMain"))
                .textContentType(.emailAddress)
                .font(.custom("Prompt-Medium", size: 20))
                .foregroundStyle(Color("FontGray"))
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 15)
        }
        .frame(width: 326, height: 56)
        .padding(.horizontal)
    }
    
    private var Description: some View{
        ZStack(alignment: .leading){
            
            TextEditor(text: $description)
                .font(.custom("Prompt-Regular", size: 15))
                .tint(Color("PinkMain"))
                .foregroundColor(Color("FontGray"))
                .cornerRadius(17)
            VStack{
                Text("Action description")
                    .font(.custom("Prompt-Regular", size: 15))
                    .foregroundColor(Color.gray.opacity(description.isEmpty ? 0.5 : 0))
                    .padding(.horizontal, 5)
                    .padding(.vertical, 7)
                Spacer()
            }
            
        }.padding(.horizontal, 10)
            .padding(.vertical, 7)
            .overlay(RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 3).frame(width: 326))
            .frame(width: 326, height: 170)
            .padding(.horizontal)
            .padding(.vertical)
    }
    
    private var PhotoConfirmation: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 3).frame(width: 326, height: 56)
            HStack{
                Button{
                    photoNeeded.toggle()
                } label:{
                    ZStack{
                        Circle()
                            .fill(Color("LightGrayBg"))
                            .stroke(Color("FontGray"), lineWidth: 2)
                            .frame(width: 30, height: 30)
                        if photoNeeded{
                            Image("CheckSmallDark")
                        }
                    }
                }
                Text("Photo confirmation needed")
                    .font(.custom("Prompt-Medium", size: 15))
                    .foregroundStyle(Color("FontGray"))
                    .padding(.horizontal, 10)
                Spacer()
            }.padding(.horizontal, 15)
        }.frame(width: 326, height: 56)
    }
    @MainActor
    private var PhotoSector: some View{
        VStack{
            HStack{
                Text("ADD PHOTO:")
                    .font(.custom("Prompt-SemiBold", size: 12))
                    .foregroundStyle(Color("FontGray"))
                Spacer()
            }
            .padding(.horizontal, 33)
            .padding(.top, 5)
            LazyVGrid(columns: columns, spacing: 20) {
                PhotosPicker(selection: $photoItems, matching: .images){
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("FontGray"), lineWidth: 3).frame(width: 93, height: 93)
                        Plus()
                            .stroke(Color("FontGray"), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                            .frame(width: 45, height: 45)
                    }
                }
                ForEach(photoImages, id: \.self){ photo in
                    LazyImage(url: photo.url) { state in
                        if let image = state.image{
                            image
                                .resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                .frame(width: 93, height: 93)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay(RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color("FontGray"), lineWidth: 3).frame(width: 93, height: 93))
                                .onTapGesture {
                                    isShowingPhoto = true
                                }
                        }else{
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color("FontGray"), lineWidth: 3).frame(width: 93, height: 93).foregroundStyle(Color("LightGrayBg"))
                        }
                    }
                }
                
            }.padding(.horizontal, 20)
            .padding(.vertical, -10)
        }
    }
}



