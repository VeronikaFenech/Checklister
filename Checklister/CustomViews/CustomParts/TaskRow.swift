//
//  TaskRow.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 02.07.2024.
//

import SwiftUI

struct TaskObject: Identifiable, Hashable{
    var id = UUID()
    internal var status: TaskStatus = .unspecified
    internal var photoNeeded: Bool
    internal var text: String
    
    public init(id: UUID = UUID(), status: TaskStatus, photoNeeded: Bool, text: String) {
        self.id = id
        self.status = status
        self.photoNeeded = photoNeeded
        self.text = text
    }
}

struct TaskRow: View{
    private var content: TaskObject
    @State private var status: TaskStatus = .unspecified
    @State private var tapped: Bool = false
    private let columns = Array(repeating: GridItem(.flexible()), count: 3)
    @Binding private var mode: ChecklistMode
    public init(content: TaskObject, mode: Binding<ChecklistMode>) {
        self.content = content
        self._mode = mode
        self.status = content.status
       
    }
    var body: some View{
        ZStack{
            if tapped{
                RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 3).frame(width: 326)
            }else{
                RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 3).frame(width: 326, height: 56)
            }
            VStack{
                HStack{
                    if mode == .edit{
                        Image("Arrange")//edit by for each index
                    }else{
                        Button{
                            status.toggle()
                        }label:{
                            ZStack{
                                Circle()
                                    .fill(status == .unspecified ? Color("LightGrayBg") : Color("MainGreen"))
                                    .stroke(Color("FontGray"), lineWidth: 2)
                                    .frame(width: 30, height: 30)
                                
                                if status == .done{
                                    Image("CheckmarkLight")
                                }else if status == .unspecified{
                                    Minus()
                                        .stroke(Color("FontGray"), style: StrokeStyle(lineWidth: 3, lineCap: .round))
                                        .frame(width: 12)
                                }
                                
                            }
                        }
                    }
                    Text(content.text)
                        .font(.custom("Prompt-SemiBold", size: 15))
                        .foregroundStyle(Color("FontGray"))
                        .padding(.horizontal, 10)
                    Spacer()
                    if content.photoNeeded && mode != .edit{
                        Image("Camera")
                            .padding(.horizontal, 10)
                    }
                    if mode == .edit{
                        Button{
                            
                        }label:{
                            Image("TaskSettingsGroup")
                        }
                    }else{
                        Button{
                            tapped.toggle()
                        }label:{
                            Arrow()
                                .stroke(Color("FontGray"), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                                .frame(width: 5, height: 14)
                                .offset(x: 2)
                                .rotationEffect(.degrees(tapped ? 90 : 0))
                                .animation(.linear(duration: 0.2), value: tapped)
                            
                        }
                    }
                }
                if tapped{
                    VStack(spacing: 15){
                        ZStack{
                            RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 3)
                            Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.")
                                .font(.custom("Prompt-Regular", size: 15))
                                .foregroundStyle(Color("LighterGray"))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 7)
                        }.frame(width: 298).scaledToFill()
                        LazyVGrid(columns: columns, spacing: 10) {
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color("FontGray"), lineWidth: 3).frame(width: 93, height: 93)
                                Text("Photo")
                                    .font(.custom("Prompt-SemiBold", size: 13))
                                    .foregroundStyle(Color("FontGray"))
                            }
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color("FontGray"), lineWidth: 3).frame(width: 93, height: 93)
                                Text("Photo")
                                    .font(.custom("Prompt-SemiBold", size: 13))
                                    .foregroundStyle(Color("FontGray"))
                            }
                        }
                        if content.photoNeeded{
                            HStack{
                                Text("*Photo confirmation is needed")
                                    .font(.custom("Prompt-SemiBold", size: 13))
                                    .foregroundStyle(Color("FontGray"))
                                Spacer()
                            }.padding(.vertical, -5)
                        }
                        
                        HStack{
                            Button{
                                tapped.toggle()
                            } label:{
                                ZStack{
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color("FontGray"), lineWidth: 3).frame(width: 129, height: 43)
                                    Image("ArrowUp")
                                }
                            }
                            Spacer()
                            Button{
                               
                            } label:{
                                ZStack{
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color("FontGray"), lineWidth: 3).fill(Color("MainGreen")).frame(width: 129, height: 43)
                                    Text("Done")
                                        .foregroundStyle(Color("LightGrayBg"))
                                        .font(.custom("Prompt-SemiBold", size: 25))
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 13)
           
            
        }.frame(width: 326).scaledToFit()
    }
}


