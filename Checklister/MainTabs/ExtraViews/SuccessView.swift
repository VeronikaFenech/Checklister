//
//  SuccessView.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 30.06.2024.
//

import SwiftUI

struct SuccessView: View {
    @EnvironmentObject private var tabBarVisibilityManager: TabBarVisibilityManager
    @EnvironmentObject var vm: MainViewState
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var organizationTitle: String = ""
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background").ignoresSafeArea()
                VStack{
                    Spacer()
                    Image("Success")
                    Text("Organization \n“Sushi&Wine” \ncreated successfully!")
                        .font(.custom("Prompt-Medium", size: 27))
                        .foregroundStyle(Color("FontGray"))
                        .frame(width: 346)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }
            .safeAreaInset(edge: .top, content: {
                AccountTopBar(title: "Success")
                    .onTapGesture {
                        tabBarVisibilityManager.showTabBar()
                    }
            })
            .safeAreaInset(edge: .bottom){
                HStack{
                CustomBottomBackButton {
                    tabBarVisibilityManager.showTabBar()
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Button {
                    vm.addOrg()
                    vm.emptyView()
                } label: {
                    MainContinueButton(text: "Continue")
                    
                }
            }
            .padding(.bottom, 16)
            .padding(.horizontal, 39)
            }
            .navigationBarBackButtonHidden()
            .onAppear{
                tabBarVisibilityManager.hideTabBar()
            }
        }
    }
}

#Preview {
    SuccessView()
}
