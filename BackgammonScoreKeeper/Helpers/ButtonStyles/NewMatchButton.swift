//
//  NewMatchButton.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 13/03/2025.
//

import SwiftUI

struct NewMatchButton: View {
    let buttonTitle: String
    let fgColor: Color
    let bgColor: Color
    let isDisabled: Bool
    let action: () -> Void
    
    init(buttonTitle: String, bgColor: Color, fgColor: Color, isDisabled: Bool = false, action: @escaping () -> Void) {
        self.buttonTitle = buttonTitle
        self.fgColor = fgColor
        self.bgColor = bgColor
        self.isDisabled = isDisabled
        self.action = action
    }
    
    var body: some View {
        Button(buttonTitle, action: action)
            .font(.system(.title3, design: .rounded))
            .frame(maxWidth: 120, maxHeight: 44)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .foregroundStyle(fgColor)
            .background(bgColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .disabled(isDisabled)
            .opacity(1.0)
    }
}
