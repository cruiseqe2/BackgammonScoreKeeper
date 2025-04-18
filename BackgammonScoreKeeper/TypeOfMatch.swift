//
//  TypeOfMatch.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 04/02/2025.
//

import Foundation

enum Screen: Equatable {
    case none
    case match(config: Bool)
    case history
    case rules
    case layouts
    case settings
    case about
}

enum AppStages {
    case welcomeScreen
    case setupOwnerName
    case mainGamePlay
}

enum AppPhase {
    case welcome
    case setupOwnerName
    case mainGamePlay
}

enum TypeOfMatch: String, RawRepresentable, CaseIterable {
    case social   = "Social"
    case games    = "Games"
    case points   = "Points"
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

enum GamesFinishCondition: String, RawRepresentable, CaseIterable {
    case GFCBestOf   = "Best Of"
    case GFCFirstTo  = "First To"
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
    case matchCancelledBeforeStarting
    case socialMatchesStopped
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
    case matchInProgress
    case readyToStartMatch
}

enum ActionOnReturnFromNewGame {
    case startGame
    case cancel
}

enum BorderTypes {
    case mint
    case glowing
}

enum OfferCubeTo {
    case owner
    case opponent
}

enum WhoHasTheDoublingCube {
    case owner
    case opponent
    case middle
    
}
