//
//  ChooseANumberView.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 07/04/2025.
//

import SwiftUI

struct ChooseANumberView: View {
    @Binding var numberOfGamesOrPoints: Int
    let strideBy: Int
    let size: Int
    let show: Int
    
    private var CGsize: CGFloat { CGFloat(size) }
    private var CGshow: CGFloat { CGFloat(show) }
    private var contentMargin: CGFloat {
        let offsetPadding = CGFloat( Int(show / 2) )
        return CGsize * offsetPadding
    }
    private var arrayOfValidNumbers: [Int] {
        Array(stride(from: 1, through: 100, by: strideBy))
    }
    
    @State private var numberSelected: Int?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(arrayOfValidNumbers, id: \.self) { index in
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: CGsize, height: CGsize)
                        .overlay(
                            Text("\(index)")
                        )
                        .id(index)
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(.horizontal, contentMargin)
        .scrollPosition(id: $numberSelected, anchor: .center)
        .scrollTargetBehavior(.viewAligned)
        .animation(.smooth, value: numberSelected)
        .frame(width: CGsize * CGshow, height: CGsize)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.white.opacity(0.1))
                .stroke(Color.red, lineWidth: 3)
                .frame(width: CGsize, height: CGsize + 2)
            , alignment: .center
        )
        .onChange(of: numberSelected ?? 1) { _, newValue in
            numberOfGamesOrPoints = newValue
        }
        .onAppear {
            numberSelected = numberOfGamesOrPoints
            if arrayOfValidNumbers.contains(numberSelected!) == false {
                numberSelected! -= 1
            }
        }
    }
}

#Preview(traits: .landscapeLeft) {
    struct PreviewWrapper: View {
        @State var selectedNumber = 5
        var body: some View {
            ChooseANumberView(
                numberOfGamesOrPoints: $selectedNumber,
                strideBy: 2,
                size: 39,
                show: 5
            )
        }
    }
    return PreviewWrapper()
}

