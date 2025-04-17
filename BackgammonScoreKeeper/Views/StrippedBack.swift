//
//  StrippedBack.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 13/04/2025.
//

import SwiftUI

enum TGamesOrPoints: String, RawRepresentable, CaseIterable {
    case games = "Games"
    case points = "Points"
}

enum TTypeOfPlay: String, RawRepresentable, CaseIterable {
    case bestOf = "Best Of"
    case firstTo = "First To"
}

@Observable
class TestViewModel {
    var numberOfGames: Int = 15
    var gamesOrPoints: TGamesOrPoints = .games
    var typeOfPlay: TTypeOfPlay = .bestOf
    var strideBy: Int {
        gamesOrPoints == .points ? 1 :
        typeOfPlay == .firstTo ? 1 : 2
    }
    var numbersToShow: [Int] {
        Array(stride(from: 1, through: 100, by: strideBy))
    }
}

struct StrippedBack: View {
    @Environment(\.testViewModel) var tvm
    
    var body: some View {
        
        @Bindable var tvm = tvm
        
        VStack(spacing: 20) {
            
            HStack(spacing: 40) {
                Text("Current tvm.numberOfGames: \(tvm.numberOfGames)")
                Text("Current tvm.stride: \(tvm.strideBy)")
            }
            
            Picker("", selection: $tvm.gamesOrPoints) {
                ForEach(TGamesOrPoints.allCases, id:\.self) { item in
                    Text("\(item.rawValue)")
                }
            }
            .pickerStyle(.segmented)
            
            HStack(spacing: 0) {
                
                VStack(spacing: 20) {
                    Text("Games")
                        .frame(maxWidth: .infinity)
                    
                    Picker("", selection: $tvm.typeOfPlay) {
                        ForEach(TTypeOfPlay.allCases, id:\.self) { item in
                            Text("\(item.rawValue)")
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    if tvm.gamesOrPoints == .games {
                        if tvm.typeOfPlay == .bestOf {
                            TChooseNumber(numberOfGames: $tvm.numberOfGames,
                                          numbersToShow: tvm.numbersToShow, strideBy: tvm.strideBy)
                        } else {     // .firstTo
                            TChooseNumber(numberOfGames: $tvm.numberOfGames,
                                          numbersToShow: tvm.numbersToShow, strideBy: tvm.strideBy)
                        }
                    }
                    Spacer()
                }
                .border(Color.blue)
                .frame(height: 200)
                
                VStack(spacing: 20) {
                    Text("Points")
                        .frame(maxWidth: .infinity)
                    
                    if tvm.gamesOrPoints == .points {
                        TChooseNumber(numberOfGames: $tvm.numberOfGames,
                                      numbersToShow: tvm.numbersToShow, strideBy: tvm.strideBy)
                    }
                    Spacer()
                }
                .border(Color.green)
                .frame(height: 200)
            }
        }
    }
}

struct TChooseNumber: View {
    
    @Binding var numberOfGames: Int
    @State var numbersToShow: [Int]
    @State var strideBy: Int
    
    @State var numberToShow: Int? = nil
    
    var body: some View {
        
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 3) {
                    ForEach(numbersToShow, id:\.self) { index in
                        Text("\(index)")
                            .frame(width: 30, height: 30)
                            .id(index)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition(id: $numberToShow, anchor: .center)
            .frame(maxWidth: 300)
        }
        .onChange(of: numberToShow ?? 73) { _, newValue in
            numberOfGames = newValue
        }
        .onAppear {
            numberToShow = numberOfGames
            if strideBy == 2 && numberToShow! % 2 == 0 {
                numberToShow! += 1
            }
            if numberToShow! > 99 {
                numberToShow! = 99
            }
        }
    }
}

extension EnvironmentValues {
    @Entry var testViewModel = TestViewModel()
}

#Preview(traits: .landscapeLeft) {
    @Previewable @State var testViewModel = TestViewModel()
    StrippedBack()
        .environment(TestViewModel())
}
