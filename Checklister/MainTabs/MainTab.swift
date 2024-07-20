//
//  MainTab.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 27.06.2024.
//

import SwiftUI

struct MainTab: View {
    @State private var tabSelection: TabBarItem = .home
    @State private var showAlert = false
    @StateObject private var tabBarVisibilityManager = TabBarVisibilityManager()
    @StateObject var vm = MainViewState()
    var body: some View {
        ZStack{
            Color("background").ignoresSafeArea()
            
            CustomTabViewContainer(selection: $tabSelection) {
                VStack{
                    if vm.isNoOrganization {
                        AddOrJoingView()
                    }else if vm.isEmptyView{
                        MainView(showAlert: $showAlert)
                    }else if vm.notEmptyView{
                        TestMainView(showAlert: $showAlert)
                    }
                }.tabBarItem(tab: .home, selection: $tabSelection)
                
                SettingsView(showAlert: $showAlert)
                    .tabBarItem(tab: .settings, selection: $tabSelection)
            }.environmentObject(tabBarVisibilityManager)
            .environmentObject(vm)
            if showAlert {
                CustomAlert(showAlert: $showAlert)
                    .animation(.easeInOut(duration: 1), value: showAlert)
            }
        }
    }
}

@MainActor
class MainViewState: ObservableObject {
    
    @Published var isNoOrganization = true
    @Published var isEmptyView = false
    @Published var notEmptyView = false
    
    func addOrg(){
        isNoOrganization = false
        //UserDefaults.standard.set(true, forKey: "notEmptyView")
    }
    
    func emptyView(){
        isEmptyView = true
    }
    
    func fillView(){
        isEmptyView = false
        notEmptyView = true
    }
}
