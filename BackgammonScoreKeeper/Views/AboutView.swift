//
//  AboutView.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 29/03/2025.
//

import SwiftUI

struct AboutView: View {
    @Environment(ViewModel.self) var vm
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            TriangleRow(colors: [.red.opacity(vm.opacityOfGameBoard), .green.opacity(vm.opacityOfGameBoard)])
                .frame(width: UIScreen.main.bounds.width / 6)
            
            Spacer()
            
            VStack {
                Spacer()
                Text("Backgammon Score Keeper")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Spacer()
                Text("Designed & Created by Mark Oelbaum")
                    .font(.title)
                Spacer()
                Text("Advice & encouragement was provided by members of")
                Text("The Sapphire Backgammon Meetup Group in London,")
                Text("notably, Steve, Adam & Chris.")
                Spacer()
                Text("Version \(vm.version)")
                    .font(.title2)
                Spacer()
                Text("© 2025 Mark Oelbaum")
                Spacer()
                Button("Dismiss") {
                    vm.screenToShow = .none
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
            Spacer()
            
            TriangleRow(colors: [.red.opacity(vm.opacityOfGameBoard), .green.opacity(vm.opacityOfGameBoard)])
                .frame(width: UIScreen.main.bounds.width / 6)
                .rotationEffect(Angle(degrees: 180))
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview(traits: .landscapeLeft) {
    AboutView()
        .environment(ViewModel())
}
