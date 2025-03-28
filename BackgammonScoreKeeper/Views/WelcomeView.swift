//
//  WelcomeView.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 14/03/2025.
//


import SwiftUI


struct WelcomeView: View {
    @Environment(ViewModel.self) var vm
    
    var body: some View {
        VStack {
            Spacer()
            Text("Welcome to this App - The Ultimate Backgammon Score Keeper")
            Text("Designed and developed by Mark Oelbaum")
            Spacer()
            Text("I sincerely hope you enjoy this App")
            Spacer()
            Button("Done") {
                vm.welcomeShown = true
                withAnimation(.linear(duration: 4.75)) {
                    vm.appStages = .mainGamePlay
                }
            }
            Spacer()
        }
    }
    
}

#Preview(traits: .landscapeLeft) {
    WelcomeView()
        .environment(ViewModel())
}
