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
                                        vm.winnerIs = .socialMatchesStopped
                                    } else {
                                        if matchUnderway {
                                            withAnimation {
                                                showAbandonMatchAlert.toggle()
                                            }
                                        } else {  // Match not started yet!
                                            vm.winnerIs = .matchCancelledBeforeStarting
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
                        .opacity(vm.firstOpponentName.isNotEmpty ? 1 : 0)
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
            .opacity(notImplementedYet ? 0.2 : 1)
            
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
        
        .overlay(
            showAbandonMatchAlert ? CustomAlert.init(
                isShown: $showAbandonMatchAlert,
                message: "Are you sure you want to abandon this match?",
                button1Text: "Yes",
                button2Text: "No",
                alertWidth: 300,
                alertHeight: 200,
                action1: {
                    vm.winnerIs = .matchAbandoned
                },
                action2: {}
            ) : nil
        )
        
        .overlay(
            notImplementedYet ? CustomAlert.init(
                isShown: $notImplementedYet,
                message: "Sorry. This feature has not been implemented yet.",
                button1Text: "OK",
                button2Text: "",
                alertWidth: 300,
                alertHeight: 200,
                action1: {},
                action2: {}
            ) : nil
        )
        
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

#Preview(traits: .landscapeLeft) {
    MainMenu()
        .environment(ViewModel())
}

struct DebugView: View {
    @State var text: String
    var body: some View {
        Text(text)
    }
}




//struct TestView: View {
//    @State private var opacity: Double = 0.0
//    
//    var body: some View {
//        VStack {
//            MainMenuButton(buttonTitle: "Adjust Scores", isDisabled: true) {}
//                .opacity(opacity)
//            
//            
//            
//            Text("Hello, SwiftUI!")
//                .opacity(opacity)
//                .font(.largeTitle)
//                .padding()
//            
//            
//            Button(opacity == 0.0 ? "Fade In" : "Fade Out") {
//                withAnimation(.easeInOut(duration: 2)) {
//                    opacity = opacity == 0.0 ? 1.0 : 0.0
//                }
//            }
//        }
//    }
//}
