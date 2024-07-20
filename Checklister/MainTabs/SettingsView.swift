//
//  SettingsView.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 27.06.2024.
//

import SwiftUI
import UIKit

struct SettingsView: View {
    @State private var doNotDisturb: Bool = false
    @State private var push: Bool = true
    @Binding private var showAlert: Bool
    public init(showAlert: Binding<Bool>){
        self._showAlert = showAlert
    }
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background").ignoresSafeArea()
                VStack{
                    ScrollView{
                        VStack(spacing: 70){
                            VStack(spacing: 25){
                                EditOrg
                                Language
                                Theme
                                DoNotDisturb
                                
                                Push
                            }
                            VStack(spacing: 25){
                                Instractions
                                Privacy
                                Rate
                                Version
                            }
                            Spacer()
                        }
                        .padding(.vertical, 25)
                        .padding(.horizontal, 32)
                        Spacer(minLength: 150)
                    }
                    .scrollIndicators(.hidden)
                    
                }
            }
            .safeAreaInset(edge: .bottom){
                AccountBottomBar()
            }
            .navigationBarBackButtonHidden()
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 2){
                        NavigationLink(destination: EditOrganizationView(showAlert: $showAlert)) {
                            Image("OrgSettings")
                                .frame(width: 30, height: 30)
                        }
                        Text("Sushi&Wine")
                            .font(.custom("Prompt-Bold", size: 27))
                            .foregroundStyle(Color("FontGray"))
                        Button{
                            showAlert = true
                        }label: {
                            Arrow()
                                .stroke(Color("FontGray"), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                                .frame(width: 5, height: 14)
                                .offset(x: 2)
                                .padding(10)
                                .rotationEffect(.degrees(90))
                        }
                        Spacer()
                    }.padding()
                }

            }
        }
    }
    
    private var EditOrg: some View{
        SettingsRow(image: "EditOrgWhite", text: "Edit organization", rotation: false)
    }
    
    private var Language: some View{
        SettingsRow(image: "Language", text: "Language", rotation: true)
    }
    
    private var Theme: some View{
        SettingsRow(image: "Theme", text: "Theme", rotation: true)
    }
    
    private var DoNotDisturb: some View{
        HStack(spacing: 20){
            Image("DoNotDisturb")
            Toggle(isOn: $doNotDisturb, label: {
                Text("Do not disturb")
                    .font(.custom("Prompt-SemiBold", size: 18))
                    .foregroundStyle(Color("FontGray"))
            }).tint(Color("MainGreen"))
        }
    }
    
    private var Push: some View{
        HStack(spacing: 20){
            Image("Push")
                .frame(width: 30, height: 30)
            Toggle(isOn: $push, label: {
                Text("Push")
                    .font(.custom("Prompt-SemiBold", size: 18))
                    .foregroundStyle(Color("FontGray"))
            }).tint(Color("MainGreen"))
        }
    }
    
    private var Instractions: some View{
        SettingsRow(image: "Instractions", text: "Instractions", rotation: false)
    }
    
    private var Privacy: some View{
        SettingsRow(image: "Privacy", text: "Privacy policy", rotation: false)
    }
    
    private var Mail: some View{
        SettingsRow(image: "Mail", text: "Support", rotation: false)
    }
    
    private var Rate: some View{
        SettingsRow(image: "Rate", text: "Rate the app", rotation: false)
    }
    
    private var Version: some View{
        SettingsRow(image: "Version", text: "Version", rotation: false)
    }
}


