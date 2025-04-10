//
//  MenuView.swift
//  ShowImages
//
//  Created by plh on 2025-04-10.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Slideshow Menu")
                .font(.title)
            Button("Close") {
                NSApp.keyWindow?.close() // or dismiss another way
            }
            Button("Quit App") {
                NSApplication.shared.terminate(nil)
            }
        }
        .padding()
        .frame(width: 300, height: 200)
    }
}
