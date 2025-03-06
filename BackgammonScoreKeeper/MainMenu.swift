//
//  MainMenu.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 10/02/2025.
//

import SwiftUI

struct MainMenu: View {
//    @Environment(\.dismiss) private var dismiss
    @Binding var showMenu: Bool
        
    var body: some View {
        VStack {
//            Text("Main Menu")
//                .font(.largeTitle)
            
            Button("New Match") { }
                .frame(width: 600)
            
            Button("Adjust Scores") { }
                .frame(width: 600)
            
            Button("History") { }
                .frame(width: 600)
            
            Button("Settings") { }
                .buttonStyle(.myAppPrimaryButton)
//                .frame(width: 600)
            
            Button {
                
            } label: {
                Text("History")
                    .frame(width: 500)
            }

    
            Button("Cancel") {
                showMenu = false
                //                dismiss()
            }
            .buttonStyle(.borderedProminent)
            
        }
        .buttonStyle(.bordered)
        .font(.title)
        .tint(.mint)
        
        .frame(width: 200, height: 360)
        .background(.ultraThickMaterial)
    }
}

#Preview(traits: .landscapeLeft) {
    MainView()
        .environment(ViewModel())
}


struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
            .bold()
            .foregroundStyle(.white)
            .background(Color.accentColor)
            .clipShape(Capsule(style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.smooth, value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var myAppPrimaryButton: PrimaryButtonStyle { .init() }
}
