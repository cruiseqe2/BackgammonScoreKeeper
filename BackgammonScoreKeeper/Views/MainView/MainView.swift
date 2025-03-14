//
//  MainView.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 18/02/2025.
//

import SwiftUI

struct MainView: View {
    @Environment(ViewModel.self) var vm
//    @State private var menuBeingShown: Bool = false
    
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
                            .foregroundStyle(Color.theme.foreground)
                            .font(.system(size: 36, weight: .black))
                            .kerning(8)
                        Text("Score Keeper")
                            .foregroundStyle(Color.theme.foreground)
                            .font(.system(size: 24, weight: .black))
                            .kerning(5)
                        
                        Spacer()
                        
//                        /// This should be removed when finished
//                        Button {
//                            vm.showTestingButtons.toggle()
//                        } label: {
//                            Text(vm.showTestingButtons ? "Hide" : "Show")
//                        }
//                        Spacer()
//                        /// End of stuff to be removed before use
                        
                        Button {
                            vm.mainMenuShowing.toggle()
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .font(.system(size: 30))
                        }
                        .disabled(vm.mainMenuShowing)
                    }
                    .padding(.top, 2)
                    .padding(.bottom, 5)
                
                Spacer()
                
                HStack(spacing: 0) {
                    OuterView(sideToProcess: .leftHandSide)
                        .frame(width: outerColumnWidth)
                    
                    MiddleView()
                        .frame(width: middleColumnWidth)
                        .addWidthOfObject { columnWidth in
                            vm.totalWidth += columnWidth
                            vm.middleColumnWidth = columnWidth
                        }
                    
                    OuterView(sideToProcess: .rightHandSide)
                        .frame(width: outerColumnWidth)
                }
                
                //            .offset(x: whichWayRound == .isLandscapeLeft ? 20 : -20)
            }
        }
//        .padding()
        .opacity(vm.mainMenuShowing ? 0.2 : 1.0)
        .disabled(vm.mainMenuShowing)
        .overlay(vm.mainMenuShowing ? MainMenu() : nil)
//        .overlay(vm.mainMenuShowing ? DealWithTheMainMenuView() : nil)
        .overlay(vm.useDoublingCube && !vm.mainMenuShowing ? DealWithTheDoublingCubeView() : nil)
//        .opacity(menuBeingShown ? 0 : 1)
//        .disabled(menuBeingShown)

//        .background(Color.theme.background)
//        .ignoresSafeArea(.all)
    }
        
//    @ViewBuilder private var mainMenu: some View {
//        if menuBeingShown {
////            MainMenu(showMenu: $menuBeingShown)
//            MainMenu(showMenu: $vm.mainMenuShowing)
//        }
//    }
    
}

//struct DealWithTheMainMenuView: View {
//    @Environment(ViewModel.self) var vm
//    var body: some View {
//        MainMenu()
//    }
//}

struct DealWithTheDoublingCubeView: View {
    @Environment(ViewModel.self) var vm
    var body: some View {
        VStack {
            switch vm.crawfordStatus {
            case .notPointsBased:
                EmptyView()
            case .preCrawford, .postCrawford:
                DoublingCubeView()
                    .offset(y: vm.doublingCubeYPosition)
            case .isCrawford:
                CrawfordGameView()
                    .offset(y: vm.doublingCubeYPosition)
            }
        }
    }
}


#Preview(traits: .landscapeLeft) {
    MainView()
        .environment(ViewModel())
}
