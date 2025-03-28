//
//  Triangle.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 23/03/2025.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        return path
    }
}

#Preview(traits: .landscapeLeft) {
    Triangle()
        .fill(.red)
        .frame(width: 400, height: 200)
}
