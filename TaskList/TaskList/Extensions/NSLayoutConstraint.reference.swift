//
//  NSLayoutConstraint.reference.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 04.06.23.
//

import UIKit

// MARK: - reference
extension NSLayoutConstraint {
    func reference(in property: inout NSLayoutConstraint?) -> NSLayoutConstraint {
        property = self
        return self
    }
}
