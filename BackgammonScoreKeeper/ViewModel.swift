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
    var myGamesWon: Int = 5
    var opponentGamesWon: Int = 1
    var myPoints: Int = 10
    var opponentPoints: Int = 2
    var typeOfGame: TypeOfGame = .firstTo
    var pointsOrGamesToWin : PointsOrGamesToWin? = .points
    var numberOfGamesOrPoints: Int? = 11
    var timeStarted = Date()
    var timeFinished = Date()
    
    var LHSName: String {
        return isOnRight ? opponent : owmerName
    }
    var LHSGames: Int {
        return isOnRight ? opponentGamesWon : myGamesWon
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
        if let numberOfGamesOrPoints {
            "\(numberOfGamesOrPoints)"
        } else {
            ""
        }
    }
    
    var line3: String {
        if let pointsOrGamesToWin {
            switch pointsOrGamesToWin {
            case .games:
                return "Games"
            case .points:
                return "Points"
            }
        } else {
            return ""
        }
    }
    
    
    var RHSName: String {
        return isOnRight ? owmerName : opponent
    }
    var RHSGames: Int {
        return isOnRight ? myGamesWon : opponentGamesWon
    }
    var RHSPoints: Int {
        return isOnRight ? myPoints : opponentPoints
    }
    
    
    
    
    
    func swapPositions() {
        isOnRight.toggle()
    }

    
    
}

