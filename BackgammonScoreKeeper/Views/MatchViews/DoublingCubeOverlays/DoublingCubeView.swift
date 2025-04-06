//
//  DoublingCubeView.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 24/02/2025.
//

import SwiftUI

struct DoublingCubeView: View {
    @Environment(ViewModel.self) var vm
    @State private var offset: CGSize = .zero
    @State private var show = false
    @State private var maxTravelOfCube: CGFloat = 200
    
    var body: some View {
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.white)
                    .stroke(Color.red, lineWidth: 4)
                
                    .background(
                        vm.cubeValue == 1 ?
                        Text("<<<  Slide Me")
                            .foregroundStyle(.yellow)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .opacity(vm.slideOpacity)
                    .offset(x: -120)
                    .frame(width: 200)
                        : nil)
                
                    .background(
                        vm.cubeValue == 1 ?
                        Text("Slide Me  >>>")
                            .foregroundStyle(.yellow)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .opacity(vm.slideOpacity)
                    .offset(x: 120)
                    .frame(width: 200)
                        : nil)
                
                    .overlay(
                        vm.cubeValue == 1 ?
                        VStack(alignment: .center) {
                            Text("Doubling")
                            Text("Cube")
                        }
                            .foregroundStyle(.black)
                            .font(.system(size: 10, weight: .bold, design: .default))
                        :
                            nil
                    )
                    .overlay(
                        vm.cubeValue != 1 ?
                        Text("\(vm.cubeValue)")
                            .contentTransition(.numericText())
                            .foregroundStyle(.black)
                            .font(.system(size: 30, weight: .bold, design: .default))
                        : nil
                    )
                    .offset(y: -5)
                    .frame(width: 60, height: 60)
                    .offset(x: offset.width)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                offset = value.translation
                                
                                if offset != .zero {
                                    vm.slideOpacity = 0
                                }
                                
                                /// Prevent the cube from going past the extreme Left and extreme Right positions.
                                
                                if offset.width < 0   &&
                                    ((vm.whoHasTheDoublingCube == .owner && vm.positionOfOwner == .leftHandSide) ||
                                     (vm.whoHasTheDoublingCube == .opponent && vm.positionOfOwner == .rightHandSide)) {
                                    offset.width = 0
                                }
                                
                                if offset.width > 0   &&
                                    ((vm.whoHasTheDoublingCube == .owner && vm.positionOfOwner == .rightHandSide) ||
                                     (vm.whoHasTheDoublingCube == .opponent && vm.positionOfOwner == .leftHandSide)) {
                                    offset.width = 0
                                }
                    
                                switch vm.whoHasTheDoublingCube {
                                case .owner:
                                    if offset.width.magnitude > maxTravelOfCube {
                                        vm.cubeOpacity = 0
                                        vm.trigger(offerCubeTo: .opponent)
                                    }
                                case .opponent:
                                    if offset.width.magnitude > maxTravelOfCube {
                                        vm.cubeOpacity = 0
                                        vm.trigger(offerCubeTo: .owner)
                                    }
                                case .middle:
                                    if offset.width < -maxTravelOfCube {
                                        vm.cubeOpacity = 0
                                        vm.trigger(offerCubeTo:
                                                    vm.positionOfOwner == .leftHandSide ? .owner : .opponent
                                        )
                                    }
                                    if offset.width > maxTravelOfCube {
                                        vm.cubeOpacity = 0
                                        vm.trigger(offerCubeTo:
                                                    vm.positionOfOwner == .leftHandSide ? .opponent : .owner
                                        )
                                    }
                                }
                            }
                        
                            .onEnded { value in
                                withAnimation {
                                    self.offset = .zero
                                }
                            }
                        
                    )
                    .opacity(vm.cubeOpacity)
                    .disabled(vm.cubeValue == 64)
                
                Spacer()
            }
                    
    }

}

#Preview(traits: .landscapeLeft) {
    DoublingCubeView()
        .environment(ViewModel())
}

