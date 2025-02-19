//
//  MainView.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 18/02/2025.
//

import SwiftUI

struct MainView: View {
    @Environment(ViewModel.self) var vm
    @State private var menuBeingShown: Bool = false
    
    var whichWayRound: WhichWayRound {
        switch vm.deviceOrientation {
        case .landscapeLeft:
                .isLandscapeLeft
        case .landscapeRight:
                .isLandscapeRight
        @unknown default:
                .isInvalid
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            let outerColumnWidth = geometry.size.width * 0.40
            let middleColumnWidth = geometry.size.width * 0.20
            
            VStack(spacing: 0) {
                
                    HStack(alignment: .firstTextBaseline) {
                        Text("BACKGAMMON")
                            .font(.system(size: 36, weight: .black))
                            .kerning(8)
                        Text("Score Keeper")
                            .font(.system(size: 24, weight: .black))
                            .kerning(5)
                        
                        Spacer()
                        
                        Button {
                            menuBeingShown.toggle()
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .font(.system(size: 30))
                        }
                        .disabled(menuBeingShown)
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 10)
                
                HStack(spacing: 0) {
                    Color.red.opacity(0.5)
                        .frame(width: outerColumnWidth)
                        .overlay(Outer(sideToProcess: .leftHandSide))
                    
                    Color.green
                        .frame(width: middleColumnWidth)
                        .overlay(MIDDLE())
                    
                    Color.blue
                        .frame(width: outerColumnWidth)
                        .overlay(Outer(sideToProcess: .rightHandSide))
                }
                //            .offset(x: whichWayRound == .isLandscapeLeft ? 20 : -20)
            }
        }
    }
}

#Preview(traits: .landscapeLeft) {
    MainView()
        .environment(ViewModel())
}
