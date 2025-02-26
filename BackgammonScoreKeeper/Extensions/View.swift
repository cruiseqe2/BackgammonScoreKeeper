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
    
    func getGamesBoxWidth(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
        self
            .background(
                GeometryReader { geo in
                    Text("")
                        .preference(key: GamesBoxWidthKey.self, value: geo.size.width)
                }
            )
            .onPreferenceChange(GamesBoxWidthKey.self) { value in
                action(value)
            }
    }
    
}

