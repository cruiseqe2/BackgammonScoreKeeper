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
        
        MainView()
            .background(Color.theme.background)
            .fullScreenCover(isPresented: $showErrorScreen) {
            Text("Please rotate the phone to Landscape")
        }
//        .preferredColorScheme(.dark)
        .onAppear {
            vm.deviceOrientation = getDeviceOrientation()
            showErrorScreen = (wrongOrientation ? true : false)
//            print("On Appear", deviceOrientation.rawValue)
        }
        .onRotate { newOrientation in
            vm.deviceOrientation = newOrientation
            showErrorScreen = (wrongOrientation ? true : false)
//            print("On Rotate", deviceOrientation.rawValue)
        }
    }
}


