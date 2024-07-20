//
//  EmailConfirmation.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 26.06.2024.
//

import SwiftUI
import Foundation
import UIKit
import SwiftUIIntrospect

struct EmailConfirmation: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var vm: UserStateViewModel
    @State private var code: String = ""
    @State private var active: Bool = true
    @State private var checked:  Bool? = nil
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                Image("EmailConfirmation")
                    .padding(30)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 53)
                        .fill(Color("MainGreen"))
                        .opacity(0.5)
                    
                    VStack(spacing: 20){
                        InfoText
                        
                        CodeView(code: $code, checked: $checked, active: $active) {
                            print("hh")
                        }
                        Continue
                        ResendCodeButton
                    }
                }
                .frame(width: 364, height: 437)
                .padding(.bottom, 70)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("background").ignoresSafeArea(.container))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    TopBackButton {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
    private var InfoText: some View{
        VStack(spacing: 0){
            Text("Enter code from Email")
                .font(.custom("Prompt-Bold", size: 25))
                .foregroundStyle(Color("FontGray"))
                .padding(.bottom, 5)
            
            Text("We sent it to your email")
                .multilineTextAlignment(.center)
                .foregroundStyle(Color("FontGray"))
                .font(.custom("Prompt-Medium", size: 15))
                .tint(Color("FontGray"))
            HStack{
                Text("john.smith@example.com")
                    .tint(Color("FontGray"))
                    .font(.custom("Prompt-Medium", size: 15))
                Button{} label: { Text("Change").foregroundStyle(Color("PinkMain"))
                    .font(.custom("Prompt-Medium", size: 15))}
            }
        }
    }
    
    private var Continue: some View{
        Button{
            Task{
                await vm.signIn(email: "", password: "")
            }
        } label: {
            ContinueButton()
        }
    }
    
    private var ResendCodeButton: some View{
        Button{
            
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 17)
                    .stroke(Color("FontGray"), lineWidth: 3)
                Text("Resend code in 30 sec")
                    .foregroundStyle(Color("FontGray"))
                    .font(.custom("Prompt-Medium", size: 20))
                
            }.frame(width: 330, height: 53)
        }.padding(.bottom, 5)
    }
}




#Preview {
    EmailConfirmation()
}
