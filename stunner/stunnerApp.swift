//
//  stunnerApp.swift
//  stunner
//
//  Created by Garvit Kaushik on 29/07/25.
//

import SwiftUI

@main
struct stunnerApp: App {
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashScreen(showSplash: $showSplash)
            } else {
                HomePage()
            }
        }
    }
}

