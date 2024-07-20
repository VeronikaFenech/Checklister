//
//  CodeView.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 01.07.2024.
//

import SwiftUI

struct CodeView: View {
    @Binding private var code: String
    @Binding private var checked: Bool?
    @Binding private var active:  Bool
    private let textLimit: Int = 4
    private var completion: () -> Void
    
    init(code: Binding<String>, checked: Binding<Bool?>, active: Binding<Bool>,  completion: @escaping () -> Void) {
        self._code = code
        self._checked = checked
        self._active = active
        self.completion = completion
    }
    
    var body: some View {
        ZStack{
            HStack(spacing: 10) {
                Spacer()
                
                ForEach(0..<textLimit, id: \.self) { index in
                    Text(String(code[index]))
                        .customMod(checked: $checked)
                        .onTapGesture {
                            active = true
                        }
                }
                
                Spacer()
            }
            TextField("", text: $code)
                .introspect(.textField, on: .iOS(.v13, .v14, .v15, .v16, .v17, .v18)) { textField in
                    if active{
                        textField.becomeFirstResponder()
                    }
                }
                .keyboardType(.numberPad)
                .opacity(0)
                .onChange(of: code){
                    limitText(textLimit)
                }
        }.padding(5)
    }
    
    private func limitText(_ upper: Int) {
        if code.count > upper {
            code = String(code.prefix(upper))
            return
        }
        if code.count == upper {
            completion()
        }
    }
}

public struct Modifier: ViewModifier {
    @Binding var checked: Bool?
    
    public func body(content: Content) -> some View {
        content
            .frame(width: 71, height: 96)
        
            .background(RoundedRectangle(cornerRadius: 24).foregroundStyle(Color("LightGrayBg")))
            .overlay(RoundedRectangle(cornerRadius: 24).stroke(checked == nil || checked == true ? Color("FontGray") : Color("PinkMain"), lineWidth: 3))
            .foregroundStyle(Color("FontGray"))
            .font(.custom("Prompt-SemiBold", size: 30))
        
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
    }
}

public extension View {
    func customMod(checked: Binding<Bool?>) -> some View {
        modifier(Modifier(checked: checked))
    }
}
