//
//  ConfigureNamesView.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 06/03/2025.
//

import SwiftUI

struct ConfigureNamesView: View {
    @Environment(ViewModel.self) var vm
    @Environment(\.dismiss) var dismiss
    
    @State private var oppName1: String = ""
    @State private var oppName2: String = ""
    @State private var ownName2: String = ""
    
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
                
                NameTextfieldView($vm.secondOwnerName, prompt: "Enter \(vm.firstOwnerName)'s teammate")
                
            }
            .frame(width: 500)
            
            Text(" --- Versus ---")
                .padding(10)
            
            HStack(spacing: 30) {
                
                NameTextfieldView($vm.firstOpponentName, prompt: "Enter First Opponent")

                Text("&")
                    .opacity(vm.secondOpponentName.isNotEmpty     && vm.firstOpponentName.isNotEmpty ? 1 : 0)
                
                NameTextfieldView($vm.secondOpponentName, prompt: "Enter \(vm.firstOpponentName)'s teammate")
                    .opacity(vm.firstOpponentName.isNotEmpty ? 1 : 0)
                    .disabled(vm.firstOpponentName.isEmpty)
                
            }
            .frame(width: 500)
            
            HStack(spacing: 60) {
                
                Button {
                    vm.firstOpponentName = oppName1
                    vm.secondOpponentName = oppName2
                    vm.secondOwnerName = ownName2
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                .buttonStyle(.bordered)
                
                Button {
                    dismiss()
                } label: {
                    Text("Continue")
                }
                .buttonStyle(.borderedProminent)
                .disabled(!entryIsValid)
                
            }
            .padding(.top, 25)
            
            Spacer()
            
        }
        .padding(.horizontal)
        .border(.mint, width: 2)
        .onAppear {
            oppName1 = vm.firstOpponentName
            oppName2 = vm.secondOpponentName
            ownName2 = vm.secondOwnerName
        }
    }
    
}




#Preview(traits: .landscapeLeft) {
    ConfigureNamesView()
        .environment(ViewModel())
}


