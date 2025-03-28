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
            ForEach(lettersArray) { element in
                Text("\(element.char)\n")
                    .font(.system(size: size, weight: .bold, design: .default))
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
        VerticalText(string: "BACKGAMMON", size: 15)
        Spacer()
        VerticalText(string: "SCORE KEEPER", size: 12)
        Spacer()
    }
}

