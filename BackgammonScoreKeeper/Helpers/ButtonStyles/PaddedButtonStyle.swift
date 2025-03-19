//
//  PaddedButtonStyle.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 18/03/2025.
//

import Foundation
import SwiftUI

struct PaddedButtonStyle: ButtonStyle {
    let foregroundColor: Color
    let backgroundColor: Color
    let cornerRadius: Double
    let naturalWidth: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 8)
            .padding(.horizontal, naturalWidth ? nil : 0)
            .foregroundColor(foregroundColor)
            .background(backgroundColor.gradient)
            .cornerRadius(cornerRadius)
    }
}

extension View {
    func paddedButtonStyle(foregroundColor: Color = .white,
                           backgroundColor: Color = .red,
                           cornerRadius: Double = 6,
                           naturalWidth: Bool = true
    ) -> some View {
        self.buttonStyle(PaddedButtonStyle(foregroundColor: foregroundColor,
                                           backgroundColor: backgroundColor,
                                           cornerRadius: cornerRadius,
                                           naturalWidth: naturalWidth)
        )
    }
}

