//
//  ToggleView.swift
//
//  Created by Kyle Lovely
//
//  https://github.com/pianometal
//

import SwiftUI

/// Custom `.switch` style `Toggle` that scales appropriately based on ``height``
struct ToggleView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var isOn: Bool
    
    var height: CGFloat = 40
    var color: Color = .green.opacity(0.85)
    var fontDesign: Font.Design = .monospaced
    var animation = Animation.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0.75)
    
    var on = "YES"
    var off = "NO"
    
    var body: some View {
        
        HStack {
            
            if isOn { Spacer() }
            
            ZStack {
                
                Circle()
                    .fill(colorScheme == .light ? .white : .black)
                    .padding(padding)
                
                Text(isOn ? on : off)
                    .font(.system(size: fontSize, weight: .black, design: fontDesign))
                    .foregroundStyle(onColor.gradient)
            }
            
            if !isOn { Spacer() }
        }
        .frame(width: width, height: height)
        .background(onColor.gradient)
        .clipShape(Capsule())
        .onTapGesture { toggle() }
    }
    
    private func toggle() {
        withAnimation(animation) { isOn.toggle() }
    }
    
    private var width: CGFloat { height * 1.75 }
    private var padding: CGFloat { height / 16 }
    private var fontSize: CGFloat { height * 0.375 }
    private var onColor: Color { isOn ? color : .gray }
}

#Preview {
    ToggleView(isOn: .constant(true))
}
