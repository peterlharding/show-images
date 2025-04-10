//
//  ShowImagesApp.swift
//  ShowImages
//
//  Created by plh on 2025-04-10.
//

import SwiftUI

@main
struct ShowImagesApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .edgesIgnoringSafeArea(.all)
        }
        .windowStyle(.hiddenTitleBar) // Optional: for full screen feel
    }
}


class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Delay to allow SwiftUI window to initialize
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let window = NSApp.windows.first {
                self.window = window
                window.toggleFullScreen(nil)
            }
        }
    }
}
