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
                Image(systemName: "arrow.left.and.right")
                    .font(.system(size: 44))
                //                    .clipped(.Circle)
            }
            .padding(.bottom, 8)
            .buttonStyle(.bordered)
            .buttonBorderShape(.circle)
            
            VStack(spacing: 0) {
                
                Text(vm.line1)
                    .font(.system(size: 30))
                    .fontWeight(.black)
                    .padding(.top, 14)
                    .padding(.bottom, 4)
                
                
                HStack {
                    Button {
                        vm.bumpUp()
                    } label: {
                        Image(systemName: "arrow.up")
                    }
                    .opacity(vm.bumpUpVisible ? 1 : 0)
                    .disabled(!vm.bumpUpVisible)
                    .font(.system(size: 30))
                    
                    Text(vm.line2)
                        .font(.system(size: 50))
                        .fontWeight(.black)
                    
                    Button {
                        vm.bumpDown()
                    } label: {
                        Image(systemName: "arrow.down")
                    }
                    .opacity(vm.bumpDownVisible ? 1 : 0)
                    .disabled(!vm.bumpDownVisible)
                    .font(.system(size: 30))
                }
                
                Text(vm.line3)
                    .font(.system(size: 30))
                    .fontWeight(.black)
                    .padding(.top, 4)
            }
            .offset(y: 50)
            
            Spacer()
            
            if vm.showDebugButtons {
                debugOptions
                    .padding(.bottom, 1)
            }
            
        }
    }
}

extension MiddleView {
    
    private var debugOptions: some View {
        VStack {
            topLine
            middleLine
            bottomLine
        }
    }
    
    private var topLine: some View {
        HStack {
            Button {
                vm.showDoublingCube = true
            } label: {
                Text("D")
                    .padding(.all, 5)
                    .foregroundStyle(Color.theme.foreground)
                    .background(.teal)
            }
            Button {
                vm.showDoublingCube = false
            } label: {
                Text("no D")
                    .padding(.all, 5)
                    .foregroundStyle(Color.theme.foreground)
                    .background(.gray)
            }
        }
    }
    
    private var middleLine: some View {
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
    }
    
    private var bottomLine: some View {
        HStack {
            Button {
                vm.pointsOrGamesToWin = .games
            } label: {
                Text("G")
                    .padding(.all, 5)
                    .foregroundStyle(Color.theme.foreground)
                    .background(.indigo)
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
            }
            .opacity(vm.typeOfGame != .friendly ? 1 : 0)
            .disabled(vm.typeOfGame == .friendly)
        }
    }
}

#Preview(traits: .landscapeLeft) {
    MiddleView()
        .environment(ViewModel())
}


