//
//  MainMenuButton.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 10/03/2025.
//

import SwiftUI

struct MainMenuButton: View {
    let buttonTitle: String
    let action: () -> Void
    let color: Color
    
    init(buttonTitle: String, color: Color = .purple, action: @escaping () -> Void ) {
        self.buttonTitle = buttonTitle
        self.color = color
        self.action = action
    }
    
    var body: some View {
        Button(buttonTitle, action: action)
            .frame(maxWidth: .infinity)
            .font(.system(.title3, design: .rounded))
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            .foregroundStyle(.white)
            .background(color)
            .clipShape(Capsule())
    }
}
