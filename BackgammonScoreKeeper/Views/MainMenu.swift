//
//  MainMenu.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 10/02/2025.
//

import SwiftUI

struct MainMenu: View {
    @Environment(ViewModel.self) var vm
    @State private var newMatchViewPresented = false
    @State private var showAbandonMatchAlert = false
    @State private var notImplementedYet = false
    //    @State private var animate = false
    
    private var topButtonTitle: String {
        switch vm.currentGameState {
        case .socialGameActive:
            "Stop Social Game"
        case .matchInProgress:
            "Abandon Match"
        case .matchFinished, .matchAbandoned:
            "New Match"
        }
    }
    
    private var topButtonColor: Color {
        switch vm.currentGameState {
        case .socialGameActive:
                .orange
        case .matchInProgress:
                .red
        case .matchFinished, .matchAbandoned:
                .green
        }
    }
    
    private var matchUnderway: Bool {
        vm.ownerPoints > 0 || vm.opponentPoints > 0      ||
        vm .opponentPoints > 0 || vm.ownerGames > 0
    }
    
    private var showHistoryAndSettings: Bool {
        vm.currentGameState == .matchFinished || vm.currentGameState == .matchAbandoned
    }
    
    var body: some View {
        VStack {
            Text("Main Menu")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 2)
            
            Grid(horizontalSpacing: 25, verticalSpacing: 15) {
                GridRow {
                    MainMenuButton(
                        buttonTitle: topButtonTitle,
                        color: topButtonColor) {
                            switch vm.currentGameState {
                            case .socialGameActive:
                                if matchUnderway {
                                    // TODO: Log the result
                                }
                                vm.winnerIs = .matchAbandoned
                            case .matchFinished, .matchAbandoned:
                                newMatchViewPresented.toggle()
                            case .matchInProgress:
                                if matchUnderway {
                                    showAbandonMatchAlert.toggle()
                                } else {        // Just abandon the match without warning
                                    vm.winnerIs = .matchAbandoned
                                }
                            }
                        }
                        .opacity(showAbandonMatchAlert ? 0.25 : 1)
                        .gridCellColumns(2)
                }
                
                GridRow {
                    MainMenuButton(buttonTitle: "Undo Last", color: .brown, isDisabled: vm.winnerIs != .noWinnerYet) {
                        notImplementedYet.toggle()
                    }
                    MainMenuButton(buttonTitle: "History", color: .indigo, isDisabled:
                                    !showHistoryAndSettings) {
                        notImplementedYet.toggle()
                    }
                }
                
                GridRow {
                    MainMenuButton(buttonTitle: "Rules", color: .gray) {
                        notImplementedYet.toggle()
                    }
                    MainMenuButton(buttonTitle: "Layouts", color: .mint.opacity(0.5),isDisabled: !showHistoryAndSettings) {
                        notImplementedYet.toggle()
                    }
                }
                
                GridRow {
                    MainMenuButton(buttonTitle: "Settings", isDisabled: !showHistoryAndSettings) {
                        notImplementedYet.toggle()
                    }
                    MainMenuButton(buttonTitle: "About", color: .gray) {
                        notImplementedYet.toggle()
                    }
                }
                
                GridRow {
                    MainMenuButton(buttonTitle: "Return", color: .blue) {
                        vm.mainMenuShowing = false
                    }
                    //                    .opacity(showAbandonMatchAlert ? 0.25 : 1)
                    .gridCellColumns(2)
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
            //                    case .matchFinished, .matchAbandoned:
            //                        newMatchViewPresented.toggle()
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
            //            MainMenuButton(buttonTitle: "Return", color: .blue) {
            //                vm.mainMenuShowing = false
            //            }
            //            .opacity(showAbandonMatchAlert ? 0.25 : 1)
            //            .padding(.bottom, 2)
            //
        }
        .disabled(notImplementedYet || showAbandonMatchAlert)
        //        .opacity(notImplementedYet ? 0 : 1)
        
        .overlay(
            showAbandonMatchAlert ? CustomAlert.init(
                isShown: $showAbandonMatchAlert,
                message: "Are you sure you want to abandon this match?",
                button1Text: "Yes",
                button2Text: "No",
                alertWidth: 200,
                alertHeight: 150,
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
                alertWidth: 200,
                alertHeight: 150,
                action1: {},
                action2: {}
            ) : nil
        )
        
        //        .padding(16)
        .frame(width: 400)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        //        .background(.gray.opacity(0.9))
        .fullScreenCover(isPresented: $newMatchViewPresented,
                         content: NewMatchView.init)
    }
    
}

#Preview(traits: .landscapeLeft) {
    MainMenu()
        .environment(ViewModel())
}


//struct PrimaryButtonStyle: ButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
//            .bold()
//            .foregroundStyle(.white)
//            .background(Color.accentColor)
//            .clipShape(Capsule(style: .continuous))
//            .scaleEffect(configuration.isPressed ? 0.9 : 1)
//            .animation(.smooth, value: configuration.isPressed)
//    }
//}
//
//extension ButtonStyle where Self == PrimaryButtonStyle {
//    static var myAppPrimaryButton: PrimaryButtonStyle { .init() }
//}

struct TestView: View {
    @State private var opacity: Double = 0.0
    
    var body: some View {
        VStack {
            MainMenuButton(buttonTitle: "Adjust Scores", isDisabled: true) {}
                .opacity(opacity)
            
            
            
            Text("Hello, SwiftUI!")
                .opacity(opacity)
                .font(.largeTitle)
                .padding()
            
            
            Button(opacity == 0.0 ? "Fade In" : "Fade Out") {
                withAnimation(.easeInOut(duration: 2)) {
                    opacity = opacity == 0.0 ? 1.0 : 0.0
                }
            }
        }
    }
}
