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
    
    var lhsBox: Int {
        if offerMadeTo == .owner {
            vm.positionOfOwner == .leftHandSide ? vm.cubeValue * 2 : vm.cubeValue
        } else {   // offer made to opponent}
            vm.positionOfOwner == .leftHandSide ? vm.cubeValue : vm.cubeValue * 2
        }
    }
    
    var rhsBox: Int {
        if offerMadeTo == .owner {
            vm.positionOfOwner == .rightHandSide ? vm.cubeValue * 2 : vm.cubeValue
        } else {   // offer made to opponent}
            vm.positionOfOwner == .rightHandSide ? vm.cubeValue : vm.cubeValue * 2
        }
    }
    
    var angleOfArrow: Double {
        rhsBox > lhsBox ? 0 : 180
    }
    
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
                    .frame(height: 20)
                Group {
                    HStack {
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(.clear)
                            .strokeBorder(Color.yellow, lineWidth: 2)
                            .frame(width: 50, height: 50)
                            .overlay(
                                Text("\(lhsBox)")
                                .font(.title)
                                .foregroundStyle(.yellow)
                            )
                            .opacity(lhsBox == 1 ? 0 : 1)
                        Spacer()
                            .frame(width: 150)
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(.clear)
                            .strokeBorder(Color.yellow, lineWidth: 2)
                            .frame(width: 50, height: 50)
                            .overlay(
                                Text("\(rhsBox)")
                                .font(.title)
                                .foregroundStyle(.yellow)
                            )
                            .opacity(rhsBox == 1 ? 0 : 1)
                    }
                    .overlay(AnimatedArrow()
                        .rotationEffect(.degrees(angleOfArrow)))
                    .frame(alignment: .leading)
                }
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
