//
//  ConfirmWishToMakeOffer.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 06/04/2025.
//

import SwiftUI

struct ConfirmWishToMakeOffer: View {
    @Environment(ViewModel.self) var vm
    
    var offerMadeTo: OfferCubeTo
    
    var body: some View {
        Group {
            VStack {
                Spacer()
                    .frame(height: 5)
                Text(offerMadeTo == .opponent ? vm.ownerDisplayName : vm.opponentDisplayName)
                    .font(.title)
                Spacer()
                    .frame(height: 10)
                Text("Are you sure you wish to offer \nthe doubling cube to")
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: 10)
                Text(offerMadeTo == .opponent ? vm.opponentDisplayName : vm.ownerDisplayName)
                    .font(.title)
                Spacer()
                    .frame(height: 15)
                VStack(alignment: .leading) {
                    Text("""
                        This question only appears because this is \
                        being run on a phone, and once you press 'Yes', \
                        there is no way to cancel the next \
                        formal Offer Screen.              
                        """)
                    .frame(width: 250)
                    .multilineTextAlignment(.leading)
                }
                .foregroundStyle(.yellow)
                .font(.caption)
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
    ConfirmWishToMakeOffer(offerMadeTo: .owner)
        .environment(ViewModel())
}
