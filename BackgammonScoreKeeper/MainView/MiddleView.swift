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
        
        @Bindable var vm = vm
        
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
            
            VStack(spacing: 8) {
                
                Text(vm.line1)
                    .font(.system(size: 30))
                    .fontWeight(.black)
                
                HStack {
                    Button {
                        vm.bumpUp()
                    } label: {
                        Image(systemName: "arrow.up")
                    }
                    .font(.system(size: 30))
                    .opacity(vm.bumpUpVisible ? 1 : 0)
                    .disabled(!vm.bumpUpVisible)
                    
                    Text(vm.line2)
                        .font(.system(size: 50))
                        .fontWeight(.black)
                    
                    Button {
                        vm.bumpDown()
                    } label: {
                        Image(systemName: "arrow.down")
                    }
                    .font(.system(size: 30))
                    .opacity(vm.bumpDownVisible ? 1 : 0)
                    .disabled(!vm.bumpDownVisible)
                }
                
                Text(vm.line3)
                    .font(.system(size: 30))
                    .fontWeight(.black)
                
                if vm.typeOfMatch == .points {
                    Toggle("Games", isOn: $vm.showGamesBoxIfPointsBased)
                        .toggleStyle(SwitchToggleStyle(tint: .green.opacity(0.7)))
                        .padding(.top, 5)
                        .frame(width: vm.middleColumnWidth * 0.75)
                }
                    
            }
            .offset(y: 60)
            
            Spacer()
            
        }
        .overlay((vm.showTestingButtons ? testingButtons : nil), alignment: .bottom)
        
    }
}


extension MiddleView {
    
    private var testingButtons: some View {
        VStack {
            line_1_OfTestingButtons
            line_2_OfTestingButtons
            line_3_OfTestingButtons
            testingLine_ResetLine
        }
        .padding(.bottom, 1)
    }
    
    private var line_1_OfTestingButtons: some View {
        HStack {
            Button {     // Social
                vm.typeOfMatch = .social
                vm.finishWhen = .social
                vm.showDoublingCube = false
            } label: {
                Text("S")
                    .padding(.all, 5)
                    .foregroundStyle(Color.theme.foreground)
                    .background(.red)
            }
            Button {     // Games
                vm.typeOfMatch = .games
                vm.showDoublingCube = false
            } label: {
                Text("G")
                    .padding(.all, 5)
                    .foregroundStyle(Color.theme.foreground)
                    .background(.blue)
            }
            Button {     // Points
                vm.typeOfMatch = .points
                vm.finishWhen = .firstTo
                vm.showDoublingCube = true
            } label: {
                Text("P")
                    .padding(.all, 5)
                    .foregroundStyle(Color.theme.foreground)
                    .background(.brown)
            }
        }
    }
    
    private var line_2_OfTestingButtons: some View {
        HStack {
            Button {     // First To
                vm.finishWhen = .firstTo
            } label: {
                Text("F")
                    .padding(.all, 5)
                    .foregroundStyle(Color.theme.foreground)
                    .background(.brown)
            }
            .opacity(vm.typeOfMatch == .games ? 1 : 0)
            .disabled(vm.typeOfMatch != .games)
            Button {     // Best Of
                vm.finishWhen = .bestOf
                if vm.numberOfGamesOrPoints! .isMultiple(of: 2) {
                    vm.numberOfGamesOrPoints! += 1
                }
            } label: {
                Text("B")
                    .padding(.all, 5)
                    .foregroundStyle(Color.theme.foreground)
                    .background(.blue)
            }
            .opacity(vm.typeOfMatch == .games ? 1 : 0)
            .disabled(vm.typeOfMatch != .games)
        }
    }
    
    private var line_3_OfTestingButtons: some View {
        HStack {
            Button {     // Show Doubling Cube
                if vm.typeOfMatch == .points {
                    vm.showDoublingCube = true
                } else {
                    vm.showDoublingCube = false
                }
            } label: {
                Text("DC")
                    .padding(.all, 5)
                    .foregroundStyle(Color.theme.foreground)
                    .background(.teal)
            }
            Button {     // Hide Doubling Cube
                vm.showDoublingCube = false
            } label: {
                Text("no DC")
                    .padding(.all, 5)
                    .foregroundStyle(Color.theme.foreground)
                    .background(.gray)
            }
        }
        .opacity(vm.typeOfMatch == .points ? 1 : 0)
        .disabled(vm.typeOfMatch != .points)
    }
    
    private var testingLine_ResetLine: some View {
        Button("Reset") {
            vm.clearGame()
        }
        .offset(y: 8)
    }
    
}

#Preview(traits: .landscapeLeft) {
    MiddleView()
        .environment(ViewModel())
}


