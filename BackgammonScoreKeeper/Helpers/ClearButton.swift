//
//  ClearButton.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 06/03/2025.
//

import SwiftUI

struct ClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "delete.backward.fill").foregroundStyle(.orange.gradient.opacity(0.6))
                        .foregroundStyle(.gray)
                }
                .padding(.trailing, 8)
            }
        }
    }
}

extension View {
    func clearButton(text: Binding<String>) -> some View {
        modifier(ClearButton(text: text))
    }
}
