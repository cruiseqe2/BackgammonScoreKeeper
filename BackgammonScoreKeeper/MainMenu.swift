//
//  MainMenu.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 10/02/2025.
//

import SwiftUI

struct MainMenu: View {
    @Environment(ViewModel.self) var vm
//    @Environment(\.dismiss) private var dismiss
    @Binding var showMenu: Bool
    @State private var isNewGameViewPresented = false
        
    var body: some View {
        VStack {
            Spacer()
            Text("Main Menu")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            Spacer()
            MainMenuButton(
                buttonTitle: vm.winnerIs == .noWinnerYet ? "Abandon Match" : "New Match",
                color: vm.winnerIs == .noWinnerYet ? .red : .green) {
                    if vm.winnerIs == .noWinnerYet {
                        isNewGameViewPresented.toggle()
                    } else {
                        isNewGameViewPresented.toggle()
                    }
            }
            MainMenuButton(buttonTitle: "Adjust Scores") {}
            MainMenuButton(buttonTitle: "History") {}
            MainMenuButton(buttonTitle: "Settings") {}
            MainMenuButton(buttonTitle: "Cancel", color: .blue) {
                showMenu = false
            }
            Spacer()
        }
        .padding(16)
        .frame(width: 250, height: 400)
        .background(.ultraThinMaterial)
        .fixedSize(horizontal: false, vertical: true)
        .cornerRadius(25)
        .fullScreenCover(isPresented: $isNewGameViewPresented, content: NewGameView.init)
        
    }
}

#Preview(traits: .landscapeLeft) {
    MainMenu(showMenu: .constant(true))
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
