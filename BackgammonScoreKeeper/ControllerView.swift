//
//  ControllerView.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 04/02/2025.
//

import SwiftUI

struct ControllerView: View {
    @Environment(ViewModel.self) var vm
    @State var showErrorScreen = false
    
    var wrongOrientation: Bool {
        vm.deviceOrientation != .landscapeLeft && vm.deviceOrientation != .landscapeRight && vm.deviceOrientation != .faceUp
    }
    
    var body: some View {
        
        ZStack {
            WelcomeView()
                .opacity(vm.appStages == .welcomeScreen ? 1 : 0)
                .transition(.move(edge: .trailing))
            MainMenu()
                .opacity(vm.appStages == .mainGamePlay ? 1 : 0)
                .transition(.move(edge: .trailing))
        }
        .animation(.linear(duration: 1.5), value: vm.appStages)
        
        
        
        
//        Group {
//            switch vm.appStages {
//            case .welcomeScreen:
//                WelcomeView()
//                    .transition(AnyTransition.scale.animation(.easeInOut(duration: 3.5)))
//                //                    .transition(.move(edge: .trailing))
//            case .setupOwnerName:
//                EmptyView()
//            case .mainGamePlay:
//                MainView()
//                //                    .withAnimation(.easeInOut(duration: 0.5)) {
//                    .transition(AnyTransition.scale.animation(.easeInOut(duration: 3.5)))
//                //                    }
//                //                    .animation(.easeInOut(duration: 0.5))
//                //            }
//                //                .withAnimation(.easeInOut(duration: 0.5)) {
//                //                    .transition(.move(edge: .trailing))
//            }
//        }
//        .animation(.linear(duration: 6), value: vm.appStages)
//            
            
            
            
//            switch vm.welcomeShown {
//            case false:
//                WelcomeView()
//                    .transition(.opacity)
//            case true:
//                MainView()
//                    .transition(.opacity)
//            }
//        }
        
        
//        VStack {
//            Rectangle()
//                .frame(width: 100, height: 100)
//                .transition(.
//        }
        
        .background(Color.theme.background)
        .fullScreenCover(isPresented: $showErrorScreen) {
            Text("Please rotate the phone to Landscape")
        }
        //        .preferredColorScheme(.dark)
        .onAppear {
            vm.deviceOrientation = getDeviceOrientation()
            showErrorScreen = (wrongOrientation ? true : false)
        }
        .onRotate { newOrientation in
            vm.deviceOrientation = newOrientation
            showErrorScreen = (wrongOrientation ? true : false)
        }
    }
}


