//
//  TaskTableViewCellUIModel.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 05.06.23.
//

import UIKit

// MARK: - Task Table View Cell UI Model
public struct TaskTableViewCellUIModel {
    // MARK: initializers
    private init() {}
    
    // MARK: Layout
    struct Layout {
        static let margin: CGFloat = 16
        static let spacing: CGFloat = 6
        static let cornerRadius: CGFloat = 24
        static let descriptionMinHeight: CGFloat = 28
    }
    
    // MARK: Color
    struct Color {
        static let background: UIColor = .white
        static let primary: UIColor = .systemBlue
        static var text: UIColor = .black
        static var border: UIColor = .lightGray
    }
    
    // MARK: Font
    struct Font {
        static let task: UIFont = .boldSystemFont(ofSize: 16)
        static let title: UIFont = .boldSystemFont(ofSize: 16)
        static let description: UIFont = .italicSystemFont(ofSize: 14)
    }
}
