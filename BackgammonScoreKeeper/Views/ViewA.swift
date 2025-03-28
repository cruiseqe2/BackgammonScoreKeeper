//
//  ViewA.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 28/03/2025.
//

import SwiftUI

struct ViewA: View {
    @State private var isRootPresented = false

    var body: some View {
        VStack(spacing: 20) {
            Text("This is A view")
            Button("Present B View") {
                isRootPresented = true
            }
            .fullScreenCover(isPresented: $isRootPresented) {
                ViewB(root: $isRootPresented)
            }
            Button("Present C View") {
                isRootPresented = true
            }
            .fullScreenCover(isPresented: $isRootPresented) {
                ViewC(root: $isRootPresented)
            }
        }
    }
}

struct ViewB: View {
    @Environment(\.dismiss) var dismiss
    @State private var isPresented = false
    @Binding var root: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("This is B view")

            Button("Present C View") {
                isPresented = true
            }
            .fullScreenCover(isPresented: $isPresented) {
                ViewC(root: $root)
            }

            Button("Dismiss") {
                dismiss()
            }

            Button("Back to root") {
                root = false
            }
        }
    }
}

struct ViewC: View {
    @Environment(\.dismiss) var dismiss
    @State private var isPresented = false
    @Binding var root: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("This is C view")

            Button("Present B View") {
                isPresented = true
            }
            .fullScreenCover(isPresented: $isPresented) {
                ViewB(root: $root)
            }

            Button("Dismiss") {
                dismiss()
            }

            Button("Back to root") {
                root = false
            }
        }
    }
}

#Preview(traits: .landscapeLeft) {
    ViewA()
}
