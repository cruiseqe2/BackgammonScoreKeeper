//
//  CrawfordGameView.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 08/03/2025.
//


//
//  DoublingCubeView.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 24/02/2025.
//

import SwiftUI

struct CrawfordGameView: View {
    @Environment(ViewModel.self) var vm
    
    var body: some View {
        VStack {
            VStack {
                Text("CRAWFORD GAME")
                    .font(.title2)
                    .kerning(1.5)
                    .offset(y: +2)
                Text("Doubling in this game is not allowed")
                    .font(.caption)
                    .offset(y: -2)
            }
            .frame(width: vm.doublingCubeTotalWidth, height: 50)
            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(.red, lineWidth: 4)
            )
            
            Spacer()
        }
    }
}

#Preview(traits: .landscapeLeft) {
    CrawfordGameView()
        .environment(ViewModel())
}

