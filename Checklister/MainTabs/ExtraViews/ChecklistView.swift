//
//  ChecklistView.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 29.06.2024.
//

import SwiftUI
import SwipeActions

struct ChecklistView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var tabBarVisibilityManager: TabBarVisibilityManager
    @State private var draggedTask: TaskObject?
    @State private var mode: ChecklistMode = .basic
    @State private var progressValue: Float = 0.8
    @Binding private var showAlert: Bool
    @State private var taskList: [TaskObject] = [TaskObject(status: .done, photoNeeded: true, text: "Clean kitchen"), TaskObject(status: .unspecified, photoNeeded: false,  text: "Clean coffe machine"), TaskObject(status: .unspecified, photoNeeded: false, text: "Do dishes")]
    public init(showAlert: Binding<Bool>){
        self._showAlert = showAlert
    }
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background").ignoresSafeArea()
                VStack{
                    if mode == .edit{
                        EditInstractions
                    }else{
                        HStack{
                            Text("80%")
                            Spacer()
                            Text("Cleaning")
                        }
                        .font(.custom("Prompt-SemiBold", size: 25))
                        .foregroundStyle(Color("FontGray"))
                        .padding(.horizontal, 35)
                        ProgressBar(value: $progressValue)
                            .frame(height: 12)
                            .padding(.horizontal, 33)
                            .padding(.top, -10)
                    }
                    Spacer(minLength: 30)
                    VStack{
                        ScrollView{
                            VStack(spacing: 15){
                                if mode == .edit{
                                    NavigationLink {
                                        AddTaskView(showAlert: $showAlert)
                                    } label: {
                                        AddTaskButton
                                    }
                                }
                                Tasks
                            }
                            .padding(5)
                            .padding(.horizontal)
                            Spacer(minLength: 50)
                        }
                        .scrollIndicators(.hidden)
                    }
                }
            }
            .safeAreaInset(edge: .top){
                AccountTopBar(title: "Sushi&Wine", ownerMode: true, switchOrgAvailable: true, showAlert: $showAlert)
            }
            .safeAreaInset(edge: .bottom){
                HStack{
                    if mode == .edit{
                        EditModeBottomBar
                    }else{
                        BasicModeBottomBar
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
    
    private var EditInstractions: some View{
        VStack(spacing: 3){
            Text("Edit mode is on, arrange the tasks with")
                .font(.custom("Prompt-Medium", size: 15))
                .foregroundStyle(Color("FontGray"))
            HStack{
                Image("Arrange")
                Text("or use")
                    .font(.custom("Prompt-Medium", size: 15))
                    .foregroundStyle(Color("FontGray"))
                Image("TaskSettingsGroup")
                Text("to edit")
                    .font(.custom("Prompt-Medium", size: 15))
                    .foregroundStyle(Color("FontGray"))
            }
        }.padding(.top, 10).padding(.bottom, -10)
    }
    
    private var AddTaskButton: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 3).frame(width: 326, height: 56)
            HStack{
                Plus()
                    .stroke(Color("FontGray"), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                    .frame(width: 21, height: 21)
                    .padding()
                    .frame(width: 24, height: 24)
                Text("Add task")
                    .font(.custom("Prompt-Medium", size: 15))
                    .foregroundStyle(Color("FontGray"))
                    .padding(.horizontal, 10)
                Spacer()                    
                Arrow()
                    .stroke(Color("FontGray"), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                    .frame(width: 5, height: 14)
                    .offset(x: 2)
            }.padding(.horizontal, 15)
        }.frame(width: 326, height: 56)
    }
    
    private var Tasks: some View{
        ForEach(taskList, id: \.self){ task in
            if mode == .edit{
                SwipeView{
                    TaskRow(content: task, mode: $mode)
                        .overlay(RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 6)).clipShape(RoundedRectangle(cornerRadius: 17))
                        
                } trailingActions: { _ in
                        SwipeAction{
                            taskList = taskList.filter { $0 != task }
                        } label: { _ in
                            Text("Delete")
                                .foregroundStyle(Color("LightGrayBg"))
                                .font(.custom("Prompt-Medium", size: 15))
                        } background: { _ in
                            Color("PinkMain")
                            
                        }.overlay(RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 6))
                    
                }
                .swipeActionsStyle(.equalWidths)
                .swipeActionCornerRadius(0)
                .swipeActionsMaskCornerRadius(17)
                
                .onDrag {
                    self.draggedTask = task
                    return NSItemProvider()
                }
                .onDrop(of: [.item],
                              delegate: DropViewDelegate(destinationItem: task, taskList: $taskList, draggedItem: $draggedTask)
                    )
                .animation(.linear, value: taskList)
            }else{
                TaskRow(content: task, mode: $mode)
            }
                                              }
    }
    
    private var BasicModeBottomBar: some View{
        HStack{
            Button{
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                ZStack{
                    Circle().fill(Color("LightGrayBg")).stroke(Color("FontGray"), lineWidth: 4)
                    Arrow()
                        .stroke(Color("FontGray"), style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                        .frame(width: 10, height: 31).rotationEffect(.degrees(180)).offset(x: -3)
                }.frame(width: 68, height: 68)
            }
            Spacer()
            Button{
                mode = .edit
                
            } label:{
                ZStack{
                    Circle().fill(Color("LightGrayBg")).stroke(Color("FontGray"), lineWidth: 4)
                    Image("EditTasks")
                }.frame(width: 68, height: 68)
            }
        }
    }
    
    private var EditModeBottomBar: some View{
        HStack{
            Button{
                mode = .basic
            } label: {
                ZStack{
                    Circle().fill(Color("LightGrayBg")).stroke(Color("FontGray"), lineWidth: 4)
                    Image("Cancel")
                }.frame(width: 68, height: 68)
            }
            Spacer()
            Button{
                mode = .basic
                //accept settings
                
            } label: {
                ZStack{
                    Circle().fill(Color("LightGrayBg")).stroke(Color("FontGray"), lineWidth: 4)
                    Image("CheckmarkLarge")
                }.frame(width: 68, height: 68)
            }
        }
    }
    
    private func startProgressBar() {
        for _ in 0...100 {
            self.progressValue += 0.1
        }
    }
}

//#Preview {
//    ChecklistView(showAlert: .constant(false))
//}



