//
//  Bindings.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 08/03/2025.
//

import SwiftUI

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
