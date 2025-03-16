//
//  MintBorder.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 15/03/2025.
//

import SwiftUI

struct MintBorder: ViewModifier {
    
    func body(content: Content) -> some View {
        content
          .overlay(
                RoundedRectangle(cornerRadius: 10)
//                    .strokeBorder(.mint)
                    .strokeBorder(.mint, lineWidth: 2)
            )
          .background(.gray.opacity(0.5))
    }
}

extension View {
    func mintBorder() -> some View {
        modifier(MintBorder())
    }
}
