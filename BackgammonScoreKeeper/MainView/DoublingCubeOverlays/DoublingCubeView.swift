//
//  DoublingCubeView.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 24/02/2025.
//

import SwiftUI

struct DoublingCubeView: View {
    @Environment(ViewModel.self) var vm
      
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(.yellow.opacity(0.5))
                .frame(width: vm.doublingCubeTotalWidth, height: 50)
                .overlay(Circle())

            Spacer()
        }
    }    
}

#Preview(traits: .landscapeLeft) {
    DoublingCubeView()
        .environment(ViewModel())
}

