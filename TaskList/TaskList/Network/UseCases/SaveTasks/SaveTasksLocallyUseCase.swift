//
//  SaveTasksLocallyUseCase.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 05.06.23.
//

import Foundation

// MARK: - Save Tasks Locally Use Case
protocol SaveTasksLocallyUseCase {
    func sync(parameters: SaveTasksLocallyParameters)
}

// MARK: - Save Tasks Locally Use Case Implementation
final class SaveTasksLocallyUseCaseImpl: SaveTasksLocallyUseCase {
    private let managedContext = AppDelegate.sharedAppDelegate.coreDataManager.managedContext
    
    func sync(parameters: SaveTasksLocallyParameters) {
        parameters.tasks.forEach { task in
            let newTask = TaskDetailsEntity(context: managedContext)
            newTask.setValue(task.task, forKey: #keyPath(TaskDetailsEntity.task))
            newTask.setValue(task.title, forKey: #keyPath(TaskDetailsEntity.title))
            newTask.setValue(task.description, forKey: #keyPath(TaskDetailsEntity.taskDescription))
            newTask.setValue(task.colorCode, forKey: #keyPath(TaskDetailsEntity.colorCode))
        }
        AppDelegate.sharedAppDelegate.coreDataManager.saveContext()
    }
}
