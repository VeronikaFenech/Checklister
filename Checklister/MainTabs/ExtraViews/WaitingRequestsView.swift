//
//  WaitingRequestsView.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 30.06.2024.
//

import SwiftUI

struct WaitingRequestsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background").ignoresSafeArea()
                
                ScrollView{
                    VStack{
                        VStack(spacing: 0){
                            WaitingRequestRow(status: .waiting)
                            WaitingRequestRow(status: .waiting)
                            WaitingRequestRow(status: .waiting)
                            WaitingRequestRow(status: .waiting)
                        }
                        HStack{
                            Text("DECLINED MEMBERS")
                                .font(.custom("Prompt-Medium", size: 15))
                                .foregroundStyle(Color("FontGray"))
                            Spacer()
                        }.padding(.horizontal, 30)
                            .padding(.top, 10)
                        VStack(spacing: 0){
                            WaitingRequestRow(status: .declined)
                            WaitingRequestRow(status: .declined)
                        }.padding(.top, -10)
                    }
                    .padding(5)
                    Spacer(minLength: 150)
                }
                .scrollIndicators(.hidden)
            }
            .safeAreaInset(edge: .top){
                AccountTopBar(title: "Waiting Requsets")
            }
            .safeAreaInset(edge: .bottom) {
                HStack(alignment: .center){
                    CustomBottomBackButton {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                }
                .padding(.horizontal, 39)
                .padding(.bottom, 16)
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    WaitingRequestsView()
}
