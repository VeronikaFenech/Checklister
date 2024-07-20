//
//  CustomAlert.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 01.07.2024.
//

import SwiftUI

struct CustomAlert: View {
    @Binding private var showAlert: Bool
    
    public init(showAlert: Binding<Bool>) {
        self._showAlert = showAlert
    }

    var body: some View {
        ZStack(alignment: .leading){
            Color.black.opacity(0.3).ignoresSafeArea().onTapGesture {
                showAlert = false
            }

            VStack(alignment: .leading, spacing: 10){
                SwitchOrganizationAlertRow(selected: true, role: "Owner")
                SwitchOrganizationAlertRow(selected: false, role: "Member")
                SwitchOrganizationAlertRow(selected: false, role: "Member")
                Spacer()
            }.padding(.leading, 35)
                .padding(.top, 35)
        }
    }
}
