//
//  ConfigurePlayersView.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 06/03/2025.
//

import SwiftUI

struct ConfigurePlayersView: View {
    @Environment(ViewModel.self) var vm
    
    @State private var oppName1: String = ""
    @State private var oppName2: String = ""
    @State private var ownName2: String = ""
    
    @State private var showDialogue: Bool = false
    @State private var fieldForDialogueEntry: String = ""
    private var previousText: String {
        vm.firstOpponentName.isNotEmpty ? "Current Name: \(vm.firstOpponentName)" : ""
    }
    
    private var entryIsValid: Bool {
        vm.firstOpponentName.isNotEmpty
    }
    
    var body: some View {
        
        @Bindable var vm = vm
        
        VStack(spacing: 8) {
            
            Text("Configure Players")
                .font(.title)
                .padding(15)
                
            Text("The first opponent name must be entered.")
                .font(.headline)
                .padding(.bottom, 25)
            
            HStack(spacing: 30) {
                
                TextField("", text: $vm.firstOwnerName)
                    .textFieldStyle(.roundedBorder)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 2))
                    .disabled(true)
                
                Text("&")
                    .opacity(vm.secondOwnerName.isNotEmpty ? 1 : 0)
                
                NameTextfieldView($vm.secondOwnerName, prompt: "Enter \(vm.firstOwnerName)'s teammate", promptColor: .orange)
                
            }
            .frame(width: 500)
            
            Text(" --- Versus ---")
                .padding(10)
            
            HStack(spacing: 30) {
                
                NameTextfieldView($vm.firstOpponentName, prompt: "Enter First Opponent", promptColor: .red)

                Text("&")
                    .opacity(vm.secondOpponentName.isNotEmpty     && vm.firstOpponentName.isNotEmpty ? 1 : 0)
                
                NameTextfieldView($vm.secondOpponentName, prompt: "Enter \(vm.firstOpponentName)'s teammate", promptColor: .orange)
                    .opacity(vm.firstOpponentName.isNotEmpty ? 1 : 0)
                    .disabled(vm.firstOpponentName.isEmpty)
                
            }
            .frame(width: 500)
            
            HStack(spacing: 60) {
                
                Button {
                    vm.firstOpponentName = oppName1
                    vm.secondOpponentName = oppName2
                    vm.secondOwnerName = ownName2
                    vm.isConfigurePlayersShown = false
                } label: {
                    Text("Cancel")
                }
                .paddedButtonStyle(backgroundColor: Color.red.opacity(0.5))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(style: StrokeStyle(lineWidth: 2)))
                
                Button {
                    withAnimation(.spring(duration: 1)) {
                        showDialogue.toggle()
                    }
                } label: {
                    Text("Test")
                }
                .paddedButtonStyle(backgroundColor: Color.green.opacity(0.5))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(style: StrokeStyle(lineWidth: 2)))

                Button {
                    vm.isConfigurePlayersShown = false
                } label: {
                    Text("Continue")
                }
                .paddedButtonStyle(backgroundColor: .blue)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(style: StrokeStyle(lineWidth: 2)))
                .opacity(!entryIsValid ? 0 : 1)
                .disabled(!entryIsValid)
                
            }
            .padding(.top, 25)
            .padding(.bottom, 20)
        }
        .overlay(showDialogue ?
                CustomDialogue.init(
                    isShown: $showDialogue,
                    inputText: $fieldForDialogueEntry,
                    previousText: previousText,
                    message: "Please enter the name of the principal player.\n\n(This will usually be the owner of the iPhone)",
                    button1Text: "Cancel",
                    button2Text: "Accept",
                    dialogueWidth: 300,
                    dialogueHeight: 300,
                    action1: { },
                    action2: { input in
                        vm.firstOpponentName = input
                    }
                ) : nil )
        
        .padding(.horizontal)
        .onAppear {
            oppName1 = vm.firstOpponentName
            oppName2 = vm.secondOpponentName
            ownName2 = vm.secondOwnerName
        }
    }
}

#Preview(traits: .landscapeLeft) {
    ConfigurePlayersView()
        .environment(ViewModel())
}


