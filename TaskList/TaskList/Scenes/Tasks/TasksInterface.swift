//
//  TasksInterface.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 04.06.23.
//

import Foundation

// MARK: - Tasks Viewable
public protocol TasksViewable: AnyObject {
    func refreshAllTasks()
}

// MARK: - Tasks Presentable
public protocol TasksPresentable {
    var numberOfTasks: Int { get }
    func viewDidLoad()

    func configure(_ cell: CellViewModel, at row: Int)
}
