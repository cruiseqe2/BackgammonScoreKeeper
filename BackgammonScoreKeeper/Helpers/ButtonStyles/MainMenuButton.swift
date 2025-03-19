//
//  MainMenuButton.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 10/03/2025.
//

import SwiftUI

struct MainMenuButton: View {
    let buttonTitle: String
    let color: Color
    let isDisabled: Bool
    let action: () -> Void
    
    init(buttonTitle: String, color: Color = .purple, isDisabled: Bool = false, action: @escaping () -> Void) {
        self.buttonTitle = buttonTitle
        self.color = color
        self.isDisabled = isDisabled
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(buttonTitle)
                .frame(maxWidth: .infinity)
                .font(.system(.title3, design: .rounded))
                .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                .foregroundStyle(.white)
                .background(color.gradient)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.white, lineWidth: 2))
                .contentShape(Capsule())
                .disabled(isDisabled)
                .opacity(isDisabled ? 0.3 : 1)
        }
    }
}
