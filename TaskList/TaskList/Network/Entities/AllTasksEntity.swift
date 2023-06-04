//
//  AllTasksEntity.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 04.06.23.
//

import Foundation

// MARK: - Task Entity
struct TaskEntity: Codable {
    let task: String
    let title: String
    let description: String
    let colorCode: String
}
