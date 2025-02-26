//
//  ViewModel.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 05/02/2025.
//

import Foundation
import UIKit

@Observable
class ViewModel {
    var deviceOrientation: UIDeviceOrientation = .portrait
    var owmerName: String = "Mark"
    var isOnRight: Bool = true
    
    var opponent: String = "Alice"
    var myGames: Int = 5
    var opponentGames: Int = 1
    var myPoints: Int = 10
    var opponentPoints: Int = 2
    var typeOfGame: TypeOfGame = .bestOf
    var pointsOrGamesToWin : PointsOrGamesToWin? = .points
    var numberOfGamesOrPoints: Int? = 11
    var timeStarted = Date()
    var timeFinished = Date()
    var showDoublingCube: Bool = true
    
    var doublingCubeYPosition: CGFloat = 0.0
    var totalWidth: CGFloat = 0.0 /// NOT USED ANY MORE
    var gamesBoxWidth: CGFloat = 0.0
    var middleColumnWidth: CGFloat = 0.0
    var doublingCubeTotalWidth: CGFloat {
        (((gamesBoxWidth / 2 ) + 25) * 2) + middleColumnWidth
    }
    
    var LHSName: String {
        return isOnRight ? opponent : owmerName
    }
    var LHSGames: Int {
        return isOnRight ? opponentGames : myGames
    }
    var LHSPoints: Int {
        return isOnRight ? opponentPoints : myPoints
    }
    
    var line1: String {
            switch typeOfGame {
            case .friendly:
                "Friendly"
            case .firstTo:
                "First To"
            case .bestOf:
                "Best Of"
            }
    }
    
    var line2: String {
        guard typeOfGame != .friendly else { return "" }
        return ("\(numberOfGamesOrPoints ?? 0)")
    }
    
    var line3: String {
        guard let pointsOrGamesToWin else { return "" }
        return (pointsOrGamesToWin == .games ? "Games" : "Points")
    }
    
    
    var RHSName: String {
        return isOnRight ? owmerName : opponent
    }
    var RHSGames: Int {
        return isOnRight ? myGames : opponentGames
    }
    var RHSPoints: Int {
        return isOnRight ? myPoints : opponentPoints
    }
    
    
    /// Should BumpUp be visible
    var bumpUpVisible: Bool {
        typeOfGame == .friendly ? false : true
    }
    
    /// Should BumpDown be visible
    var bumpDownVisible: Bool {
        guard bumpUpVisible else { return false }
        let currentTotal = (pointsOrGamesToWin == .points ? myPoints + opponentPoints : myGames + opponentGames)
        return (numberOfGamesOrPoints! > currentTotal ? true : false)
    }
    
    
    
    
    
    
    func swapPositions() {
        isOnRight.toggle()
    }

    func bumpUp() {
        numberOfGamesOrPoints! += (typeOfGame == .bestOf ? 2 : 1)
    }
    
    func bumpDown() {
        numberOfGamesOrPoints! -= (typeOfGame == .bestOf ? 2 : 1)
    }
    
    
}

