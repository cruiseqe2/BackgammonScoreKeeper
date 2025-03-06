//
//  ContentView.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 04/02/2025.
//

import SwiftUI

struct ContentViewXXXXX: View {
    @Environment(ViewModel.self) var vm
    @State private var showMenu = false
    
    var body: some View {
        
        GeometryReader { geometry in
            
            let totalWidth = geometry.size.width
            
            VStack {
                HStack(alignment: .firstTextBaseline) {
                    Text("BACKGAMMON")
                        .font(.system(size: 36, weight: .black))
                        .kerning(8)
                    Text("Score Keeper")
                        .font(.system(size: 24, weight: .black))
                        .kerning(5)
                    
                    Spacer()
                    
                    Button {
                        showMenu.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 30))
                    }
                    .disabled(showMenu)
                }
                Spacer()
                
                HStack {
                    
                    VStack {
                        HStack {
                            Text(vm.LHSName)
                                .font(.system(size: 24, weight: .black))
                                .padding(.vertical, 15)
                                .frame(width: totalWidth * 0.39)
                                .foregroundStyle(.white)
                                .background(.black)
                        }
                        HStack (alignment: .center) {
                            Text("\(vm.LHSGames)")
                                .font(.system(size: 56))
                                .padding(15)
                                .offset(y: 15)
                                .frame(width: 100)
                                .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(.indigo, lineWidth: 4)
                                )
                                .overlay(alignment: .top) {
                                    Text("Games")
                                        .font(.system(size: 20, weight: .black))
                                        .offset(y: 7)
                                }
                            //                            Spacer()
                            //                                .border(Color.gray, width: 1)
                            Text("\(vm.LHSPoints)")
                                .font(.system(size: 110, weight: .bold))
                                .padding(15)
                                .offset(y: 15)
                                .frame(width: 200)
                                .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(.mint, lineWidth: 4)
                                )
                                .overlay(alignment: .top) {
                                    Text("Points")
                                        .font(.system(size: 20, weight: .black))
                                        .offset(y: 10)
                                }
                        }
                        
                        HStack {
                        }
                        
                        .border(Color.gray, width: 1)
                        
                    }
                    .frame(width: totalWidth * 0.40, alignment: .leading)
                    //                    .border(Color.gray, width: 1)
                    
                    Spacer()
                    
                    VStack {
//                        Spacer()
                        Button {
                            vm.swapPositions()
                        } label: {
                            Image(systemName: "arrow.left.arrow.right")
                                .font(.system(size: 40))
                        }
                        .padding()
                        .buttonStyle(.bordered)
//                        Spacer()
//                        Spacer()
                        Spacer()
                        Text(vm.line1)
                            .font(.system(size: 28, weight: .black))
                        Text(vm.line2)
                            .font(.system(size: 55, weight: .black))
                        Text(vm.line3)
                            .font(.system(size: 28, weight: .black))
                        Spacer()
                        Spacer()
                    }
//                    .padding(.horizontal, 20)
                    .border(Color.gray, width: 1)
                    
                    Spacer()
                    VStack {
                        Text(vm.RHSName)
                            .font(.system(size: 24, weight: .black))
                            .padding(.vertical, 15)
                            .frame(width: totalWidth * 0.39)
                            .foregroundStyle(.white)
                            .background(.black)
                        HStack (alignment: .center){
                            Text("\(vm.RHSPoints)")
                                .font(.system(size: 110, weight: .bold))
                                .padding(15)
                                .offset(y: 15)
                                .frame(width: 200)
                                .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(.mint, lineWidth: 4)
                                )
                                .overlay(alignment: .top) {
                                    Text("Points")
                                        .font(.system(size: 20, weight: .black))
                                        .offset(y: 10)
                                }
                            //                            Spacer()
                            Text("\(vm.RHSGames)")
                                .font(.system(size: 56))
                                .padding(15)
                                .offset(y: 15)
                                .frame(width: 100)
                                .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(.indigo, lineWidth: 4)
                                )
                                .overlay(alignment: .top) {
                                    Text("Games")
                                        .font(.system(size: 20, weight: .black))
                                        .offset(y: 7)
                                }
                        }
                    }
                    //                    .border(Color.gray, width: 1)
                    .frame(width: totalWidth * 0.35)
                    
                }
                
                // Line of Buttons
                HStack {
                    
                    // LHS Buttons
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
                    .frame(width: totalWidth * 0.40, alignment: .leading)
                    Spacer()
                    
                    // RHS Buttons
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
                    .frame(width: totalWidth * 0.40, alignment: .trailing)
                    .offset(x: 30)
                }
                .padding(.top)
                .frame(width: totalWidth)
                
                // Line of Adjustment Buttons
                HStack {
                    
                    // LHS Adjustment Buttons
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
                    .frame(width: totalWidth * 0.40, alignment: .leading)
                    Spacer()
                    
                    // RHS Adjustment Buttons
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
                    .frame(width: totalWidth * 0.40, alignment: .trailing)
                    .offset(x: 30)
                }
                .padding(.top, 5)
                .frame(width: totalWidth)

//                Spacer()
//                Spacer()
                
            }

//            Color.mint
//                .frame(width: totalWidth, height: 20)


        }
        .preferredColorScheme(.dark)
        .padding()
        .opacity(showMenu ? 0.2 : 1.0)
        .disabled(showMenu)
        .overlay(mainMenu)
    }
    
    @ViewBuilder private var mainMenu: some View {
        if showMenu {
            MainMenu(showMenu: $showMenu)
        }
    }
}

#Preview(traits: .landscapeLeft) {
    ContentViewXXXXX()
        .environment(ViewModel())
}



