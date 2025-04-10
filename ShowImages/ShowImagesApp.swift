//
//  ShowImagesApp.swift
//  ShowImages
//
//  Created by plh on 2025-04-10.
//

import SwiftUI

@main
struct ShowImagesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .edgesIgnoringSafeArea(.all)
        }
        .windowStyle(.hiddenTitleBar) // Optional: for full screen feel
    }
}
