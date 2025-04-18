//
//  AbandonMatchView 2.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 06/04/2025.
//


//
//  NotYetImplementedView.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 06/04/2025.
//

import SwiftUI

struct NotYetImplementedView: View {
    @Environment(ViewModel.self) var vm
    
    var body: some View {
        Group {
            VStack {
                Spacer()
                    .frame(height: 5)
                Text("Sorry. This feature has not been implemented yet.")
                    .font(.title3)
                    .frame(width: 250)
                    .multilineTextAlignment(.center)
                
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
    NotYetImplementedView()
        .environment(ViewModel())
}
