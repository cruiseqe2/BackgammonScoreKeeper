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
    var ownerGames: Int = 5
    var ownerPoints: Int = 10


    var opponentName: String = "Alice"
    var opponentGames: Int = 1
    var opponentPoints: Int = 2
    
    
    var positionOfOwner: PositionOfOwner = .leftHandSide
    
    var typeOfMatch: TypeOfMatch = .games
    var finishWhen: FinishWhen = .bestOf
    var pointsOrGamesToWin : PointsOrGamesToWin? = .points
    var numberOfGamesOrPoints: Int? = 11
    var winningScoreIfBestOfGames: Int? {
        guard let numberOfGamesOrPoints else { return nil }
        return Int(numberOfGamesOrPoints / 2) + 1
    }
    
    var showDoublingCube: Bool = true
    var showGamesBoxIfPointsBased: Bool = true
    
    var showTestingButtons: Bool = true
    var doublingCubeYPosition: CGFloat = 0.0
    var totalWidth: CGFloat = 0.0 /// NOT USED ANY MORE
    var gamesBoxWidth: CGFloat = 0.0
    var middleColumnWidth: CGFloat = 0.0
    var doublingCubeTotalWidth: CGFloat {
        (((gamesBoxWidth / 2 ) + 25) * 2) + middleColumnWidth
    }
    var winnerIs: WinnerIs? = .noWinnerYet
    
    /// Populate the Left and Right hand side of the main display
    
    var LHSName: String {
        return positionOfOwner == .leftHandSide ? owmerName : opponentName
    }
    var LHSGames: Int {
        return positionOfOwner == .leftHandSide ? ownerGames : opponentGames
    }
    var LHSPoints: Int {
        return positionOfOwner == .leftHandSide ? ownerPoints : opponentPoints
    }
    
    var RHSName: String {
        return positionOfOwner == .rightHandSide ? owmerName : opponentName
    }
    var RHSGames: Int {
        return positionOfOwner == .rightHandSide ? ownerGames : opponentGames
    }
    var RHSPoints: Int {
        return positionOfOwner == .rightHandSide ? ownerPoints : opponentPoints
    }
    
    /// Populate the middle column lines
    
    var line1: String {
        switch typeOfMatch {
        case .social:
            "Social"
        case .games:
            finishWhen == .bestOf ? "Best Of" : "First To"
        case .points:
            "First To"
        }
    }
    
    var line2: String {
        guard typeOfMatch != .social else { return "" }
        return ("\(numberOfGamesOrPoints ?? 0)")
    }
    
    var line3: String {
        guard typeOfMatch != .social else { return "" }
        return (typeOfMatch == .games ? "Games" : "Points")
    }


    /// Should BumpUp be visible
    var bumpUpVisible: Bool {
        typeOfMatch == .social ? false : true
    }
    
    /// Should BumpDown be visible
    var bumpDownVisible: Bool {
        guard bumpUpVisible else { return false }
        let currentTotal = (pointsOrGamesToWin == .points ? ownerPoints + opponentPoints : ownerGames + opponentGames)
        
        return (numberOfGamesOrPoints! > currentTotal ? true : false)
    }
    
    func clearGame() {
        ownerGames = 0
        opponentGames = 0
        ownerPoints = 0
        opponentPoints = 0
        winnerIs = .noWinnerYet
    }
    
    
    func swapPositions() {
        if positionOfOwner == .rightHandSide {
            positionOfOwner = .leftHandSide
        } else {
            positionOfOwner = .rightHandSide
        }
    }

//    func bumpUp() {
//        numberOfGamesOrPoints! += (typeOfGame == .bestOf ? 2 : 1)
//    }
//    
//    func bumpDown() {
//        numberOfGamesOrPoints! -= (typeOfGame == .bestOf ? 2 : 1)
//    }
    
    /// Handle the 'winning' buttons

    func WinningButtonTapped(side: Side, value: Int) {
        
        if side == .owner {
            ownerPoints += value
            ownerGames += 1
        } else {
            opponentPoints += value
            opponentGames += 1
        }
        
        checkForWinner()
    }

    /// Check to see if somebody has won
    
    func checkForWinner() {
        guard typeOfMatch != .social else { return }
        
        if typeOfMatch == .points {
            if ownerPoints >= numberOfGamesOrPoints!  {
                winnerIs = .owner
                return
            }
            if opponentPoints >= numberOfGamesOrPoints!  {
                winnerIs = .opponent
                return
            }
        } else {  // typeOfMatch = .games as .social has been ruled out by the guard statement
            if finishWhen == .bestOf {
                if ownerGames >= winningScoreIfBestOfGames!  {
                    winnerIs = .owner
                    return
                }
                if opponentGames >= winningScoreIfBestOfGames!  {
                    winnerIs = .opponent
                    return
                }
            } else {  // finishWhen = .firstTo
                if ownerGames >= numberOfGamesOrPoints!  {
                    winnerIs = .owner
                    return
                }
                if opponentGames >= numberOfGamesOrPoints!  {
                    winnerIs = .opponent
                    return
                }
            }
        }
    }
    
}



