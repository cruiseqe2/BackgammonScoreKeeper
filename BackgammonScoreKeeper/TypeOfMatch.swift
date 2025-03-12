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
    case matchAbandoned
}

enum Side {
    case owner
    case opponent
}

enum SinglesOrDoubles {
    case singles
    case doubles
}

enum DoublingCubeStatus {
    case show
    case hide
}

enum ValidGamesOrPoints {
    case all
    case evensOnly
    case oddsOnly
}

enum CrawfordStatus {
    case notPointsBased
    case preCrawford
    case isCrawford
    case postCrawford
}

enum CurrentGameState {
    case socialGameActive
    case matchInProgress
    case matchFinished
    case matchAbandoned
}

enum ActionOnReturnFromNewGame {
    case startGame
    case cancel
}
