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
            
//            let _ = print("middleColumnWidth: \(middleColumnWidth)")
            
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
                            menuBeingShown.toggle()
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .font(.system(size: 30))
                        }
                        .disabled(menuBeingShown)
                    }
                    .padding(.top, 2)
                    .padding(.bottom, 0)
                
                HStack(spacing: 0) {
                    Color.red.opacity(0.5)
                        .frame(width: outerColumnWidth)
                        .overlay(OuterView(sideToProcess: .leftHandSide))
                    
                    Color.green
                        .frame(width: middleColumnWidth)
                        .overlay(MiddleView())
                        .addWidthOfObject { columnWidth in
                            vm.totalWidth += columnWidth
                            vm.middleColumnWidth = columnWidth
                        }
                    
                    Color.blue
                        .frame(width: outerColumnWidth)
                        .overlay(OuterView(sideToProcess: .rightHandSide))

                }
                //            .offset(x: whichWayRound == .isLandscapeLeft ? 20 : -20)
            }
        }
        .padding()
        .opacity(menuBeingShown ? 0.2 : 1.0)
        .disabled(menuBeingShown)
        .overlay(mainMenu)
        .overlay(showCube)
//        .background(Color.theme.background)
//        .ignoresSafeArea(.all)
    }
        
        
    
    @ViewBuilder private var mainMenu: some View {
        if menuBeingShown {
            MainMenu(showMenu: $menuBeingShown)
        }
    }
    
    @ViewBuilder private var showCube: some View {
        if vm.showDoublingCube {
            DoublingCubeView()
                .offset(y: vm.doublingCubeYPosition)
//                .offset(y: 127)

        }
    }
    
    
}

#Preview(traits: .landscapeLeft) {
    MainView()
        .environment(ViewModel())
}
