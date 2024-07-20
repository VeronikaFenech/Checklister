//
//  LoginView.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 25.06.2024.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var vm: UserStateViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                Image("Login")
                    .padding(37)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 53)
                        .fill(Color("MainGreen"))
                        .opacity(0.5)
                    
                    VStack(spacing: 20){
                        Spacer()
                        HStack{
                            Text("Login")
                                .font(.custom("Prompt-SemiBold", size: 25))
                                .foregroundStyle(Color("FontGray"))
                            Spacer()
                        }
                        .padding(.horizontal, 25)
                        .padding(.top)
                        
                        EmailField
                        PasswordField
                        Spacer()
                        Continue
                    }
                }
                .frame(width: 364, height: 437)
                
                GoToRegistration
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
    
    private var EmailField: some View{
        ZStack(alignment: .leading){
            TextField("Email", text: $email)
                .tint(Color("PinkMain"))
                .textContentType(.emailAddress)
                .font(.custom("Prompt-SemiBold", size: 20))
                .foregroundStyle(Color("LighterGray"))
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 17)
            RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 3)
        }.frame(width: 313, height: 56)
    }
    
    private var PasswordField: some View{
        ZStack(alignment: .leading){
            TextField("Password", text: $password)
                .textContentType(.password)
                .font(.custom("Prompt-SemiBold", size: 20))
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 17)
            RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 3)
        }.frame(width: 313, height: 56)
    }
    
    private var Continue: some View{
        Button{
            Task{
                await vm.signIn(email: "", password: "")
            }
        }label: {
            ContinueButton()
        }.padding(.bottom, 40)
    }
    
    private var GoToRegistration: some View{
        HStack{
            Text("Not a member yet?")
                .foregroundStyle(Color("FontGray"))
            NavigationLink(destination: RegistrationView()) {
                Text("Sing Up")
                    .foregroundStyle(Color("PinkMain"))
            }
        }
        .font(.custom("Prompt-Bold", size: 15))
    }
}

#Preview {
    LoginView()
}
