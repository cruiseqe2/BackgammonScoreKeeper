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
    
    // The Field itself
    @Binding var field: String
    
    init(_ field: Binding<String>, prompt: String) {
        self._field = field
        self.prompt = prompt
    }
    
    var body: some View {
        TextField("", text: $field, prompt: Text(prompt).foregroundStyle(.red))
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
