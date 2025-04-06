//
//  ShowDoublingOffer.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 06/04/2025.
//

import SwiftUI

struct ShowDoublingOffer: View {
    @Environment(ViewModel.self) var vm
    
    var offerMadeTo: OfferCubeTo
    
    var body: some View {
        Group {
            VStack {
                Spacer()
                    .frame(height: 5)
                Text(offerMadeTo == .owner ? vm.ownerDisplayName : vm.opponentDisplayName)
                    .font(.title)
                Spacer()
                    .frame(height: 10)
                Text("Do you wish to accept the offer\nof the Doubling Cube made by")
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: 10)
                Text(offerMadeTo == .owner ? vm.opponentDisplayName : vm.ownerDisplayName)
                    .font(.title)
                Spacer()
                    .frame(height: 15)
                Text("If you do accept it, the new value\nof the Doubling Cube change to")
                    .multilineTextAlignment(.center)
                    .font(.caption)
                    .foregroundStyle(.yellow)
                Spacer()
                    .frame(height: 8)
                Text("\(vm.cubeValue * 2)")
                    .font(.title)
                    .foregroundStyle(.yellow)
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
    ShowDoublingOffer(offerMadeTo: .owner)
        .environment(ViewModel())
}
