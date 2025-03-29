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
                    HStack {
                        VStack(alignment: .center, spacing: 0) {
                            Text("Show")
                            Text("Games")
                        }
                        Spacer()
                        ToggleView(isOn: $vm.showSmallBoxIfPointsBased, height: 32)
                    }
                    .padding(.top, 10)
                    .frame(width: vm.middleColumnWidth * 0.8)
                }
                    
            }
            .offset(y: 60)
            
            Spacer()
            
        }
    }
}

#Preview(traits: .landscapeLeft) {
    MiddleView()
        .environment(ViewModel())
}


