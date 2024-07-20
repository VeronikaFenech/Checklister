//
//  WaitingRequestsRow.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 02.07.2024.
//

import SwiftUI

struct WaitingRequestRow: View{
    private var status: RequestStatus
    
    public init(status: RequestStatus) {
        self.status = status
    }
    
    var body: some View{
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 17).stroke(Color("FontGray"), lineWidth: 3).frame(width: 326, height: 56)
                .padding(.leading, 5)
            ZStack{
                Circle()
                    .fill(Color("MainGreen"))
                    .stroke(Color("FontGray"), lineWidth: 3)
                    .frame(width: 73, height: 73)
                Image("Members")
            }
            HStack{
                Text("Name Surname")
                    .font(.custom("Prompt-SemiBold", size: 20))
                    .foregroundStyle(Color("FontGray"))
                    .padding(.leading, 70)
                    .lineLimit(1)
                Spacer()
                if status != .accepted{
                    ZStack{
                        Circle()
                            .fill(Color("MainGreen"))
                            .stroke(Color("FontGray"), lineWidth: 3)
                            .frame(width: 30)
                        Image("CheckmarkLight")
                    }
                }
                if status == .waiting || status == .accepted{
                    ZStack{
                        Circle()
                            .fill(Color("PinkMain"))
                            .stroke(Color("FontGray"), lineWidth: 3)
                            .frame(width: 30)
                        Minus()
                            .stroke(Color("LightGrayBg"), style: StrokeStyle(lineWidth: 3, lineCap: .round))
                            .frame(width: 15)
                    }
                }
            }.padding(.horizontal, 15)
        }
        .frame(width: 308, height: 56).padding()
    }
}
