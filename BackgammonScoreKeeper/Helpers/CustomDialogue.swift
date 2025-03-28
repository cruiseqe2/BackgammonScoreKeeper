//
//  CustomDialogue.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 21/03/2025.
//

import SwiftUI

struct CustomDialogue: View {
    
    @Binding var isShown: Bool
    @Binding var inputText: String
    
    var previousText: String = ""
    var message: String
    var button1Text: String
    var button2Text: String
    var dialogueWidth: CGFloat
    var dialogueHeight: CGFloat
    var action1: () -> Void = {}
    var action2: (String) -> Void = { _ in }
    
    @State private var buttonBoxHeight: CGFloat = 50
    
    var body: some View {
        
        Group {
            RoundedRectangle(cornerRadius: 20)
                .fill(.black)
                .frame(width: dialogueWidth, height: dialogueHeight)
                .overlay(alignment: .top) {
                    dialgoueMessageSection
                        .frame(height: dialogueHeight - 50)
                }
                .overlay(alignment: .bottom) {
                    Rectangle()
                        .stroke(.white.opacity(0.7), lineWidth: 1)
                        .frame(width: dialogueWidth, height: 1)
                        .offset(y: -50)
                    
                }
                .overlay(alignment: .bottom) {
                    dialogueButtonsSection
                        .frame(height: 50)
                }
        }
        .applyBorder(borderType: .glowing, radius: 20)
//        .flashyBorder(cornerRadius: 20, width: dialogueWidth, height: dialogueHeight)
    }
}

extension CustomDialogue {
    
    var dialgoueMessageSection: some View {
        VStack {
            Text(message)
                .multilineTextAlignment(.center)
                .padding(.bottom, 18)
            Text(previousText)
                .foregroundStyle(.yellow)
                .padding(.bottom, 10)
            NameTextfieldView($inputText, prompt: "Enter new name", promptColor: .orange)
                .frame(width: 200)
        }
        .padding()
    }
    
    
    var dialogueButtonsSection: some View {
        Rectangle()
            .fill(Color.clear)
            .overlay(
                DialogueButtons(
                    isShown: $isShown,
                    newText: $inputText,
                    previousText: previousText,
                    button1Text: button1Text,
                    button2Text: button2Text,
                    action1: action1,
                    action2: action2
                )
            )
    }
}
    
struct DialogueButtons: View {
    @Binding var isShown: Bool
    @Binding var newText: String
    var previousText: String
    var button1Text: String
    var button2Text: String
    var action1: () -> Void = { }
    var action2: (String) -> Void = { _ in }
        
    var body: some View {
        HStack(spacing: 0) {
            UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 20))
                .fill(.gray.opacity(0.1))
                .overlay(
                    Button(action: {
                        isShown = false
                        action1()
                    }) {
                        Text(button1Text)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                            .contentShape(UnevenRoundedRectangle(cornerRadii: .init(bottomTrailing: 20)))
                    }
                )
            UnevenRoundedRectangle(cornerRadii: .init(bottomTrailing: 20))
                .fill(.gray.opacity(0.1))
                .overlay(
                    Button(action: {
                        isShown = false
                        action2(newText)
                    }) {
                        Text(button2Text)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                            .contentShape(UnevenRoundedRectangle(cornerRadii: .init(bottomTrailing: 20)))
                    }
                        .disabled(newText.isEmpty)
                )
        }
        .overlay(alignment: .center) {
            Rectangle()
                .stroke(.white.opacity(0.7), lineWidth: 1)
                .frame(width: 1, height: 50)
        }
        
    }
}

#Preview(traits: .landscapeLeft) {
    @Previewable @State var inputText: String = ""
    CustomDialogue(
        isShown: .constant(true),
        inputText: $inputText,
        previousText: "",
        message: "Please enter the name of the principal player.\n\n(This will usually be the owner of this iPhone)",
        button1Text: "Cancel",
        button2Text: "Accept",
        dialogueWidth: 300,
        dialogueHeight: 300,
        action1: { },
        action2: { _ in }
    )
}
