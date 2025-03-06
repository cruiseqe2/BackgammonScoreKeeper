//
//  BackgammonScoreKeeperApp.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 04/02/2025.
//

import SwiftUI

@main
struct BackgammonScoreKeeperApp: App {
    
    @State private var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ControllerView()
                .environment(viewModel)
        }
    }
}
