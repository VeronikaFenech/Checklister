//
//  TestMainView.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 01.07.2024.
//

import SwiftUI

struct TestMainView: View {
    @EnvironmentObject private var tabBarVisibilityManager: TabBarVisibilityManager
    @Binding private var showAlert: Bool
    private var checklistArray: [ChecklistRowObject] = [ChecklistRowObject(progressValue: 0.8, text: "Cleaning", taskList: "Clean kitchen, clean coﬀee, machine, do dishes", image: "Cleaning"), ChecklistRowObject(progressValue: 0.5, text: "Checklist", taskList: "Task title, task title, task title, task title", image: "DefaultChecklist")]
    public init(showAlert: Binding<Bool>){
        self._showAlert = showAlert
    }
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background").ignoresSafeArea()
                if checklistArray.count == 0{
                    EmptyViewFill
                }else{
                    NotEmptyViewFill
                }
            }
            .safeAreaInset(edge: .top) {
                AccountTopBar(title: "Sushi&Wine", ownerMode: true, switchOrgAvailable: true, showAlert: $showAlert)
            }
            .safeAreaInset(edge: .bottom) {
                PlusBottomBar(showAlert: $showAlert)
            }
            .navigationBarBackButtonHidden()
            .onAppear{
                tabBarVisibilityManager.showTabBar()
            }
        }
    }
    
    private var EmptyViewFill: some View{
        VStack{
            Spacer()
            Image("Magnifier")
            Text("There are no checklists in “Sushi&Wine” yet")
                .font(.custom("Prompt-Medium", size: 27))
                .foregroundStyle(Color("FontGray"))
                .frame(width: 268)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
    
    private var NotEmptyViewFill: some View{
        ScrollView{
            VStack(spacing: 20){
                ForEach(checklistArray, id: \.self){ checklist in
                    NavigationLink {
                        ChecklistView(showAlert: $showAlert)
                    } label: {
                        ChecklistRow(checklist: checklist)
                    }
                }
            }
            .padding(10)
            Spacer(minLength: 150)
        }
        .scrollIndicators(.hidden)
    }
}
