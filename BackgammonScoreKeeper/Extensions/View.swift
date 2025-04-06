//
//  View.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 26/02/2025.
//

import SwiftUI

extension View {
    
    func onPointsBoxShown(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
        self
            .background(
                GeometryReader { geo in
                    Text("")
                        .preference(key: DoublingCubeYPosition.self, value: geo.frame(in: .global).minY)
                }
            )
            .onPreferenceChange(DoublingCubeYPosition.self) { value in
                action(value)
            }
    }
    
    func addWidthOfObject(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
        self
            .background(
                GeometryReader { geo in
                    Text("")
                        .preference(key: TotalWidthKey.self, value: geo.size.width)
                }
            )
            .onPreferenceChange(TotalWidthKey.self) { value in
                action(value)
            }
    }
    
    func getSmallBoxWidth(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
        self
            .background(
                GeometryReader { geo in
                    Text("")
                        .preference(key: SmallBoxWidthKey.self, value: geo.size.width)
                }
            )
            .onPreferenceChange(SmallBoxWidthKey.self) { value in
                action(value)
            }
    }
    
    func getLargeBoxWidth(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
        self
            .background(
                GeometryReader { geo in
                    Text("")
                        .preference(key: LargeBoxWidthKey.self, value: geo.size.width)
                }
            )
            .onPreferenceChange(LargeBoxWidthKey.self) { value in
                action(value)
            }
    }
    
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { GeometryProxy in
                Color.clear
                    .preference(key: SizePreferanceKey.self, value: GeometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferanceKey.self) { value in
            onChange(value)
        }
    }
    
}

