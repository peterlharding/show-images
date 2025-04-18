//
//  ContentView.swift
//  ShowImages
//
//  Created by plh on 2025-04-10.
//

import SwiftUI

struct ContentView: View {
//    let imagePaths = ["/Volumes/u/images/test/DSC_1710.JPG", "/Volumes/u/images/test/DSC_1711.JPG", "/Volumes/u/images/test/DSC_1712.JPG", "/Volumes/u/images/test/DSC_1713.JPG"]
    
    @State private var imageURLs: [URL] = []
    @State private var currentIndex = 0
    @State private var timer: Timer?
    @State private var folderURL: URL?
    
    @State private var tapCount = 0
    @State private var tapTimer: Timer?
    
    @State private var dragOffset: CGSize = .zero
    @State private var showMenu = false
    @State private var menuRecentlyClosed = false
    
    let interval: Double = 1
    
    // let folderPath = "/Volumes/u/images/test"


    
    var body: some View {
        VStack {
            if folderURL != nil {
                GeometryReader { geometry in
                    Group {
                        if imageURLs.indices.contains(currentIndex),
                           let image = NSImage(contentsOf: imageURLs[currentIndex]) {
                            Image(nsImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                        } else {
                            Text("No image found")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    .contentShape(Rectangle()) // makes entire view tappable
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                guard !menuRecentlyClosed else { return }

                                print("[Drag] value: \(value)")
                                if abs(value.translation.height) > 50 {
                                    showMenu = true
                                }
                            }
                    )
                    .sheet(isPresented: $showMenu) {
                        // MenuView(isPresented: $showMenu)
                        MenuView(isPresented: $showMenu, onClose: setMenuCooldown)
                    }
                }
            } else {
                Button("Select Folder of Images") {
                    selectFolder()
                }
                .padding()
            }
        }
        .onAppear {
            if folderURL != nil {
                startTimer()
            }
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    func exitApp() {
        NSApplication.shared.terminate(nil)
    }

    func exitFullScreen() {
        if let window = NSApp.windows.first, window.styleMask.contains(.fullScreen) {
            window.toggleFullScreen(nil)
        }
    }

    func toggleFullScreen() {
        if let window = NSApp.windows.first {
            window.toggleFullScreen(nil)
        }
    }
    
    func selectFolder() {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.allowsMultipleSelection = false
        panel.prompt = "Choose"

        if panel.runModal() == .OK {
            folderURL = panel.url
            loadImages()
            startTimer()
        }
    }
    

    func loadImages() {
        guard let folderURL = folderURL else { return }

        do {
            let allFiles = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)

            imageURLs = allFiles.filter { $0.pathExtension.lowercased() == "jpg" }
                .sorted(by: { $0.lastPathComponent < $1.lastPathComponent })
        } catch {
            print("Failed to load images: \(error)")
        }
    }

    
    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            if !imageURLs.isEmpty {
                currentIndex = (currentIndex + 1) % imageURLs.count
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func setMenuCooldown() {
        menuRecentlyClosed = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            menuRecentlyClosed = false
        }
    }
    
    
    
}

#Preview {
    ContentView()
}
