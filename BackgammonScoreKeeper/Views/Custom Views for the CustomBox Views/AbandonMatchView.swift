//
//  ConfirmWishToMakeOffer 2.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 06/04/2025.
//


//
//  ConfirmWishToMakeOffer.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 06/04/2025.
//

import SwiftUI

struct AbandonMatchView: View {
    @Environment(ViewModel.self) var vm
    
    
    var body: some View {
        Group {
            VStack {
                Spacer()
                    .frame(height: 5)
                Text("Are you sure you wish to abandon this match?")
                    .font(.title3)
                    .frame(width: 250)
                    .multilineTextAlignment(.center)
                
                Spacer()
                    .frame(height: 5)
            }
        }
        .padding()
        .fixedSize(horizontal: true, vertical: false)
        .foregroundStyle(.white)

    }
}

#Preview(traits: .landscapeLeft) {
    AbandonMatchView()
        .environment(ViewModel())
}
