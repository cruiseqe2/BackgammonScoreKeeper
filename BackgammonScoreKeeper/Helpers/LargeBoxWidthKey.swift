//
//  LargeBoxWidthKey.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 18/03/2025.
//

import Foundation
import SwiftUICore

struct LargeBoxWidthKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
