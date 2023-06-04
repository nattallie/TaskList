//
//  TasksInterface.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 04.06.23.
//

import Foundation

// MARK: - Tasks Viewable
public protocol TasksViewable: AnyObject {}

// MARK: - Tasks Presentable
public protocol TasksPresentable {
    func viewDidLoad()
}
