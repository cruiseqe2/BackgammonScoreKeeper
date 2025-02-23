//
//  MiddleView.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 12/02/2025.
//

import SwiftUI


struct MiddleView: View {
    @Environment(ViewModel.self) var vm
    
    var body: some View {
        VStack {
            
            Button {
                vm.swapPositions()
            } label: {
                Image(systemName: "arrow.left.arrow.right")
                    .font(.system(size: 30))
                //                    .clipped(.Circle)
            }
            .padding(.bottom, 16)
            .buttonStyle(.bordered)
            .buttonBorderShape(.circle)
            
            Text(vm.line1)
            Text(vm.line2)
            Text(vm.line3)
            
            Button {
                vm.bumpUp()
            } label: {
                Text("Bump Up")
            }
            .opacity(vm.bumpUpVisible ? 1 : 0)
            .disabled(!vm.bumpUpVisible)
            
            Button {
                vm.bumpDown()
            } label: {
                Text("Bump Down")
            }
            .opacity(vm.bumpDownVisible ? 1 : 0)
            .disabled(!vm.bumpDownVisible)
            
            
            Spacer()
            
            HStack {
                Button {
                    vm.typeOfGame = .friendly
                    vm.pointsOrGamesToWin = nil
                } label: {
                    Text("F")
                        .padding(.all, 5)
                        .foregroundStyle(Color.theme.foreground)
                        .background(.red)
                }
                Button {
                    vm.typeOfGame = .firstTo
                    if vm.pointsOrGamesToWin == nil {
                        vm.pointsOrGamesToWin = [.points, .games].randomElement()
                    }
                } label: {
                    Text("T")
                        .padding(.all, 5)
                        .foregroundStyle(Color.theme.foreground)
                        .background(.blue)
                }
               Button {
                    vm.typeOfGame = .bestOf
                    if vm.pointsOrGamesToWin == nil {
                        vm.pointsOrGamesToWin = [.points, .games].randomElement()
                    }
                   if vm.numberOfGamesOrPoints! % 2 == 0 {
                       vm.numberOfGamesOrPoints! += 1
                   }
                   
                   
                   
                   
                } label: {
                    Text("B")
                        .padding(.all, 5)
                        .foregroundStyle(Color.theme.foreground)
                        .background(.brown)
                }
            }
            HStack {
                Button {
                    vm.pointsOrGamesToWin = .games
                } label: {
                    Text("G")
                        .padding(.all, 5)
                        .foregroundStyle(Color.theme.foreground)
                        .background(.indigo)
                        .clipped()
                }
                .opacity(vm.typeOfGame != .friendly ? 1 : 0)
                .disabled(vm.typeOfGame == .friendly)
                Button {
                    vm.pointsOrGamesToWin = .points
                } label: {
                    Text("P")
                        .padding(.all, 5)
                        .foregroundStyle(Color.theme.foreground)
                        .background(.orange)
                        .clipped()
                }
                .opacity(vm.typeOfGame != .friendly ? 1 : 0)
                .disabled(vm.typeOfGame == .friendly)
                }
            
            
            
            
        }
        //        .background(Color.theme.background)
        //        .border(Color.gray, width: 4)
    }
}

#Preview(traits: .landscapeLeft) {
    MiddleView()
        .environment(ViewModel())
}


