//
//  NameTextfieldView.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 14/03/2025.
//

import SwiftUI

struct NameTextfieldView: View {
    let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
    let prompt: String
    let promptColor: Color
    
    // The Field itself
    @Binding var field: String
    
    init(_ field: Binding<String>, prompt: String, promptColor: Color) {
        self._field = field
        self.prompt = prompt
        self.promptColor = promptColor
    }
    
    var body: some View {
        TextField("", text: $field, prompt: Text(prompt).foregroundStyle(promptColor.opacity(0.8)))
            .textFieldStyle(.roundedBorder)
            .clearButton(text: $field)
            .keyboardType(.asciiCapable)
            .submitLabel(.done)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.words)
            .onChange(of: field) { _, newValue in
                field = field.filter { allowedCharacters.contains($0) }
            }
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 2))
    }
}
