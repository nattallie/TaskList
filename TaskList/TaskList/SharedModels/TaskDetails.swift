//
//  TaskDetails.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 04.06.23.
//

import Foundation

// MARK: Task Details
struct TaskDetails: CellModel {
    let cellIdentifier: String = TaskTableViewCell.cellIdentifier
    let task: String
    let title: String
    let description: String
    let colorCode: String
    
    init(from entity: TaskEntity) {
        self.task = entity.task
        self.title = entity.title
        self.description = entity.description
        self.colorCode = entity.colorCode
    }
}
