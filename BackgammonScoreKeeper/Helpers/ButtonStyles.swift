//
//  ButtonStyles.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 09/03/2025.
//

import SwiftUI

struct CustomConfigureChangeStyle: ButtonStyle {
    var isChange: Bool
    init(isChange: Bool) {
        self.isChange = isChange
    }
    func makeBody(configuration: Configuration) -> some View {
        Group {
            Text(isChange ? "Change" : "Configure")
                .padding([.leading, .trailing], 15)
                .frame(maxWidth: 120, maxHeight: 44)
                .background(isChange ? .orange : .blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .scaleEffect(configuration.isPressed ? 0.90 : 1)
                .opacity(configuration.isPressed ? 0.5 : 1)
        }
    }
       
}

extension ButtonStyle where Self == CustomConfigureChangeStyle {
    static func xyz(isChange: Bool = true) -> Self {
        .init(isChange: isChange)
    }
}
