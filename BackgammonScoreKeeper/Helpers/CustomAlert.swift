//
//  CustomAlert.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 19/03/2025.
//

import SwiftUI

struct CustomAlert: View {
    
    @Binding var isShown: Bool
    var message: String
    var button1Text: String
    var button2Text: String
    var alertWidth: CGFloat
    var alertHeight: CGFloat
    var action1: () -> Void
    var action2: () -> Void
    
    let buttonBoxHeight: CGFloat = 50
    
    private var oneButtonMode: Bool {
        button2Text.isEmpty
    }
    
    var body: some View {
        
        Group {
            RoundedRectangle(cornerRadius: 20)
                .fill(.black)
                .frame(width: alertWidth, height: alertHeight)
                .overlay(alignment: .top) {
                    messageSection
                        .frame(height: alertHeight - 50)
                }
                .overlay(alignment: .bottom) {
                    Rectangle()
                        .stroke(.white.opacity(0.7), lineWidth: 1)
                        .frame(width: alertWidth, height: 1)
                        .offset(y: -50)
                    
                }
                .overlay(alignment: .bottom) {
                    buttonsSection
                        .frame(height: 50)
                }
        }
        .flashyBorder(cornerRadius: 20, width: alertWidth, height: alertHeight)
    }
}

extension CustomAlert {
    
    var messageSection: some View {
        Text(message)
            .multilineTextAlignment(.center)
            .padding()
    }
    
    var buttonsSection: some View {
        Rectangle()
            .fill(Color.clear)
            .overlay(
                oneButtonMode ? OneButton(
                    isShown: $isShown,
                    button1Text: button1Text,
                    action1: action1
                ) : nil
            )
            .overlay(
                !oneButtonMode ? TwoButtons(
                    isShown: $isShown,
                    button1Text: button1Text,
                    button2Text: button2Text,
                    action1: action1,
                    action2: action2
                ) : nil
            )
    }
}

struct OneButton: View {
    @Binding var isShown: Bool
    var button1Text: String
    var action1: () -> Void = { }
    var body: some View {
        UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 20, bottomTrailing: 20))
            .fill(.gray.opacity(0.1))
            .frame(height: 50)
            .overlay(
                Button(action: {
                    isShown = false
                    action1()
                }) {
                    Text(button1Text)
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .padding(EdgeInsets(top: 0, leading: 60, bottom: 0, trailing: 60))
                        .contentShape(UnevenRoundedRectangle(cornerRadii: .init(bottomTrailing: 20)))
                }
            )
    }
}

struct TwoButtons: View {
    @Binding var isShown: Bool
    var button1Text: String
    var button2Text: String
    var action1: () -> Void = { }
    var action2: () -> Void = { }
    
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
                        action2()
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









//            VStack(spacing: 25) {
//                Text(message)
//
//                if previousText.isNotEmpty {
//                    Text("Previous Name: \(previousText)")
//
//                    NameTextfieldView($newText, prompt: "Enter new name", promptColor: .orange)
//                        .frame(width: 300)
//
//                }
//
//                VStack() {
//
//                    Rectangle()
//                        .stroke(.white, lineWidth: 2)
//                        .frame(width: .infinity, height: 3)
//                        .position(x: 0, y: alertHeight - 50)
//
//
//                    /// Deal with the case where only 1 button is shown.
//                    if button2Text.isEmpty && button3Text.isEmpty {
//                        HStack() {
//                            Button(button1Text) {
//                                isShown = false
//                                action1()
//                            }
//                        }
//                    } else {
//                        /// Now there are two buttons to be shown, but which ones????
//                        HStack() {
//                            Spacer()
//                            Button(button1Text) {
//                                isShown = false
//                                action1()
//                            }
//                            Spacer()
//                            Rectangle()
//                                .frame(width: 1, height: .infinity)
//                                .padding(.bottom, 20)
//                            Spacer()
//
//                            if button2Text.isNotEmpty {
//                                Button(button2Text) {
//                                    isShown = false
//                                    action2()
//                                }
//                            } else { // Button 3
//                                Button(button3Text) {
//                                    isShown = false
//                                    nameAction(newText)                            }
//                            } // End of Button 3
//                            Spacer()
//                        } // End of HStack
//                    } // End of 2 buttons
//                }
//                //            .border(.red, width: 1)
//            }
//            .frame(width: .infinity, height: 50, alignment: .center)
//            //        .border(.green, width: 1)
//
//            .frame(height: 0, alignment: .center)
//            //        .padding()
//            .frame(width: alertWidth, height: alertHeight)
//            .background(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
//            .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
//        }
//    }



#Preview(traits: .landscapeLeft) {
    @Previewable @State var newText: String = ""
    CustomAlert(
        isShown: .constant(true),
        message: "Sorry. This feature has not been implemented yet.",
        button1Text: "Cancel",
        button2Text: "",
        alertWidth: 300,
        alertHeight: 200,
        action1: { },
        action2: { }
    )
}
