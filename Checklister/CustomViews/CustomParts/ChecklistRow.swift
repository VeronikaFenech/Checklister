//
//  ChecklistRow.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 01.07.2024.
//

import SwiftUI

struct ChecklistRowObject: Hashable {
    private var id = UUID()
    internal var progressValue: Float
    internal var text: String
    internal var taskList: String
    internal var image: String
    
    public init(id: UUID = UUID(), progressValue: Float, text: String, taskList: String, image: String) {
        self.id = id
        self.progressValue = progressValue
        self.text = text
        self.taskList = taskList
        self.image = image
    }
}

struct ChecklistRow: View{
    private var checklist: ChecklistRowObject
    
    public init(checklist: ChecklistRowObject) {
        self.checklist = checklist
    }
    
    var body: some View{
        ZStack(alignment: .leading){
            HStack(spacing: -21){
                Frame()
                    .stroke(Color("FontGray"), lineWidth: 3.5)
                    .frame(height: 83)
                    .scaledToFill()
                
                Arrow()
                    .stroke(Color("FontGray"), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                    .frame(width: 7, height: 21)
                    .offset(x: 2)
                    .padding()
                    .frame(width: 34, height: 44)
                    .background(Ellipse().fill(Color("PinkMain")).stroke(Color("FontGray"), lineWidth: 3))
                
            }
            
            HStack{
                ZStack{
                    CircularProgressBar(progress: checklist.progressValue)
                    Image(checklist.image)
                }
                VStack(alignment: .leading){
                    Text(checklist.text)
                        .font(.custom("Prompt-SemiBold", size: 22))
                        .foregroundStyle(Color("FontGray"))
                    Text(checklist.taskList)
                        .font(.custom("Prompt-Regular", size: 11))
                        .foregroundStyle(Color("FontGray"))
                        .lineLimit(2)
                        .environment(\._lineHeightMultiple, 0.8)
                        .multilineTextAlignment(.leading)
                }
                .frame(width: 160)
                .padding(.leading, 15)
                .padding(.top, -10)
            }
            .padding(.horizontal, 20)
        }.frame(height: 83)
        
            .padding(.horizontal, 28)
    }
}
