//
//  DropViewDelegate.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 09.07.2024.
//

import Foundation
import SwiftUI

struct DropViewDelegate: DropDelegate {
    
    let destinationItem: TaskObject
    @Binding var taskList: [TaskObject]
    @Binding var draggedItem: TaskObject?
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        draggedItem = nil
        return true
    }
    
    func dropEntered(info: DropInfo) {
        // Swap Items
        if let draggedItem {
            let fromIndex = taskList.firstIndex(of: draggedItem)
            if let fromIndex {
                let toIndex = taskList.firstIndex(of: destinationItem)
                if let toIndex, fromIndex != toIndex {
                    withAnimation {
                        self.taskList.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: (toIndex > fromIndex ? (toIndex + 1) : toIndex))
                    }
                }
            }
        }
    }
}
