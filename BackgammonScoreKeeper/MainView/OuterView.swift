//
//  OuterView.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 12/02/2025.
//

import SwiftUI

struct OuterView: View {
    @Environment(ViewModel.self) var vm
    @State var sideToProcess: SideToProcess
    
    private var buttonSide: Side {
        if sideToProcess == .leftHandSide {
            if vm.positionOfOwner == .leftHandSide {
                return .owner
            } else {
                return .opponent
            }
        } else {  // sideToProcess = .rightHandSide
            if vm.positionOfOwner == .leftHandSide {
                return .opponent
            } else {
                return .owner
            }
        }
    }
    
    
    
    private var backgroundColor: Color {
        guard vm.winnerIs != .noWinnerYet else {
            return Color.theme.background
        }
        
        if sideToProcess == .leftHandSide {
            if vm.positionOfOwner == .leftHandSide {
                return vm.winnerIs == .owner ? .green : .red
            } else {  // positionOfOwner = .rightHandSide
                return vm.winnerIs == .owner ? .red : .green
            }
        } else {  // sideToProcess = .rightHandside
            if vm.positionOfOwner == .leftHandSide {
                return vm.winnerIs == .owner ? .red : .green
            } else {  // positionOfOwner = .rightHandSide
                return vm.winnerIs == .owner ? .green : .red
            }
        }
        
    }
    
    var body: some View {
        GeometryReader { geo in
            
            let columnWidth = geo.size.width
            let largeBoxWidth = columnWidth * 0.58
            let smallBoxWidth = columnWidth * 0.38
            
            VStack {
                
                Text(sideToProcess == .leftHandSide ? vm.LHSName : vm.RHSName)
                    .font(.system(size: 24, weight: .black))
                    .padding(.vertical, 10)
                    .frame(maxWidth: columnWidth)
                    .foregroundStyle(Color.theme.foreground)
                    .background(backgroundColor)
                    .border(width: 3, edges: [.bottom], color:
                                Color.theme.foreground
                    )
                    .padding(.bottom, 8)
                    .clipped()
                
                HStack(alignment: .bottom, spacing: 0) {
                    
                    if sideToProcess == .leftHandSide { // Deal with the Left Hand Side
                        
                        Text(vm.typeOfMatch == .points ? "\(vm.LHSPoints)" : "\(vm.LHSGames)")
                        
//                        Text(vm.typeOfMatch == .points ? "\(vm.LHSPoints)") : "\(vm.LHSGames)")
                            .font(.system(size: 110, weight: .bold))
                            .padding(15)
                            .offset(y: 15)
                            .frame(width: largeBoxWidth)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .strokeBorder(.mint, lineWidth: 4)
                            )
                            .overlay(alignment: .top) {
                                Text(vm.typeOfMatch == .points ? "Points" : "Games")
                                    .font(.system(size: 20, weight: .black))
                                    .offset(y: 10)
                            }
                            .onPointsBoxShown { topOfPointsBox in
                                vm.doublingCubeYPosition = topOfPointsBox
                            }
                        
                        Spacer()
                        
                        Text("\(vm.LHSGames)")
                            .font(.system(size: 56))
                            .padding(15)
                            .offset(y: 15)
                            .frame(width: smallBoxWidth)
                            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .strokeBorder(.indigo, lineWidth: 4)
                            )
                            .overlay(alignment: .top) {
                                Text("Games")
                                    .font(.system(size: 20, weight: .black))
                                    .offset(y: 7)
                            }
                            .addWidthOfObject { gamesBoxWidth in
                                vm.totalWidth += gamesBoxWidth
                            }
                            .getGamesBoxWidth { gamesBoxWidth in
                                vm.gamesBoxWidth = gamesBoxWidth
                            }
                            .opacity(vm.typeOfMatch == .points  &&  vm.showGamesBoxIfPointsBased ? 1 : 0)
                        
                    } else {  // We are now dealing with the Right Hand Side
                        
                        Text("\(vm.RHSGames)")
                            .font(.system(size: 56))
                            .padding(15)
                            .offset(y: 15)
                            .frame(width: smallBoxWidth)
                            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .strokeBorder(.indigo, lineWidth: 4)
                            )
                            .overlay(alignment: .top) {
                                Text("Games")
                                    .font(.system(size: 20, weight: .black))
                                    .offset(y: 7)
                            }
                            .addWidthOfObject { gamesBoxWidth in
                                vm.totalWidth += gamesBoxWidth
                            }
                            .opacity(vm.typeOfMatch == .points  &&  vm.showGamesBoxIfPointsBased ? 1 : 0)
                        
                        Spacer()
                        
                        Text(vm.typeOfMatch == .points ? "\(vm.RHSPoints)" : "\(vm.RHSGames)")
//                        Text("\(vm.RHSPoints)")
                            .font(.system(size: 110, weight: .bold))
                            .padding(15)
                            .offset(y: 15)
                            .frame(width: largeBoxWidth)
                            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .strokeBorder(.mint, lineWidth: 4)
                            )
                            .overlay(alignment: .top) {
                                Text(vm.typeOfMatch == .points ? "Points" : "Games")   .font(.system(size: 20, weight: .black))
                                    .offset(y: 10)
                            }
                        
                    }
                    
                }
                
                /// Deal with the button pressing
                
                if sideToProcess == .leftHandSide { // Deal with the Left Hand Side
                    
                    HStack {
                        Button {
                            vm.WinningButtonTapped(side: buttonSide, value: 3)
                        } label: {
                            Text("Backgammon")
                        }
                        .buttonStyle(.bordered)
                        .tint(.pink)
                        Spacer()
                        Button {
                            vm.WinningButtonTapped(side: buttonSide, value: 2)
                        } label: {
                            Text("Gammon")
                        }
                        .buttonStyle(.bordered)
                        .tint(.pink)
                        Spacer()
                        Button {
                            vm.WinningButtonTapped(side: buttonSide, value: 1)
                        } label: {
                            Text("Win")
                        }
                        .buttonStyle(.bordered)
                        .tint(.pink)
                    }
                    
                } else {  // We are now dealing with the Right Hand Side
                    
                    HStack {
                        Button {
                            vm.WinningButtonTapped(side: buttonSide, value: 1)
                        } label: {
                            Text("Win")
                        }
                        .buttonStyle(.bordered)
                        .tint(.pink)
                        Spacer()
                        Button {
                            vm.WinningButtonTapped(side: buttonSide, value: 2)
                        } label: {
                            Text("Gammon")
                        }
                        .buttonStyle(.bordered)
                        .tint(.pink)
                        Spacer()
                        Button {
                            vm.WinningButtonTapped(side: buttonSide, value: 3)
                        } label: {
                            Text("Backgammon")
                        }
                        .buttonStyle(.bordered)
                        .tint(.pink)
                    }
                    
                    
                    
                    
                    
                }
            }
        }
    }
}

#Preview(traits: .landscapeLeft) {
    OuterView(sideToProcess: .leftHandSide)
        .environment(ViewModel())
}
