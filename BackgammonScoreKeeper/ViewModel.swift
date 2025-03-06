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
    
    var singlesOrDoubles: SinglesOrDoubles = .doubles
    var ownerSecondName: String? = "Adam"
    var opponentSecondName: String? = "Steve"
    
    var positionOfOwner: PositionOfOwner = .leftHandSide
    
    var typeOfMatch: TypeOfMatch = .games
    var finishWhen: FinishWhen = .bestOf
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
    
    var ownerNameDisplay: String {
        if singlesOrDoubles == .doubles {
            owmerName + " & " + ownerSecondName!
        } else {
            owmerName
        }
    }
    
    var opponentNameDisplay: String {
        if singlesOrDoubles == .doubles {
            opponentName + " & " + opponentSecondName!
        } else {
            opponentName
        }
    }
    
    
    
    var LHSName: String {
        return positionOfOwner == .leftHandSide ? ownerNameDisplay : opponentNameDisplay
    }
    var LHSGames: Int {
        return positionOfOwner == .leftHandSide ? ownerGames : opponentGames
    }
    var LHSPoints: Int {
        return positionOfOwner == .leftHandSide ? ownerPoints : opponentPoints
    }
    
    var RHSName: String {
        return positionOfOwner == .rightHandSide ? ownerNameDisplay : opponentNameDisplay
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
        guard winnerIs == .noWinnerYet else { return false }
        guard typeOfMatch != .social else { return false }
        return true
    }
    
    /// Should BumpDown be visible
    var bumpDownVisible: Bool {
        guard bumpUpVisible else { return false }
        guard let numberOfGamesOrPoints else { return false }
        
        if typeOfMatch == .points {
            return numberOfGamesOrPoints > ownerPoints + 1        &&
                   numberOfGamesOrPoints > opponentPoints + 1
            ? true : false
        }
        
        if typeOfMatch == .games {
            if finishWhen == .firstTo {
                return numberOfGamesOrPoints > ownerGames + 1     &&
                       numberOfGamesOrPoints > opponentGames + 1
                ? true : false
            } else {     // .BestOf
                return winningScoreIfBestOfGames! > ownerGames + opponentGames ? true : false
            }
        }
        
        return false     // We should never get here!!!!!
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

    /// Handle the 'bumping' buttons
    
    func bumpUp() {
        numberOfGamesOrPoints! += (finishWhen == .bestOf ? 2 : 1)
    }
    
    func bumpDown() {
        numberOfGamesOrPoints! -= (finishWhen == .bestOf ? 2 : 1)
        
        // Ensure that if we are bumping down and are points based AND
        // it is a .bestOf scenario AND we have landed on an EVEN
        // number, then add 1 to ensure that it is ODD.
        if typeOfMatch == .points && finishWhen == .bestOf && !(numberOfGamesOrPoints! .isMultiple(of: 2)) {
            numberOfGamesOrPoints! += 1
        }
    }
    
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



