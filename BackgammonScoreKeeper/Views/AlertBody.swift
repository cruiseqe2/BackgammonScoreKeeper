//
//  AlertBody.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 02/04/2025.
//

import SwiftUI


struct ConfirmWishToMakeOffer: View {
    @Environment(ViewModel.self) var vm
    
    var offerMadeTo: OfferCubeTo
    
    var body: some View {
        Group {
            VStack {
                Spacer()
                    .frame(height: 5)
                Text(offerMadeTo == .opponent ? vm.ownerDisplayName : vm.opponentDisplayName)
                    .font(.title)
                Spacer()
                    .frame(height: 10)
                Text("Are you sure you wish to offer \nthe doubling cube to")
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: 10)
                Text(offerMadeTo == .opponent ? vm.opponentDisplayName : vm.ownerDisplayName)
                    .font(.title)
                Spacer()
                    .frame(height: 15)
                VStack(alignment: .leading) {
                    Text("""
                        This question only appears because this is \
                        being run on a phone, and once you press 'Yes', \
                        there is no way to cancel the next \
                        formal Offer Screen.              
                        """)
                    .frame(width: 250)
                    .multilineTextAlignment(.leading)
                }
                .foregroundStyle(.yellow)
                .font(.caption)
                Spacer()
                    .frame(height: 5)
            }
        }
        .padding()
        //        .frame(maxWidth: 500)
        .fixedSize(horizontal: true, vertical: false)
        .foregroundStyle(.white)

    }
}

struct Custom2ChoiceView<Content:View>: View {
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
                        //                        isShown: <#T##Bool#>,
                        button1Text: buttonLeft,
                        button2Text: buttonRight,
                        actionLeft: actionLeft,
                        actionRight: actionRight
                    )
                    .frame(height: 50)
                }
        }
//        .padding()
        .foregroundStyle(.white)
//        .frame(width: 300, height: 300)
        .applyBorder(borderType: .glowing, radius: 20)
        
    }
}

extension Custom2ChoiceView {
    
    struct TwoButtons: View {
//        @Binding var isShown: Bool
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
//                            isShown = false
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
//                            isShown = false
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

extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { GeometryProxy in
                Color.clear
                    .preference(key: SizePreferanceKey.self, value: GeometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferanceKey.self) { value in
            onChange(value)
        }
    }
}

private struct SizePreferanceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) { }
}


#Preview(traits: .landscapeLeft) {
    @Previewable @State var showIt: Bool = true
    ZStack {
        Color.black
            .edgesIgnoringSafeArea(.all)
            .overlay(showIt ?
                Custom2ChoiceView.init(
                    buttonLeft: "Yes",
                    buttonRight: "No",
                    actionLeft: {
                        
                    },
                    actionRight: {
                        showIt = false
                    },
                    content: {
                        ConfirmWishToMakeOffer(offerMadeTo: .opponent)
                    }
                )
                : nil )
                     
                     
                     
//                Custom2ChoiceView.init(buttonLeft: "Yes", buttonRight: "No") {  // ActionLeft
//                    print("Left")
//                } actionRight: {
//                    showIt = false
//                } content: {
//                    ConfirmWishToMakeOffer(offerMadeTo: .opponent)
//                }
//                     : nil
//            )
        
    }
    .environment(ViewModel())
}





//
//  CustomAlert.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 19/03/2025.
//

//import SwiftUI

//struct NewAlert<Content:View>: View {
//    
//    var content: Content
//    
//    init(@ViewBuilder content: () -> Content) {
//        self.content = content()
//    }
//    
//    @Binding var isShown: Bool
//    var button1Text: String
//    var button2Text: String
//    var alertWidth: CGFloat
//    var alertHeight: CGFloat
//    var action1: () -> Void
//    var action2: () -> Void
//    
//    let buttonBoxHeight: CGFloat = 50
//    
//    private var oneButtonMode: Bool {
//        button2Text.isEmpty
//    }
//    
//    var body: some View {
//        
//        Group {
//            RoundedRectangle(cornerRadius: 20)
//                .fill(.black)
//                .frame(width: alertWidth, height: alertHeight)
//                .overlay(alignment: .top) {
//                    messageSectionA
//                        .frame(height: alertHeight - 50)
//                }
//                .overlay(alignment: .bottom) {
//                    Rectangle()
//                        .stroke(.white.opacity(0.7), lineWidth: 1)
//                        .frame(width: alertWidth, height: 1)
//                        .offset(y: -50)
//                    
//                }
//                .overlay(alignment: .bottom) {
//                    buttonsSectionA
//                        .frame(height: 50)
//                }
//        }
//        .applyBorder(borderType: .glowing, radius: 20)
////        .glow(color: .white, radius: 1)
////        .glowEffect(width: alertWidth, height: alertHeight)
//        
////        .flashyBorder(cornerRadius: 20, width: alertWidth, height: alertHeight)
//    }
//}

//extension NewAlert {
//    
//    var messageSectionA: some View {
//        Text("Jimmy")
//            .multilineTextAlignment(.center)
//            .padding()
//    }
//    
//    var buttonsSectionA: some View {
//        Rectangle()
//            .fill(Color.clear)
//            .overlay(
//                oneButtonMode ? OneButtonA(
//                    isShown: $isShown,
//                    button1Text: button1Text,
//                    action1: action1
//                ) : nil
//            )
//            .overlay(
//                !oneButtonMode ? TwoButtonsA(
//                    isShown: $isShown,
//                    button1Text: button1Text,
//                    button2Text: button2Text,
//                    action1: action1,
//                    action2: action2
//                ) : nil
//            )
//    }
//}
//
//struct OneButtonA: View {
//    @Binding var isShown: Bool
//    var button1Text: String
//    var action1: () -> Void = { }
//    var body: some View {
//        UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 20, bottomTrailing: 20))
//            .fill(.gray.opacity(0.1))
//            .frame(height: 50)
//            .overlay(
//                Button(action: {
//                    withAnimation(.linear(duration: 1)) {
//                        isShown = false
//                    }
//                    action1()
//                }) {
//                    Text(button1Text)
//                        .font(.system(size: 20, weight: .bold, design: .default))
//                        .padding(EdgeInsets(top: 0, leading: 60, bottom: 0, trailing: 60))
//                        .contentShape(UnevenRoundedRectangle(cornerRadii: .init(bottomTrailing: 20)))
//                }
//            )
//    }
//}
//
//struct TwoButtonsA: View {
//    @Binding var isShown: Bool
//    var button1Text: String
//    var button2Text: String
//    var action1: () -> Void = { }
//    var action2: () -> Void = { }
//    
//    var body: some View {
//        HStack(spacing: 0) {
//            UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 20))
//                .fill(.gray.opacity(0.1))
//                .overlay(
//                    Button(action: {
//                        isShown = false
//                        action1()
//                    }) {
//                        Text(button1Text)
//                            .font(.system(size: 20, weight: .bold, design: .default))
//                            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
//                            .contentShape(UnevenRoundedRectangle(cornerRadii: .init(bottomTrailing: 20)))
//                    }
//                )
//            UnevenRoundedRectangle(cornerRadii: .init(bottomTrailing: 20))
//                .fill(.gray.opacity(0.1))
//                .overlay(
//                    Button(action: {
//                        isShown = false
//                        action2()
//                    }) {
//                        Text(button2Text)
//                            .font(.system(size: 20, weight: .bold, design: .default))
//                            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
//                            .contentShape(UnevenRoundedRectangle(cornerRadii: .init(bottomTrailing: 20)))
//                    }
//                )
//        }
//        .overlay(alignment: .center) {
//            Rectangle()
//                .stroke(.white.opacity(0.7), lineWidth: 1)
//                .frame(width: 1, height: 50)
//        }
//    }
//    
//}
//
//







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



//#Preview(traits: .landscapeLeft) {
//    @Previewable @State var newText: String = ""
//    CustomAlert(
//        isShown: .constant(true),
//        message: "Sorry. This feature has not been implemented yet.",
//        button1Text: "Cancel",
//        button2Text: "",
//        alertWidth: 300,
//        alertHeight: 200,
//        action1: { },
//        action2: { }
//    )
//}
