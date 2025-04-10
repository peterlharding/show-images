//
//  ContentView.swift
//  ShowImages
//
//  Created by plh on 2025-04-10.
//

import SwiftUI

struct ContentView: View {
    let imagePaths = ["/Volumes/u/images/test/DSC_1710.JPG", "/Volumes/u/images/test/DSC_1711.JPG", "/Volumes/u/images/test/DSC_1712.JPG", "/Volumes/u/images/test/DSC_1713.JPG"]
    
    @State private var currentIndex = 0
    @State private var timer: Timer?

    var body: some View {
        GeometryReader { geometry in
            let url = URL(fileURLWithPath: imagePaths[currentIndex])
            
            if let image = NSImage(contentsOf: url) {
                Image(nsImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                //            } else {
                //                Text("Image not found at index \(currentIndex)")
                //                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            currentIndex = (currentIndex + 1) % imagePaths.count
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    ContentView()
}
