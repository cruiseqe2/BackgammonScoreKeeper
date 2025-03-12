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
    
    private var currentGameState: CurrentGameState {
        if vm.winnerIs == .matchAbandoned {
            return .matchAbandoned
        }
        if vm.winnerIs == .noWinnerYet {
            if vm.typeOfMatch == .social {
                return .socialGameActive
            } else {
                return .matchInProgress
            }
        } else {
            return .matchFinished
        }
    }
    
    private var topButtonTitle: String {
        switch currentGameState {
        case .socialGameActive:
            "Stop Social Game"
        case .matchInProgress:
            "Abandon Match"
        case .matchFinished, .matchAbandoned:
            "New Match"
        }
    }
    
    private var topButtonColor: Color {
        switch currentGameState {
        case .socialGameActive:
                .orange
        case .matchInProgress:
                .red
        case .matchFinished, .matchAbandoned:
                .green
        }
    }
        
    var body: some View {
        VStack {
            Spacer()
            Text("Main Menu")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            Spacer()
            MainMenuButton(
                buttonTitle: topButtonTitle,
                color: topButtonColor) {
                    switch currentGameState {
                    case .socialGameActive:
                        // TODO Log this 'result'
                        vm.winnerIs = .matchAbandoned
                    case .matchFinished, .matchAbandoned:
                        newMatchViewPresented.toggle()
                    case .matchInProgress:
                        showAbandonMatchAlert.toggle()
                    }
                }
                .opacity(showAbandonMatchAlert ? 0.25 : 1)
            MainMenuButton(buttonTitle: "Adjust Scores", isDisabled: vm.winnerIs != .noWinnerYet) {}
            MainMenuButton(buttonTitle: "History", isDisabled:
                            currentGameState != .matchFinished) {}
            MainMenuButton(buttonTitle: "Settings", isDisabled: currentGameState != .matchFinished) {}
            MainMenuButton(buttonTitle: "Return", color: .blue) {
                vm.mainMenuShowing = false
            }
            .opacity(showAbandonMatchAlert ? 0.25 : 1)
            
            Spacer()
        }
        
        .alert("Are you sure you want to abandon this match?", isPresented: $showAbandonMatchAlert) {
            Button("Yes - Abondon", role: .destructive) {
                vm.winnerIs = .matchAbandoned
            }
            Button("No - Just return", role: .cancel) {}
        }
        
        .padding(16)
        .frame(width: 250, height: 400)
        .background(.ultraThinMaterial)
        .fixedSize(horizontal: false, vertical: true)
        .cornerRadius(25)
        .fullScreenCover(isPresented: $newMatchViewPresented,
                         content: NewMatchView.init )
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
