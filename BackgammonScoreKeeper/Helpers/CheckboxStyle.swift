//
//  CheckboxStyle.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 08/03/2025.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(configuration.isOn ? .indigo : .gray)
                .font(.system(size: 20, weight: .bold, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

#Preview {
    var airplaneMode: Bool = false
    Toggle(isOn: .constant(false), label: {
        Image(systemName: "airplane")
        Text("Airplane Mode")
    })
    .padding()
    .toggleStyle(CheckboxStyle())
}
