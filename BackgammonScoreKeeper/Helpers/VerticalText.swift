//
//  VerticalText.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 23/03/2025.
//

import SwiftUI

struct VerticalText: View {
    var string: String
    var size: CGFloat
    
    struct LettersArray: Identifiable {
        let id = UUID()
        let char: String
    }
    
    @State private var lettersArray = [LettersArray]()
    
    var body: some View {
        VStack {
            ForEach(lettersArray.indices, id: \.self) { index in
                if index != lettersArray.count - 1 {
                    Text("\(lettersArray[index].char)\n")
                        .font(.system(size: size, weight: .bold, design: .default))
                } else {
                    Text("\(lettersArray[index].char)")
                        .font(.system(size: size, weight: .bold, design: .default))
                }
            }
        }
        .onAppear {
            for i in string {
                lettersArray.append(LettersArray(char: String(i)))
            }
        }
    }
}

#Preview(traits: .landscapeLeft) {
    HStack {
        Spacer()
        VerticalText(string: "BACKGAMMON", size: 16)
        Spacer()
        VerticalText(string: "SCORE KEEPER", size: 13)
        Spacer()
    }
}

