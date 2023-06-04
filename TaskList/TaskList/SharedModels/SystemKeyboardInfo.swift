//
//  SystemKeyboardInfo.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 05.06.23.
//

import UIKit

// MARK: - System Keyboard Info
struct SystemKeyboardInfo {
    // MARK: Properties
    var frame: CGRect
    var animationDuration: TimeInterval
    var animationOptions: UIView.AnimationOptions
    
    // MARK: Initializer
    init(notification: Notification) {
        self.frame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
        
        self.animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        
        self.animationOptions = .init(
            rawValue: (notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue ?? 0
        )
    }
}
