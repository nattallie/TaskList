//
//  QRScannerUIModel.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 06.06.23.
//

import UIKit

// MARK: - QR Scanner UI Model
struct QRScannerUIModel {
    // MARK: initializers
    private init() {}
    
    // MARK: Layout
    struct Layout {
        static let QRFrameBorderWidth: CGFloat = 5
        static let spacingVer: CGFloat = 10
        static let spacingHor: CGFloat = 20
    }
    
    // MARK: Color
    struct Color {
        static let QRFrameBorder: UIColor = .green
    }
}
