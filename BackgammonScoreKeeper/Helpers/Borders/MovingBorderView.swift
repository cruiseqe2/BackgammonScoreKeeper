//
//  MovingBorderView.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 21/03/2025.
//

import SwiftUI

struct MovingBorderView: View {
    @State private var isMovingAround = false
    
    var body: some View {
        VStack {
            
            Button("Start") {
                
            }
            .padding()
            .frame(width: 160, height: 54)
            .flashyBorder(cornerRadius: 27, width: 160, height: 54)
            
            ZStack {
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 27)
                            .frame(width: 160, height: 54)
                            .foregroundStyle(.indigo.gradient)
                        RoundedRectangle(cornerRadius: 27)
                            .strokeBorder(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round, dash: [40, 400], dashPhase: isMovingAround ? -220 : 220))
                            .frame(width: 160, height: 54)
                            .foregroundStyle(
                                LinearGradient(
                                    gradient: Gradient(colors: [.indigo, .white, .purple, .mint, .white, .orange, .indigo]),
                                    startPoint: .trailing,
                                    endPoint: .leading
                                )
                            )
                            .shadow(radius: 2)
                        HStack {
                            Text("Get Started")
                            Image(systemName: "arrow.right")
                        }
                        .bold()
                    }
                }
                .buttonStyle(.plain)
            }
            .onAppear {
                withAnimation(.linear.speed(0.115).repeatForever(autoreverses: false)) {
                    isMovingAround.toggle()
                }
            }
        }
    }
}

#Preview {
    MovingBorderView()
        .preferredColorScheme(.dark)
}


struct MovingBorderViewModifier: ViewModifier {
    
    @State private var isMovingAround: Bool = false
    @State private var phase: CGFloat = 100
    let cornerRadius: CGFloat
    let width: CGFloat
    let height: CGFloat
    
    func body(content: Content) -> some View {
        ZStack {
//            RoundedRectangle(cornerRadius: cornerRadius)
//                .frame(width: width, height: height)
//                .foregroundStyle(.white.gradient)
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round, dash: [8, 14], dashPhase: phase))
                .frame(width: width, height: height)
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [.white, .mint, .white, .orange]),
                        startPoint: .trailing,
                        endPoint: .leading
                    )
                )
//                .shadow(radius: 2)
            content
        }
        .onAppear {
            withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                phase = -100
//                isMovingAround.toggle()
            }
        }
    }
}

extension View {
    func flashyBorder(cornerRadius: CGFloat, width: CGFloat, height: CGFloat) -> some View {
        withAnimation(.linear.repeatForever(autoreverses: false)) {
            modifier(MovingBorderViewModifier(cornerRadius: cornerRadius, width: width, height: height))
        }
    }
}
