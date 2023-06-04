//
//  TasksUIModel.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 04.06.23.
//

import UIKit

// MARK: - Tasks UI Model
public struct TasksUIModel {
    // MARK: initializers
    private init() {}
    
    // MARK: Layout
    struct Layout {
        static let horizontalMargin: CGFloat = 12
        static let spacing: CGFloat = 8
    }
    
    // MARK: Color
    struct Color {
        static let background: UIColor = .white
        static let primary: UIColor = .black
        static var title: UIColor { primary }
    }
    
    // MARK: Font
    struct Font {
        static let title: UIFont = .boldSystemFont(ofSize: 24)
    }
}
