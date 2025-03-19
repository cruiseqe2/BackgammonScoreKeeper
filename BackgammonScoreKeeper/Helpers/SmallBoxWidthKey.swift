//
//  SmallBoxWidthKey.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 24/02/2025.
//

import Foundation
import SwiftUICore

struct SmallBoxWidthKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
