//
//  CustomPaths.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 11.07.2024.
//

import SwiftUI

struct Arrow: Shape{
    func path(in rect: CGRect) -> Path {
        Path{ path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addCurve(to: CGPoint(x: rect.minX, y: rect.maxY), control1: CGPoint(x: rect.maxX, y: rect.midY + 2), control2: CGPoint(x: rect.maxX, y: rect.midY - 2 ))
        }
    }
}

struct Plus: Shape{
    func path(in rect: CGRect) -> Path {
        Path{ path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        }
    }
}

struct Minus: Shape{
    func path(in rect: CGRect) -> Path {
        Path{ path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        }
    }
}

struct Frame: Shape{
    func path(in rect: CGRect) -> Path {
       
        Path{ path in
            path.move(to: CGPoint(x: rect.height/3, y: 0))
           
            path.addLine(to: CGPoint(x: rect.maxX - rect.height/10, y: rect.minY))
            
            path.addCurve(to: CGPoint(x: rect.maxX - rect.height/10, y: rect.minY + rect.height/6), control1: CGPoint(x: rect.maxX, y: rect.minY), control2: CGPoint(x: rect.maxX, y: rect.minY + rect.height/6))
            
            path.addCurve(to: CGPoint(x: rect.maxX - rect.height/10, y: rect.maxY - rect.height/6),
                          control1: CGPoint(x: rect.maxX - rect.height/2.5, y: rect.midY - rect.height/3.5),
                          control2: CGPoint(x: rect.maxX - rect.height/2.5, y: rect.midY + rect.height/3.5))
            
            path.addCurve(to: CGPoint(x: rect.maxX - rect.height/10, y: rect.maxY), control1: CGPoint(x: rect.maxX, y: rect.maxY - rect.height/6), control2: CGPoint(x: rect.maxX, y: rect.maxY))
            
            path.addLine(to: CGPoint(x: rect.minX + rect.height/3, y: rect.maxY))
            
            path.addCurve(to: CGPoint(x: 0, y: rect.maxY - rect.height/3), control1: CGPoint(x: rect.height/3, y: rect.maxY), control2: CGPoint(x: 0, y: rect.maxY))
            
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + rect.height/3))
            
            path.addCurve(to: CGPoint(x: rect.height/3, y: 0), control1: CGPoint(x: 0, y: rect.height/3), control2: CGPoint(x: 0, y: 0))
           
        }
     
    }
}

