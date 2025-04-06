//
//  CustomBoxWith2Choices.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 06/04/2025.
//

import SwiftUI

struct CustomBoxWith2Choices<Content:View>: View {
    @Environment(ViewModel.self) var vm
    
    let buttonLeft: String
    let buttonRight: String
    let actionLeft: () -> Void
    let actionRight: () -> Void
    let content: Content
    
    init(
        buttonLeft: String,
        buttonRight: String,
        actionLeft: @escaping () -> Void,
        actionRight: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.buttonLeft = buttonLeft
        self.buttonRight = buttonRight
        self.actionLeft = actionLeft
        self.actionRight = actionRight
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
            
            /// Add the 2 buttons at the bottom
                .overlay(alignment: .bottom) {
                    TwoButtons(
                        button1Text: buttonLeft,
                        button2Text: buttonRight,
                        actionLeft: actionLeft,
                        actionRight: actionRight
                    )
                    .frame(height: 50)
                }
        }
        .foregroundStyle(.white)
        .applyBorder(borderType: .glowing, radius: 20)
        
    }
}

extension CustomBoxWith2Choices {
    
    struct TwoButtons: View {
        var button1Text: String
        var button2Text: String
        var actionLeft: () -> Void
        var actionRight: () -> Void
        
        var body: some View {
            HStack(spacing: 0) {
                UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 20))
                    .fill(.gray.opacity(0.1))
                    .overlay(
                        Button(action: {
                            actionLeft()
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
                            actionRight()
                        }) {
                            Text(button2Text)
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                                .contentShape(UnevenRoundedRectangle(cornerRadii: .init(bottomTrailing: 20)))
                        }
                    )
            }
            .overlay(alignment: .center) {
                Rectangle()
                    .stroke(.white.opacity(0.7), lineWidth: 1)
                    .frame(width: 1, height: 50)
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
                CustomBoxWith2Choices.init(
                    buttonLeft: "Accept",
                    buttonRight: "Reject",
                    actionLeft: {
                        
                    },
                    actionRight: {
                        showIt = false
                    },
                    content: {
//                        ConfirmWishToMakeOffer(offerMadeTo: .opponent)
                        ShowDoublingOffer(offerMadeTo: .opponent)
                    }
                )
                : nil )
        
    }
    .environment(ViewModel())
}
