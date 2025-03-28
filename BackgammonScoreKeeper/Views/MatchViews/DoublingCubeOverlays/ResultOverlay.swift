//
//  ResultOverlay.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 28/03/2025.
//


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

struct ResultOverlay: View {
    @Environment(ViewModel.self) var vm
    
    var statusText: String {
        switch vm.winnerIs {
        case .matchAbandoned: "Match Abandoned"
        case .matchCancelledBeforeStarting: "Match Cancelled"
        case .owner: vm.ownerDisplayName + " won!"
        case .opponent: vm.opponentDisplayName + " won!"
        default: ""
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                Text(statusText)
                    .font(.title2)
                    .kerning(1.5)
                    .offset(y: +2)
                    .foregroundStyle(.black)
                    .font(.system(size: 15, weight: .bold, design: .default))
            }
            .frame(width: vm.doublingCubeTotalWidth, height: 50)
            .background(RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.white)
                .stroke(.orange, lineWidth: 6)
            )
            
            Spacer()
        }
    }
}

#Preview(traits: .landscapeLeft) {
    ResultOverlay()
        .environment(ViewModel())
}

