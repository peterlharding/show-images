//
//  Extensions.swift
//  ShowImages
//
//  Created by plh on 2025-04-10.
//

import SwiftUI

extension View {
    func gestureControls(showMenu: Binding<Bool>) -> some View {
        self.modifier(GestureControlsModifier(showMenu: showMenu))
    }
}

