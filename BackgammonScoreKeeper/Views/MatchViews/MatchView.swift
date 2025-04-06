//
//  MainView.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 18/02/2025.
//

import SwiftUI

struct MatchView: View {
    @Environment(ViewModel.self) var vm
    @Environment(\.dismiss) var dismiss
    @State var showConfiguration: Bool

    
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
    
    var mainBodyOpacity: Double {
        if showConfiguration || vm.hideMatchViewAfterConfig {
            0.0
        } else if vm.showDoublingCheck || vm.showDoublingOffer {
            0.3
        } else {
            1.0
        }
    }

    var body: some View {
        
        @Bindable var vm = vm
        
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
                        
                        Button {
                            vm.screenToShow = .none
                            dismiss()
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .font(.system(size: 30))
                        }
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
        
        .opacity(mainBodyOpacity)
        .disabled(mainBodyOpacity != 1)
        
        .fullScreenCover(isPresented: $showConfiguration) {
            ConfigureMatchView()
        }
        
        .overlay(vm.winnerIs != .noWinnerYet ? ShowResultOverylay() : nil)
        .opacity(showConfiguration || vm.hideMatchViewAfterConfig ? 0 : 1.0)
        
        .overlay(vm.useDoublingCube && vm.winnerIs == .noWinnerYet  && !vm.hideMatchViewAfterConfig ? DealWithTheDoublingCubeView() : nil)

        .overlay(vm.showDoublingCheck ?
            Custom2ChoiceView.init(
                buttonLeft: "Yes",
                buttonRight: "No",
                actionLeft: {
                    withAnimation(.linear(duration: 0.4)) {
                        vm.showDoublingCheck = false
                        vm.showDoublingOffer = true
                    }
                },
                actionRight: {
                    withAnimation(.linear(duration: 0.4)) {
                        vm.showDoublingCheck = false
                        vm.showDoublingOffer = false
                    }
                    vm.cubeOpacity = 1
                },
                content: {
                    ConfirmWishToMakeOffer(offerMadeTo: vm.cubeOfferedTo)
                }
            )
            : nil )
        
        .overlay(
            vm.showDoublingOffer ? CustomAlert.init(
                isShown: $vm.showDoublingOffer,
                message: vm.offerMessage,
                button1Text: "Accept",
                button2Text: "Decline",
                alertWidth: 300,
                alertHeight: 200,
                action1: {
                    withAnimation(.linear(duration: 0.5)) {
                        vm.doublingOfferAccpted(true)
                    }
                },
                action2: {
                    withAnimation(.linear(duration: 0.5)) {
                        vm.doublingOfferAccpted(false)
                    }
                }
            ) : nil
        )
        
    }
}

struct ShowResultOverylay: View {
    @Environment(ViewModel.self) var vm
    var body: some View {
        ResultOverlay()
            .offset(y: vm.doublingCubeYPosition)
    }
}

struct DealWithTheDoublingCubeView: View {
    @Environment(ViewModel.self) var vm
    var body: some View {
        VStack {
            switch vm.crawfordStatus {
            case .notPointsBased:
                EmptyView()
            case .preCrawford, .postCrawford:
                DoublingCubeView()
                    .offset(x: vm.doublingCubeOffset, y:  vm.doublingCubeYPosition)
            case .isCrawford:
                CrawfordGameView()
                    .offset(y: vm.doublingCubeYPosition)
            }
        }
    }
}

#Preview(traits: .landscapeLeft) {
    MatchView(showConfiguration: false)
        .environment(ViewModel())
}
