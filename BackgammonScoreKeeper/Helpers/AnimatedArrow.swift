//
//  AnimatedArrow.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 07/04/2025.
//

import SwiftUI

struct AnimatedArrow: View {
    
    @State private var length: CGFloat = 60
    
    var body: some View {
        HStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 25)
                .fill((Color.orange))
                .frame(width: length, height: 4, alignment: .leading)
            Triangle()
                .fill((Color.orange))
                .frame(width: 30, height: 30)
        }
        .offset(x: length - 85)
        .onAppear {
            withAnimation(Animation.easeIn(duration: 3.0).repeatForever(autoreverses: false)) {
                length = 90
            }
        }
    }
}

#Preview(traits: .landscapeLeft) {
    AnimatedArrow()
        .environment(ViewModel())
}

