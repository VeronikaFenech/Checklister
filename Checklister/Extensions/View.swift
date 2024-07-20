//
//  View.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 11.07.2024.
//

import SwiftUI

public extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
