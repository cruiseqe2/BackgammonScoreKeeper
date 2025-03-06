//
//  TypeOfMatch.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 04/02/2025.
//

import Foundation

enum TypeOfMatch: CaseIterable {
    case social
    case games
    case points
//    
//    case firstTo
//    case bestOf
}

enum PositionOfOwner {
    case leftHandSide
    case rightHandSide
}

enum FinishWhen {
    case bestOf
    case firstTo
    case social
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

enum WinnerIs {
    case owner
    case opponent
    case noWinnerYet
}

enum Side {
    case owner
    case opponent
}

enum SinglesOrDoubles {
    case singles
    case doubles
}
