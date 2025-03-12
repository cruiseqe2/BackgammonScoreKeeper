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
    
    private var entryIsValid: Bool {
        vm.opponentName.isNotEmpty
    }
    
    
    var body: some View {
        
        @Bindable var vm = vm
        
        VStack(spacing: 8) {
            
            HStack(spacing: 30) {
                
                TextField("", text: $vm.owmerName)
                    .textFieldStyle(.roundedBorder)
                    .disabled(true)
                
                Text("&")
                    .opacity(vm.ownerSecondName.isNotEmpty ? 1 : 0)
                
                TextField("Enter \(vm.owmerName)'s teammate", text: $vm.ownerSecondName)
                    .textFieldStyle(.roundedBorder)
                    .clearButton(text: $vm.ownerSecondName)
                
            }
            .frame(width: 500)
            
            Text(" --- Versus ---")
                .padding(10)
            
            HStack(spacing: 30) {
                
                TextField("Enter First Opponent", text: $vm.opponentName)
                    .textFieldStyle(.roundedBorder)
                    .clearButton(text: $vm.opponentName)
                
                Text("&")
                    .opacity(vm.opponentSecondName.isNotEmpty ? 1 : 0)
                
                TextField("Enter Second Opponent", text: $vm.opponentSecondName)
                    .textFieldStyle(.roundedBorder)
                    .clearButton(text: $vm.opponentSecondName)
                
            }
            .frame(width: 500)
            
            
            Button {
                dismiss()
            } label: {
                Text("Continue")
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 20)
            .disabled(!entryIsValid)
            
            Spacer()
            
        }
        
    }
}




#Preview(traits: .landscapeLeft) {
    ConfigureNamesView()
        .environment(ViewModel())
}


