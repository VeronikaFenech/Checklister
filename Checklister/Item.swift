//
//  Item.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 31.05.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
