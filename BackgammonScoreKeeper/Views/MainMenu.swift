//
//  MainMenu.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 10/02/2025.
//

import SwiftUI
import UIKit

struct MainMenu: View {
    @Environment(ViewModel.self) var vm
    @State private var showAbandonMatchAlert = false
    @State private var notImplementedYet = false
    
    private var verticalTextOffset: CGFloat {
        UIScreen.main.bounds.width / 4 + 15
    }
    
    private var topButtonTitle: String {
        switch vm.currentGameState {
        case .readyToStartMatch:
            "New Match"
        case .matchInProgress:
            if vm.typeOfMatch == .social {
                "Stop Social Match"
            } else {
                "Abandon Match"
            }
        }
    }
    
    private var topButtonColor: Color {
        switch vm.currentGameState {
        case .readyToStartMatch:
                .green
        case .matchInProgress:
            if vm.typeOfMatch == .social {
                .orange
            } else {
                .red
            }
        }
    }
        
    private var bottomButtonTitle: String {
        switch vm.currentGameState {
        case .readyToStartMatch:
            "Return to Score Board"
        case .matchInProgress:
            "Resume Match"
        }
    }
    
    private var bottomButtonOpacity: Double {
        if vm.firstOpponentName.isEmpty {
            0
        } else if showAbandonMatchAlert || notImplementedYet {
            0.7
        } else {
            1
        }
    }
    
    private var matchUnderway: Bool {
        vm.ownerPoints > 0 || vm.opponentPoints > 0      ||
        vm .opponentPoints > 0 || vm.ownerGames > 0
    }
    
    private var showHistoryAndSettings: Bool {
        vm.currentGameState == .readyToStartMatch
    }
    
    var body: some View {
    
        @Bindable var vm = vm
        
        HStack {
            TriangleRow(colors: [.red.opacity(vm.opacityOfGameBoard), .green.opacity(vm.opacityOfGameBoard)])
                .frame(width: UIScreen.main.bounds.width / 6)
            
            Spacer()
            
            VStack {
                Text("Main Menu")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 2)
                
                Grid(horizontalSpacing: 25, verticalSpacing: 15) {
                    
                    GridRow {
                        MainMenuButton(  //  Start Match or Abandon Match
                            buttonTitle: topButtonTitle,
                            color: topButtonColor) {
                                switch vm.currentGameState {
                                case .matchInProgress:
                                    if vm.typeOfMatch == .social {
                                        withAnimation(.linear(duration: 1)) {
                                            vm.winnerIs = .socialMatchesStopped
                                        }
                                    } else {
                                        if matchUnderway {
                                            withAnimation(.linear(duration: 1)) {
                                                showAbandonMatchAlert.toggle()
                                            }
                                        } else {  // Match not started yet!
                                            withAnimation(.linear(duration: 1)) {
                                                vm.winnerIs = .matchCancelledBeforeStarting
                                            }
                                        }
                                    }
                                case .readyToStartMatch:
                                    if vm.firstOpponentName.isNotEmpty {
                                        vm.hideMatchViewAfterConfig = true
                                    }
                                    withAnimation(.linear(duration: 5)) {
                                        vm.screenToShow = .match(config: true)
                                    }
                                }
                            }
                    }
                    .opacity(showAbandonMatchAlert ? 0.25 : 1)
                    .gridCellColumns(2)
                                
                                
                                
                                
                                
//                    switch vm.currentGameState {
//                    case .socialGameActive:
//                        if matchUnderway {
//                            // TODO: Log the result
//                        }
//                        vm.winnerIs = .matchAbandoned
//                    case .matchFinished:
//                        //                                    
//                        vm.screenToShow = .match(config: true)
//                    case .matchInProgress:
//                        if matchUnderway {
//                            showAbandonMatchAlert.toggle()
//                        } else {        // Just abandon the match without warning
//                            vm.winnerIs = .matchAbandoned
//                        }
//                    }
//                }
//                .opacity(showAbandonMatchAlert ? 0.25 : 1)
//                .gridCellColumns(2)
                    
                    
                    GridRow {
                        MainMenuButton(buttonTitle: "Undo Last", color: .brown, isDisabled: vm.winnerIs != .noWinnerYet) {
                            withAnimation(.linear(duration: 1)) {
                                notImplementedYet.toggle()
                            }
                        }
                        MainMenuButton(buttonTitle: "History", color: .indigo, isDisabled: !showHistoryAndSettings) {
                            withAnimation(.linear(duration: 1)) {
//                                vm.screenToShow = .history
                                notImplementedYet.toggle()
                            }
                        }
                    }
                    
                    GridRow {
                        MainMenuButton(buttonTitle: "Rules", color: .gray) {
                            withAnimation(.linear(duration: 1)) {
                                notImplementedYet.toggle()
                            }
                        }
                        MainMenuButton(buttonTitle: "Layouts", color: .mint.opacity(0.5),isDisabled: !showHistoryAndSettings) {
                            withAnimation(.linear(duration: 1)) {
                                notImplementedYet.toggle()
                            }
                        }
                    }
                    
                    GridRow {
                        MainMenuButton(buttonTitle: "Settings", isDisabled: !showHistoryAndSettings) {
                            withAnimation(.linear(duration: 1)) {
                                notImplementedYet.toggle()
                            }
                        }
                        MainMenuButton(buttonTitle: "About", color: .gray) {
                            withAnimation(.linear(duration: 1)) {
                                vm.screenToShow = .about
                            }
                        }
                    }
                
                    GridRow {
                        MainMenuButton(buttonTitle: bottomButtonTitle, color: .blue) {
                            withAnimation(.linear(duration: 1)) {
                                vm.screenToShow = .match(config: false)
                            }
                        }
                        .gridCellColumns(2)
                        .opacity(bottomButtonOpacity)
//                        .opacity(vm.firstOpponentName.isNotEmpty ? 1 : 0)
                        .disabled(vm.firstOpponentName.isEmpty)
                    }
                }
                
                
                //            MainMenuButton(
                //                buttonTitle: topButtonTitle,
                //                color: topButtonColor) {
                //                    switch vm.currentGameState {
                //                    case .socialGameActive:
                //                        if matchUnderway {
                //                            // TODO: Log the result
                //                        }
                //                        vm.winnerIs = .matchAbandoned
                //                    case .matchInProgress:
                //                        if matchUnderway {
                //                            showAbandonMatchAlert.toggle()
                //                        } else {        // Just abandon the match without warning
                //                            vm.winnerIs = .matchAbandoned
                //                        }
                //                    }
                //                }
                //                .opacity(showAbandonMatchAlert ? 0.25 : 1)
                //            MainMenuButton(buttonTitle: "Adjust Scores", color: .brown, isDisabled: vm.winnerIs != .noWinnerYet) {
                //                notImplementedYet.toggle()
                //            }
                //            MainMenuButton(buttonTitle: "History", isDisabled:
                //                            !showHistoryAndSettings) {
                //                notImplementedYet.toggle()
                //            }
                //            MainMenuButton(buttonTitle: "Settings", isDisabled: !showHistoryAndSettings) {
                //                notImplementedYet.toggle()
                //            }
                //            .opacity(showAbandonMatchAlert ? 0.25 : 1)
                //            .padding(.bottom, 2)
                //
            }
            .frame(width: 350)
            .disabled(notImplementedYet || showAbandonMatchAlert)
            //        .opacity(notImplementedYet ? 0 : 1)
            .opacity(notImplementedYet || showAbandonMatchAlert ? 0.2 : 1)
            
            Spacer()
            
            TriangleRow(colors: [.red.opacity(vm.opacityOfGameBoard), .green.opacity(vm.opacityOfGameBoard)])
                .frame(width: UIScreen.main.bounds.width / 6)
                .rotationEffect(Angle(degrees: 180))
            
        }
        .edgesIgnoringSafeArea(.all)
        
        .onChange(of: vm.screenToShow) { oldValue, newValue in
            vm.showNewScreen = newValue != .none
        }
        
        .overlay(VerticalText(string: "BACKGAMMON", size: 16)
            .offset(x: -verticalTextOffset, y: 20))
        
        .overlay(VerticalText(string: "SCORE KEEPER", size: 13)
            .offset(x: verticalTextOffset, y: 20))
        
        .overlay(showAbandonMatchAlert ?
                 CustomBoxWith2Choices.init(
                    buttonLeft: "Yes",
                    buttonRight: "No",
                    actionLeft: {
                        vm.winnerIs = .matchAbandoned
                        withAnimation(.linear(duration: 1)) {
                            showAbandonMatchAlert = false
                        }
                    },
                    actionRight: {
                        withAnimation(.linear(duration: 1)) {
                            showAbandonMatchAlert = false
                        }
                    },
                    content: { AbandonMatchView() }
                 )
                 : nil )
        
        .overlay(notImplementedYet ?
                 CustomBoxWith1Button.init(
                    button: "OK",
                    action: {
                        withAnimation(.linear(duration: 1)) {
                            notImplementedYet = false
                        }
                    },
                    content: { NotYetImplementedView() }
                 )
                 : nil)
        
        .fullScreenCover(isPresented: $vm.showNewScreen) {
            switch vm.screenToShow {
            case .none:
                DebugView(text: "Nothing")
            case let .match(config):
                MatchView(showConfiguration: config)
            case .history:
                DebugView(text: "History")
            case .rules:
                DebugView(text: "Rules")
            case .layouts:
                DebugView(text: "Layouts")
            case .settings:
                DebugView(text: "Settings")
            case .about:
                AboutView()
            }
        }
    }
}

struct DebugView: View {
    @State var text: String
    var body: some View {
        Text(text)
    }
}

#Preview(traits: .landscapeLeft) {
    MainMenu()
        .environment(ViewModel())
}


