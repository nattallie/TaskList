//
//  TaskEntity.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 04.06.23.
//

import Foundation

// MARK: - Task Entity
public struct TaskEntity: Codable {
    let task: String
    let title: String
    let description: String
    let colorCode: String
    
    public init(from entity: TaskDetailsEntity) {
        self.task = entity.task ?? ""
        self.title = entity.title ?? ""
        self.description = entity.taskDescription ?? ""
        self.colorCode = entity.colorCode ?? ""
    }
}
