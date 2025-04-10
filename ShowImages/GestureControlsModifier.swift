//
//  GestureControlsModifier.swift
//  ShowImages
//
//  Created by plh on 2025-04-10.
//

import SwiftUI

import SwiftUI

struct GestureControlsModifier: ViewModifier {
    @Binding var showMenu: Bool

    func body(content: Content) -> some View {
        content
            .contentShape(Rectangle()) // ensures the whole area is tappable
            .onTapGesture {
                toggleFullScreen()
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.height > 50 {
                            showMenu = true
                        }
                    },
                including: .gesture
            )
    }

    private func toggleFullScreen() {
        if let window = NSApp.windows.first {
            window.toggleFullScreen(nil)
        }
    }
}

