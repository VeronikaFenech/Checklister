//
//  Enums.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 02.07.2024.
//

import Foundation


enum TaskStatus{
    case done
    case unspecified
    case undone
    
}

extension TaskStatus {
    mutating func toggle() {
        switch self {
        case .done:
            self = .unspecified
        case .unspecified:
            self = .done
        case .undone:
            return
        }
    }
}

enum ChecklistMode{
    case edit
    case basic
}

enum RequestStatus{
    case declined
    case waiting
    case accepted
}
