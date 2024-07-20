//
//  ContentView.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 31.05.2024.
//

import SwiftUI
import SwiftData

struct WelcomeScreen: View {

    var body: some View {
        NavigationStack{
            ZStack{
                Color("background").ignoresSafeArea()
                VStack{
                    Spacer()
                    Text("Welcome to \nChecklister!")
                        .font(.custom("Prompt-Bold", size: 35))
                        .foregroundStyle(Color("FontGray"))
                    Text("Sing in or create a new account")
                        .font(.custom("Prompt-SemiBold", size: 18))
                        .foregroundStyle(Color("FontGray"))
                        .padding(.bottom, 70)
                    ZStack{
                        RoundedRectangle(cornerRadius: 53)
                            .fill(Color("MainGreen"))
                            .opacity(0.5)
                        VStack{
                            Spacer()
                            LoginButton
                            SingUpButton
                            Spacer()
                            GoogleLogin
                            AppleLogin
                            Spacer()
                        }
                    }
                    .frame(width: 364, height: 437)
                    .padding(.bottom, 30)
                }
            }
        }
    }
    
    private var LoginButton: some View{
        NavigationLink(destination: LoginView()){
            CustomButton(text: "Login", widthDif: 25).padding(.horizontal, 10)
        }
    }
    
    private var SingUpButton: some View{
        NavigationLink(destination: RegistrationView()){
            CustomButton(text: "Sing up", widthDif: 25)
        }
    }
    
    private var GoogleLogin: some View{
        Button{
            print("google login")
        } label:{
            BasicButton(image: "GoogleIcon", text: "Continue with Google")
        }
    }
    
    private var AppleLogin: some View{
        Button{
            print("apple login")
        } label:{
            BasicButton(image: "AppleIcon", text: "Continue with Apple")
        }
    }
}

#Preview{
    WelcomeScreen()
}

