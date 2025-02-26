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
    
    var body: some View {
        GeometryReader { geo in
            
            let columnWidth = geo.size.width
            let largeBoxWidth = columnWidth * 0.58
            let smallBoxWidth = columnWidth * 0.38
            
            VStack {
                
                Text(sideToProcess == .leftHandSide ? vm.LHSName : vm.RHSName)
                    .font(.system(size: 24, weight: .black))
                    .padding(.vertical, 15)
                    .frame(maxWidth: columnWidth)
                    .foregroundStyle(Color.theme.foreground)
                    .background(Color.theme.background)
                //                    .border(width: 3, edges: [.bottom], color: .yellow)
                    .clipped()
                //                    .padding(.bottom, 3)
                
                
                HStack(alignment: .bottom, spacing: 0) {
                    
                    if sideToProcess == .leftHandSide { // Deal with the Left Hand Side
                        
                        Text("\(vm.LHSPoints)")
                            .font(.system(size: 110, weight: .bold))
                            .padding(15)
                            .offset(y: 15)
                            .frame(width: largeBoxWidth)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .strokeBorder(.mint, lineWidth: 4)
                            )
                            .overlay(alignment: .top) {
                                Text("Points")
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
                        
                        Spacer()
                        
                        Text("\(vm.RHSPoints)")
                            .font(.system(size: 110, weight: .bold))
                            .padding(15)
                            .offset(y: 15)
                            .frame(width: largeBoxWidth)
                            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .strokeBorder(.mint, lineWidth: 4)
                            )
                            .overlay(alignment: .top) {
                                Text("Points")
                                    .font(.system(size: 20, weight: .black))
                                    .offset(y: 10)
                            }
                        
                    }
                    
                }
                
                
                HStack {
                    Button {
                        
                    } label: {
                        Text("Backgammon")
                    }
                    .buttonStyle(.bordered)
                    .tint(.pink)
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Gammon")
                    }
                    .buttonStyle(.bordered)
                    .tint(.pink)
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Win")
                    }
                    .buttonStyle(.bordered)
                    .tint(.pink)
                }
            }
        }
    }
}

#Preview(traits: .landscapeLeft) {
    OuterView(sideToProcess: .leftHandSide)
        .environment(ViewModel())
}
