//
//  MenuView.swift
//  ShowImages
//
//  Created by plh on 2025-04-10.
//

import SwiftUI

struct MenuView: View {
    @Binding var isPresented: Bool
    var onClose: () -> Void

    
    var body: some View {
        VStack(spacing: 20) {
            Text("Slideshow Menu")
                .font(.title)
            Button("Close") {
                // NSApp.keyWindow?.close() // or dismiss another way
                isPresented = false // ✅ Dismiss the modal
                onClose()
            }
            Button("Quit App") {
                isPresented = false
                onClose()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    NSApplication.shared.terminate(nil)
                }
                
//                DispatchQueue.main.async {
//                    print("Attempting to quit...") // Add this for debugging
//                    NSApplication.shared.terminate(nil)
//                }
                
                // NSApplication.shared.terminate(nil)
            }
        }
        .padding()
        .frame(width: 300, height: 200)
    }
    
    func quitAppSafely() {
        // Try to close the active window first
        if let window = NSApp.keyWindow {
            window.close()
        }

        // Then terminate the app
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            NSApplication.shared.terminate(nil)
        }
    }
    
}
