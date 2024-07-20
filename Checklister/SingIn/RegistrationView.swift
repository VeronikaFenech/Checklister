//
//  RegistrationView.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 26.06.2024.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    Spacer()
                    Image("Registration")
                        .padding(37)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 53)
                            .fill(Color("MainGreen"))
                            .opacity(0.5)
                        
                        VStack(spacing: 20){
                            Spacer()
                            HStack{
                                Text("Registration")
                                    .font(.custom("Prompt-SemiBold", size: 25))
                                    .foregroundStyle(Color("FontGray"))
                                Spacer()
                            }
                            .padding(.horizontal, 25)
                            
                            HStack(spacing: 15){
                                NameField
                                SurnameField
                            }
                            
                            EmailField
                            PasswordField
                            
                            Continue
                        }
                    }
                    .frame(width: 364, height: 437)
                    
                    GoToLogin
                }
            }
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
    
    private var NameField: some View{
        ZStack(alignment: .leading){
            TextField("Name", text: $email)
                .tint(Color("PinkMain"))
                .textContentType(.name)
                .font(.custom("Prompt-SemiBold", size: 20))
                .foregroundStyle(Color("LighterGray"))
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 17)
            RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 3)
        }.frame(width: 149, height: 56)
    }
    
    private var SurnameField: some View{
        ZStack(alignment: .leading){
            TextField("Surname", text: $surname)
                .tint(Color("PinkMain"))
                .textContentType(.familyName)
                .font(.custom("Prompt-SemiBold", size: 20))
                .foregroundStyle(Color("LighterGray"))
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 17)
            RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 3)
        }.frame(width: 149, height: 56)
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
        }
        .frame(width: 313, height: 56)
        .padding(.bottom)
    }
    
    private var Continue: some View{
        NavigationLink(destination: EmailConfirmation()) {
            ContinueButton()
        }.padding(.bottom, 40)
    }
    
    var GoToLogin: some View{
        HStack{
            Text("Already have an account?")
                .foregroundStyle(Color("FontGray"))
            NavigationLink(destination: RegistrationView()){
                Text("Sing in")
                    .foregroundStyle(Color("PinkMain"))
            }
        }
        .font(.custom("Prompt-Bold", size: 15))
    }
}

#Preview {
    RegistrationView()
}
