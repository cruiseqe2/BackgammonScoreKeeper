//
//  TriangleRow.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 23/03/2025.
//

import SwiftUI

struct TriangleRow: View {
    let colors: [Color]
    var body: some View {
        VStack(spacing: 0) {
            ForEach (1..<13) { i in
                Triangle()
                    .fill(i % 2 == 0 ? colors[0] : colors[1])
            }
        }
    }
}

#Preview(traits: .landscapeLeft) {
    HStack {
        TriangleRow(colors: [.red.opacity(0.8), .green.opacity(0.8)])
            .frame(width: 200, height: 350)
        Spacer()
        TriangleRow(colors: [.red.opacity(0.8), .green.opacity(0.8)])
            .rotationEffect(.degrees(180))
            .frame(width: 200, height: 350)
    }
}
