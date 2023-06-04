//
//  TasksPresenter.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 04.06.23.
//

import Foundation

// MARK: - Tasks Presenter
public class TasksPresenter: TasksPresentable {
    // MARK: Properties
    
    private unowned let view: TasksViewable
    
    // MARK: initializer
    init(view: TasksViewable) {
        self.view = view
    }
}
