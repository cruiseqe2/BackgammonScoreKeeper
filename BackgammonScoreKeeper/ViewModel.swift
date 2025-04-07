//
//  ViewModel.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 05/02/2025.
//

import Foundation
import UIKit
import SwiftUI

@Observable
class ViewModel {
    var deviceOrientation: UIDeviceOrientation = .portrait
    
    var appStages: AppStages = .welcomeScreen
    var appPhase: AppPhase = .welcome
    
    var firstOwnerName: String = "Mark"
    var secondOwnerName: String = ""
    var ownerGames: Int = 0
    var ownerPoints: Int = 0
    
    var firstOpponentName: String = "kkj"
    var secondOpponentName: String = ""
    var opponentGames: Int = 0
    var opponentPoints: Int = 0
    
    var namesAreValid: Bool {
        firstOpponentName.isNotEmpty ? true : false
    }
    
    var positionOfOwner: PositionOfOwner = .leftHandSide
    
    var kVersion: String = "CFBundleShortVersionString"
    var kBuild: String = "CFBundleVersion"
    var version: String {
        getVersion()
    }
    var opacityOfGameBoard: CGFloat = 0.7
    
    var typeOfMatch: TypeOfMatch = .points
    var finishWhen: FinishWhen = .firstTo
    var numbersToShow: ValidGamesOrPoints {
        finishWhen == .bestOf ? .oddsOnly : .all
    }
    var doublingCubeStatus: DoublingCubeStatus = .hide
    var numberOfGamesOrPoints: Int? = 5
    var winningScoreIfBestOfGames: Int? {
        guard let numberOfGamesOrPoints else { return nil }
        return Int(numberOfGamesOrPoints / 2) + 1
    }
    
    var currentGameState: CurrentGameState {
        winnerIs == .noWinnerYet ? .matchInProgress : .readyToStartMatch
    }
    
    var hideMatchViewAfterConfig = false
    var welcomeShown: Bool = false
    var isConfigurePlayersShown: Bool = false
    var screenToShow: Screen = .none
    var showNewScreen: Bool = false
    
    var crawfordStatus: CrawfordStatus = .notPointsBased
    
    var useDoublingCube: Bool = true
    var showSmallBoxIfPointsBased: Bool = true
    
    var doublingCubeYPosition: CGFloat = 0.0
    var totalWidth: CGFloat = 0.0 /// NOT USED ANY MORE
    var sizeOfContent: CGSize = .zero
    var smallBoxWidth: CGFloat = 0.0
    var largeBoxWidth: CGFloat = 0.0
    var middleColumnWidth: CGFloat = 0.0
    var doublingCubeTotalWidth: CGFloat {
        (((smallBoxWidth / 2 ) + 25) * 2) + middleColumnWidth
    }
    
    var showDoublingCheck: Bool = false
    var showDoublingOffer: Bool = false
    var cubeValue = 1
    var offerMessage: String = ""
    var cubeOfferedTo: OfferCubeTo = .owner  // this is just a random default to avoid init{}
    
    var cubeOpacity: Double = 1
    var slideOpacity: Double = 1
    var whoHasTheDoublingCube: WhoHasTheDoublingCube = .middle
    var doublingCubeOffset: CGFloat {
        switch whoHasTheDoublingCube {
        case .owner:
            return positionOfOwner == .leftHandSide ? -doublingCubeTotalWidth / 2.0  : doublingCubeTotalWidth / 2.0
        case .middle:
            return 0.0
        case .opponent:
            return positionOfOwner == .leftHandSide ? doublingCubeTotalWidth / 2.0 : -doublingCubeTotalWidth / 2.0
        }
    }
    
    var winnerIs: WinnerIs? = .matchAbandoned
    
    /// Populate the Left and Right hand side of the main display
    
    var ownerDisplayName: String {
        return firstOwnerName + (secondOwnerName.isNotEmpty ? " & " + secondOwnerName : "")
    }
    
    var opponentDisplayName: String {
        return firstOpponentName + (secondOpponentName.isNotEmpty ? " & " + secondOpponentName : "")
    }
    
    var LHSName: String {
        return positionOfOwner == .leftHandSide ? ownerDisplayName : opponentDisplayName
    }
    var LHSGames: Int {
        return positionOfOwner == .leftHandSide ? ownerGames : opponentGames
    }
    var LHSPoints: Int {
        return positionOfOwner == .leftHandSide ? ownerPoints : opponentPoints
    }
    
    var RHSName: String {
        return positionOfOwner == .rightHandSide ? ownerDisplayName : opponentDisplayName
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
    
    func startMatch() {
        ownerGames = 0
        opponentGames = 0
        ownerPoints = 0
        opponentPoints = 0
        winnerIs = .noWinnerYet
        whoHasTheDoublingCube = .middle
        cubeValue = 1
        cubeOpacity = 1
        slideOpacity = 1
        crawfordStatus = typeOfMatch == .points ? .preCrawford : .notPointsBased
    }
    
    func startGame() {
        whoHasTheDoublingCube = .middle
        cubeValue = 1
        cubeOpacity = 1
        slideOpacity = 1
    }
    
    func trigger(offerCubeTo: OfferCubeTo) -> Void {
        cubeOfferedTo = offerCubeTo
        withAnimation(.linear(duration: 0.4)) {
            showDoublingCheck = true
            showDoublingOffer = false
        }
    }
    
    func doublingOfferAccpted(_ accepted: Bool) {
        showDoublingOffer = false
        if accepted {
            whoHasTheDoublingCube = cubeOfferedTo == .owner ? .owner : .opponent
            cubeOpacity = 1
            withAnimation {
                cubeValue *= 2
            }
        } else {
            cubeOpacity = 1
        }
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
            withAnimation {
                ownerPoints += value
                ownerGames += 1
            }
        } else {
            withAnimation {
                opponentPoints += value
                opponentGames += 1
            }
        }
        startGame()
        
        checkForCrawford()
        checkForWinner()
    }
    
    /// Update the Crawford details.
    
    func checkForCrawford() {
        guard let numberOfGamesOrPoints else { return }
        switch crawfordStatus {
        case .notPointsBased:
            break
        case .preCrawford:
            if ownerPoints == numberOfGamesOrPoints - 1          ||
                opponentPoints == numberOfGamesOrPoints - 1 {
                crawfordStatus = .isCrawford
            }
        case .isCrawford:
            crawfordStatus = .postCrawford
        case .postCrawford:
            break
        }
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
    
    /// Log the matches
    
    func log() {
        //        var whyDidMatchFinish: String
        //
        //        switch currentGameState {
        //        case .socialGameActive:
        //            break     // Should never get here!
        //        case .matchInProgress:
        //            break     // Should never get here!
        //        case .matchFinished:
        //            whyDidMatchFinish = "match finished"
        //        case .matchAbandoned:
        //            whyDidMatchFinish = "match abandoned"
        //        }
        
        
        
        
        //        print("---------------")
        //        print("Players: \(ownerDisplayName) vs \(opponentDisplayName)")
        //        print("Type of Match: \(typeOfMatch)")
        //        print("Result was ")
    }
    
    func getVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary[kVersion] as! String
        let build = dictionary[kBuild] as! String
        return "\(version) (\(build))"
    }
    
}


