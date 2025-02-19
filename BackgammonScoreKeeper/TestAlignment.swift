//
//  TestAlignment.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 12/02/2025.
//

import SwiftUI


/*
struct TestAlignment: View {
    @Environment(ViewModel.self) var vm
    @State private var orientation = UIDeviceOrientation.unknown
   // @State private var isLandscape: Bool
    
    private var orientationAtStart: String {
//        print(UIDevice.current.orientation.rawValue)
        //        if UIDevice.current.orientation == .unknown {
//        if let orientation = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.windowScene?.interfaceOrientation {
        if let orientation = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.windowScene?.interfaceOrientation {
            switch orientation {
            case .unknown:
                print("--Unknown")
            case .portrait:
                print("--portrait")
            case .portraitUpsideDown:
                print("--portraitUpsideDown")
            case .landscapeLeft:
                print("--landscapeLeft")
            case .landscapeRight:
                print("--landscapeRight")
            @unknown default:
                print("--default")
            }
            
            
            
            print("From within orientationAtStart \(orientation)")
            if orientation == .landscapeLeft || orientation == .landscapeRight {
                print("landscape")
                return "landscape"
            } else {
                print("not landscape")
                return "bad"
            }
            //        return UIDevice.current.orientation.isLandscape
        }
        print("if let failed")
        return "bad"
    }
    
    
    var body: some View {
        //        Group {
        GeometryReader { geometry in
            
            let outerColumnWidth = geometry.size.width * 0.40
            let middleColumnWidth = geometry.size.width * 0.20
            
            HStack(spacing: 0) {
                Color.red.opacity(0.5)
                    .frame(width: outerColumnWidth)
                    .overlay(Outer(side: "LHS"))
                
                Color.green
                    .frame(width: middleColumnWidth)
                    .overlay(MIDDLE())
                
                Color.blue
                    .frame(width: outerColumnWidth)
                    .overlay(Outer(side: "LHS"))
                
                
                //                column(alignment: HorizontalAlignment.leading, width: totalWidth / 3, content: RandomView)
                ////                column(alignment: .center, width: totalWidth / 3, view: AnyView(Color.mint))
                ////                column(alignment: .trailing, width: totalWidth / 3, view: AnyView(Color.indigo))
            }
            .offset(x: orientation == .landscapeLeft ? 20 : -20)
        }
        .frame(height: 150)
        //        }
        .onRotate { newOrientation in
            orientation = newOrientation
        }
        .onAppear {
            print("on appear = ", orientationAtStart)
//            switch orientationAtStart {
//            case "left":
//                orientation = .landscapeLeft
//            case "right":
//                orientation = .landscapeRight
//            default:
//                orientation = .landscapeRight
            }
        }
        
    
    
    //        private func column(alignment: HorizontalAlignment, width: Double, @ViewBuilder content: () -> Content) -> some View {
    //        VStack(alignment: alignment, spacing: 0) {
    //            Color.red.frame(width: 1)
    //            content
    //                .frame(width: width)
    //            Color.red.frame(width: 1)
    //        }
    //    }
    
}
***/

#Preview(traits: .landscapeLeft) {
    Outer(sideToProcess: .leftHandSide)
        .environment(ViewModel())
}



//struct DeviceRotationViewModifier: ViewModifier {
//    let action: (UIDeviceOrientation) -> Void
//    
//    func body(content: Content) -> some View {
//        content
//            .onAppear()
//            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
//                action(UIDevice.current.orientation)
//            }
//    }
//}

// A View wrapper to make the modifier easier to use
//extension View {
//    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
//        self.modifier(DeviceRotationViewModifier(action: action))
//    }
//}

//struct RandomView: View {
//    var body: some View {
//        VStack {
//            Text("Hello, World!")
//            Color.green
//                .frame(width: 300, height: 100)
//            Text("End of random view")
//        }
//    }
//}
//

struct Outer: View {
    @Environment(ViewModel.self) var vm
    @State var sideToProcess: SideToProcess
    var body: some View {
        GeometryReader { geo in
            
            let columnWidth = geo.size.width
            
            VStack {
                
                Text(sideToProcess == .leftHandSide ? vm.LHSName : vm.RHSName)
                    .font(.system(size: 24, weight: .black))
                    .padding(.vertical, 15)
                    .frame(maxWidth: columnWidth)
                    .foregroundStyle(.white)
                    .background(.black)
                    .border(width: 3, edges: [.bottom], color: .yellow)
                    .clipped()
                    .padding(.bottom, 3)
                
                
                HStack(spacing: 0) {
                    Text("LHS").padding(.leading, 10)
                    Spacer()
                }
                HStack(spacing: 0) {
                    //                Spacer()
                    Text("Another line")
                    //                Spacer()
                }
                HStack(spacing: 0) {
                    Spacer()
                    Text("Bottom line").padding(.trailing, 10)
                }
                
                HStack {
                    Button {
                        
                    } label: {
                        Text("Backgammon")
                    }
                    .buttonStyle(.bordered)
                    .tint(.pink)
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Gammon")
                    }
                    .buttonStyle(.bordered)
                    .tint(.pink)
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Win")
                    }
                    .buttonStyle(.bordered)
                    .tint(.pink)
                }
            }
        }
    }
}

struct MIDDLE: View {
    var body: some View {
        VStack {
            Text("Best Of")
            Text("Up To")
            Text("Games")
            Text("Points")
//            HStack(spacing: 0) {
//                Text("LHS").padding(.leading, 10)
//                Spacer()
//            }
//            HStack(spacing: 0) {
//                Spacer()
//                Text("Another line")
//                Spacer()
//            }
//            HStack(spacing: 0) {
//                Spacer()
//                Text("Bottom line").padding(.trailing, 10)
//            }
//            
            HStack {
                Button {
                    
                } label: {
                    Text("Backgammon")
                }
                .buttonStyle(.bordered)
                .tint(.pink)
                Spacer()
                Button {
                    
                } label: {
                    Text("Gammon")
                }
                .buttonStyle(.bordered)
                .tint(.pink)
                Spacer()
                Button {
                    
                } label: {
                    Text("Win")
                }
                .buttonStyle(.bordered)
                .tint(.pink)
            }
        }
    }
}

