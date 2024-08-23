//
//  NavigationControllerModifier.swift
//  EatCook
//
//  Created by 강신규 on 8/23/24.
//

import Foundation
import SwiftUI

class SwipeState {
    static let shared = SwipeState()
    var swipeEnabled = false
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if SwipeState.shared.swipeEnabled {
            return viewControllers.count > 1
        }
        return false
    }
    
}
