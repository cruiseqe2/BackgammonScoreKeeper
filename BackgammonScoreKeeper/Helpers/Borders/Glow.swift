//
//  Glow.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 23/03/2025.
//

import SwiftUI

struct GlowEffect: View {
    @State private var gradientStops: [Gradient.Stop] = GlowEffect.generateGradientStops()

    let givenFrameWidth: CGFloat
    let givenFrameHeight: CGFloat
    var useFrameWidth: CGFloat { givenFrameWidth + 15 }
    var useFrameHeight: CGFloat { givenFrameHeight + 15 }
    
    var body: some View {
        ZStack {
            EffectNoBlur(gradientStops: gradientStops, width: 6, useFrameWidth: useFrameWidth, useFrameHeight: useFrameHeight)
                .onAppear {
                    // Start a timer to update the gradient stops every second
                    Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { _ in
                        withAnimation(.easeInOut(duration: 0.5)) {
                            gradientStops = GlowEffect.generateGradientStops()
                        }
                    }
                }
            Effect(gradientStops: gradientStops, width: 9, blur: 4, useFrameWidth: useFrameWidth, useFrameHeight: useFrameHeight)
                .onAppear {
                    // Start a timer to update the gradient stops every second
                    Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { _ in
                        withAnimation(.easeInOut(duration: 0.6)) {
                            gradientStops = GlowEffect.generateGradientStops()
                        }
                    }
                }
            Effect(gradientStops: gradientStops, width: 11, blur: 12, useFrameWidth: useFrameWidth, useFrameHeight: useFrameHeight)
                .onAppear {
                    // Start a timer to update the gradient stops every second
                    Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { _ in
                        withAnimation(.easeInOut(duration: 0.8)) {
                            gradientStops = GlowEffect.generateGradientStops()
                        }
                    }
                }
            Effect(gradientStops: gradientStops, width: 15, blur: 15, useFrameWidth: useFrameWidth, useFrameHeight: useFrameHeight)
                .onAppear {
                    // Start a timer to update the gradient stops every second
                    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                        withAnimation(.easeInOut(duration: 1)) {
                            gradientStops = GlowEffect.generateGradientStops()
                        }
                    }
                }
        }
    }
    
    // Function to generate random gradient stops
    static func generateGradientStops() -> [Gradient.Stop] {
        [
            Gradient.Stop(color: Color(hex: "BC82F3"), location: Double.random(in: 0...1)),
            Gradient.Stop(color: Color(hex: "F5B9EA"), location: Double.random(in: 0...1)),
            Gradient.Stop(color: Color(hex: "8D9FFF"), location: Double.random(in: 0...1)),
            Gradient.Stop(color: Color(hex: "FF6778"), location: Double.random(in: 0...1)),
            Gradient.Stop(color: Color(hex: "FFBA71"), location: Double.random(in: 0...1)),
            Gradient.Stop(color: Color(hex: "C686FF"), location: Double.random(in: 0...1))
        ].sorted { $0.location < $1.location }
    }
}

struct Effect: View {
    let gradientStops: [Gradient.Stop]
    let width: CGFloat
    let blur: CGFloat
    let useFrameWidth: CGFloat
    let useFrameHeight: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(
                    AngularGradient(
                        gradient: Gradient(stops: gradientStops),
                        center: .center
                    ),
                    lineWidth: width
                )
                .frame(
                    width: useFrameWidth,
                    height: useFrameHeight
                )
                .blur(radius: blur)
        }
    }
}

struct EffectNoBlur: View {
    let gradientStops: [Gradient.Stop]
    let width: CGFloat
    let useFrameWidth: CGFloat
    let useFrameHeight: CGFloat

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(
                    AngularGradient(
                        gradient: Gradient(stops: gradientStops),
                        center: .center
                    ),
                    lineWidth: width
                )
                .frame(
                    width: useFrameWidth,
                    height: useFrameHeight
                )
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var hexNumber: UInt64 = 0
        scanner.scanHexInt64(&hexNumber)
        
        let r = Double((hexNumber & 0xff0000) >> 16) / 255
        let g = Double((hexNumber & 0x00ff00) >> 8) / 255
        let b = Double(hexNumber & 0x0000ff) / 255
        
        self.init(red: r, green: g, blue: b)
    }
}


struct NiceGlowEffect: ViewModifier {
    let givenFrameWidth: CGFloat
    let givenFrameHeight: CGFloat
    
    
    func body(content: Content) -> some View {
        content
          .overlay(
            GlowEffect(givenFrameWidth: givenFrameWidth, givenFrameHeight: givenFrameHeight)
            )
          .background(.black)
    }
}

extension View {
    func glowEffect(width: CGFloat, height: CGFloat) -> some View {
        modifier(NiceGlowEffect(givenFrameWidth: width, givenFrameHeight: height))
    }
}

#Preview {
    RoundedRectangle(cornerRadius: 20)
        .fill(.clear)
        .frame(width: 300, height: 100)
        .border(.green, width: 5)
        .glowEffect(width: 300, height: 100)
}

