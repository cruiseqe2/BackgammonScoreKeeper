//
//  TypeOfGame.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 04/02/2025.
//

import Foundation

enum TypeOfGame : CaseIterable {
    case friendly
    case firstTo
    case bestOf
}

enum WhichWayRound {
    case isLandscapeLeft
    case isLandscapeRight
    case isInvalid
}

enum SideToProcess {
    case leftHandSide
    case rightHandSide
}
