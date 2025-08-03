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
                SplashScreenPage(showSplash: $showSplash)
            } else {
                HomePage()
            }
        }
    }
}

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = self
    }

    // Allows swipe back gesture after hiding standard navigation bar with .navigationBarHidden(true).
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    viewControllers.count > 1
    }

    // Allows interactivePopGestureRecognizer to work simultaneously with other gestures.
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    viewControllers.count > 1
    }

    // Blocks other gestures when interactivePopGestureRecognizer begins (my TabView scrolled together with screen swiping back)
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    viewControllers.count > 1
    }
}
