//
//  UIApplication.rootWindow.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 04.06.23.
//

import UIKit

// MARK: - Root Window
public extension UIApplication {
    var rootWindow: UIWindow? {
        return connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .compactMap { $0.keyWindow }
            .first
    }
}
