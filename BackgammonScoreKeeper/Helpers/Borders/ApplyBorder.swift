//
//  ApplyBorder.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 27/03/2025.
//


import SwiftUI

struct MintBorder: ViewModifier {
    let radius: CGFloat
    func body(content: Content) -> some View {
        content
          .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .strokeBorder(.mint, lineWidth: 2)
            )
          .background(.black)
    }
}

struct Glowing: ViewModifier {
    let radius: CGFloat
    func body(content: Content) -> some View {
            content
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing), lineWidth: 5)
                    .shadow(color: .teal.opacity(0.9), radius: 10)
            }
    }
}

extension View {
    func applyBorder(borderType: BorderTypes, radius: CGFloat) -> some View {
        Group {
            switch borderType {
            case .glowing:
                modifier(Glowing(radius: radius))
            case .mint:
                modifier(MintBorder(radius: radius))
            }
        }
    }
}

