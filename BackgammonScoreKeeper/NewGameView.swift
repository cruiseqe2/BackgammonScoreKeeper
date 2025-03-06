//
//  NewGameView 2.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 06/03/2025.
//

import SwiftUI

struct NewGameView: View {
    @Environment(ViewModel.self) var vm
    @Environment(\.dismiss) var dismiss
    @State private var menuBeingShown: Bool = false
    @State private var isConfigurePlayersShown: Bool = false
    
    var namesAreValid: Bool {
        vm.opponentName.isNotEmpty ? true : false
    }
    
    
    
    
    
    var body: some View {
//        GeometryReader { geometry in
            
            
            VStack(spacing: 0) {
                
                HStack(alignment: .firstTextBaseline) {
                    Text("BACKGAMMON")
                        .foregroundStyle(Color.theme.foreground)
                        .font(.system(size: 36, weight: .black))
                        .kerning(8)
                    Text("Score Keeper")
                        .foregroundStyle(Color.theme.foreground)
                        .font(.system(size: 24, weight: .black))
                        .kerning(5)
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 30))
                    }
                    .disabled(menuBeingShown)
                }
                .padding(.top, 2)
                .padding(.bottom, 5)
                
                HStack {
                    Text("Players currently - \(vm.ownerDisplayName) vs. \(vm.opponentDisplayName)")
                    Spacer()
                    Button {
                        isConfigurePlayersShown.toggle()
                    } label: {
                        Text("Configure")
                    }
                    .buttonStyle(.borderedProminent)
                    .popover(isPresented: $isConfigurePlayersShown) {
                        ConfigureNamesView()
                            .padding(30)
                            .presentationCompactAdaptation(.popover)
                            .interactiveDismissDisabled()
                    }
                }
                
                
                
                
                
                
                //                HStack(spacing: 0) {
                //                    OuterView(sideToProcess: .leftHandSide)
                //                        .frame(width: outerColumnWidth)
                //
                //                    MiddleView()
                //                        .frame(width: middleColumnWidth)
                //                        .addWidthOfObject { columnWidth in
                //                            vm.totalWidth += columnWidth
                //                            vm.middleColumnWidth = columnWidth
                //                        }
                //
                //                    OuterView(sideToProcess: .rightHandSide)
                //                        .frame(width: outerColumnWidth)
                //                }
                
                //            .offset(x: whichWayRound == .isLandscapeLeft ? 20 : -20)
            }
        
//            .onChange(of: namesAreValid) { _, valid in
//                if valid {
//                    isConfigurePlayersShown = true
//                }
//            }
        
        
        
        
        }
        //        .padding()
        //        .opacity(menuBeingShown ? 0.2 : 1.0)
        //        .disabled(menuBeingShown)
        //        .overlay(mainMenu)
        
        //        .background(Color.theme.background)
        //        .ignoresSafeArea(.all)
//    }
    
    
}

#Preview(traits: .landscapeLeft) {
    NewGameView()
        .environment(ViewModel())
}
