//
//  Color.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 20/02/2025.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let foreground = Color.fgColour
    let background = Color.bgColour
}

struct Colors {
    public static let mainColor = "mainColor"
    public static let lightShadow = "lightShadow"
    public static let darkShadow = "darkShadow"
}
