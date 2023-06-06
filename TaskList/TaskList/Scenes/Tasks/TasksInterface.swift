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
    func clearSearchText()
    func endRefreshing()
}

// MARK: - Tasks Presentable
public protocol TasksPresentable {
    var numberOfTasks: Int { get }
    func viewDidLoad()

    func configure(_ cell: CellViewModel, at row: Int)
    func searchTextDidChange(_ text: String)
    func pullToRefresh()
    func didTapQRButton()
}

// MARK: - Tasks Routable
public protocol TasksRoutable {
    func navigateToQRScanner()
}
