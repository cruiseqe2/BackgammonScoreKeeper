//
//  NumberHorizontalPicker.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 07/03/2025.
//

import SwiftUI

struct NumberHorizontalPicker: View {
    
    struct NumberModel: Hashable {
        let number: Int
        let isSelected: Bool = false
    }
    
    @State private var scrollIndex: Int? = 1
    @Binding var selection: Int
    
    private let numberRange: Array<Int>
    private let validGamesOrPoints: ValidGamesOrPoints
    private let numberToDisplay: Int
    
    init(selection: Binding<Int>, in numberRange: Array<Int>, validGamesOrPoints: ValidGamesOrPoints = .all, numberToDisplay: Int = 5) {
        self._selection = selection
        self.numberRange = numberRange
        self.validGamesOrPoints = validGamesOrPoints
        self.numberToDisplay = numberToDisplay
    }
    
    private var candidateNumbers: [NumberModel] {
        var numbers: [NumberModel] = []
        
        var currentNumber = numberRange.first!
        while currentNumber <= numberRange.last! {
            let numberModel = NumberModel(number: currentNumber)
            switch validGamesOrPoints {
            case .all:
                numbers.append(numberModel)
            case .oddsOnly:
                if !currentNumber.isMultiple(of: 2) {
                    numbers.append(numberModel)
                }
            case .evensOnly:
                if currentNumber.isMultiple(of: 2) {
                    numbers.append(numberModel)
                }
            }
            currentNumber += 1
        }
        return numbers
    }
     
    var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(candidateNumbers, id: \.number) { numberModel in
                        numberItemView(
                            number: numberModel.number,
                            isSelected: numberModel.number == selection
                        )
                        .id(numberModel.number)
                        .containerRelativeFrame(.horizontal, count: numberToDisplay, span: 1, spacing: 0)
                        .animation(.smooth, value: selection)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition(id: $scrollIndex)
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
            .scrollBounceBehavior(.basedOnSize)
            .onChange(of: selection, initial: true) { oldValue, newValue in
                if oldValue == newValue {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        if let currentNumberItem = candidateNumbers.first(where: { $0.number == selection }) {
                            selection = currentNumberItem.number
                            scrollViewProxy.scrollTo(currentNumberItem.number, anchor: .center)
                        }
                    }
                }
            }
        }
        .frame(height: 50)
    }
    
    @ViewBuilder
    func numberItemView(number: Int, isSelected: Bool = false) -> some View {
            Group {
                switch (isSelected) {
                case (true): // Day selected
                    Circle()
                        .fill(Color.accentColor)
                        .overlay {
                            Text("\(number)")
                                .foregroundStyle(.orange)
                        }
                        .padding(8)
                case (false): // Is current day but not selected
                    Circle()
                        .strokeBorder(Color.accentColor, style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .overlay {
                            Text("\(number)")
                                .foregroundStyle(.yellow)
                                .font(.title)
                        }
                        .padding(8)
                default: // Default day
                    Text("\(number)")
                        .padding()
//                        .foregroundStyle(isWeekend ? .red : .primary)
                }
            }
            .onTapGesture {
                selection = number
            }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var selectedNumber = 17
        
        var body: some View {
            let validRange = Array(2...50)
            NumberHorizontalPicker(selection: $selectedNumber, in: validRange, validGamesOrPoints: .all)
                .accentColor(.green)
        }
    }
    
    return PreviewWrapper()
}
