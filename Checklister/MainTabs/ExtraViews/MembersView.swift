//
//  MembersView.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 30.06.2024.
//

import SwiftUI

struct MembersView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background").ignoresSafeArea()
                ScrollView{
                    VStack(spacing: 0){
                        WaitingRequestRow(status: .accepted)
                        WaitingRequestRow(status: .accepted)
                        WaitingRequestRow(status: .accepted)
                        WaitingRequestRow(status: .accepted)
                    }
                    .padding(5)
                    Spacer(minLength: 150)
                }
                .scrollIndicators(.hidden)
            }
            .safeAreaInset(edge: .top){
                AccountTopBar(title: "Members")
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
    MembersView()
}
