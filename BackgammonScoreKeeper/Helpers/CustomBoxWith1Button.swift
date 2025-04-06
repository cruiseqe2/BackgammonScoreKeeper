//
//  CustomBoxWith1Button.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 06/04/2025.
//

import SwiftUI

struct CustomBoxWith1Button<Content:View>: View {
    @Environment(ViewModel.self) var vm
    
    let button: String
    let action: () -> Void
    let content: Content
    
    init(
        button: String,
        action: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.button = button
        self.action = action
        self.content = content()
    }
    
    var body: some View {
        Group {
            RoundedRectangle(cornerRadius: 20)
                .fill(.black)
                .frame(
                    width: vm.sizeOfContent.width,
                    height: vm.sizeOfContent.height + 50
                )
            
            /// Main body of the alert
                .overlay(alignment: .top) {
                    content
                        .readSize { size in
                            if size != .zero {
                                vm.sizeOfContent = size
                            }
                        }
                }
            
            /// Bar seperating the body from the buttons
                .overlay(alignment: .bottom) {
                    Rectangle()
                        .stroke(.white.opacity(0.7), lineWidth: 1)
                        .frame(width: vm.sizeOfContent.width, height: 1)
                        .offset(y: -50)
                }
            
            /// Add the (1) button at the bottom
                .overlay(alignment: .bottom) {
                    OneButton(
                        buttonText: button,
                        action: action
                    )
                    .frame(height: 50)
                }
        }
        .foregroundStyle(.white)
        .applyBorder(borderType: .glowing, radius: 20)
        
    }
}

extension CustomBoxWith1Button {
    
    struct OneButton: View {
        var buttonText: String
        var action: () -> Void
        
        var body: some View {
            HStack(spacing: 0) {
                UnevenRoundedRectangle(
                    cornerRadii: .init(
                        bottomLeading: 20,
                        bottomTrailing: 20
                    )
                )
                .fill(.gray.opacity(0.1))
                .overlay(
                    Button(action: {
                        action()
                    }) {
                        Text(buttonText)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .padding(EdgeInsets(top: 0, leading: 60, bottom: 0, trailing: 60))
                    }
                )
            }
        }
    }
}

#Preview(traits: .landscapeLeft) {
    @Previewable @State var showIt: Bool = true
    ZStack {
        Color.black
            .edgesIgnoringSafeArea(.all)
            .overlay(showIt ?
                     CustomBoxWith1Button.init(
                        button: "OK",
                        action: {
                            
                        },
                        content: {
                            NotYetImplementedView()
                        }
                     )
                     : nil )
        
    }
    .environment(ViewModel())
}
