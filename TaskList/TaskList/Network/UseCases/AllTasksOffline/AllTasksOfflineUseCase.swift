//
//  AllTasksOfflineUseCase.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 05.06.23.
//

import Foundation
import CoreData

// MARK: - All Tasks Offline Use Case
protocol AllTasksOfflineUseCase {
    func fetch() throws -> [TaskEntity]
}

// MARK: - All Tasks Offline Use Case Implementation
final class AllTasksOfflineUseCaseImpl: AllTasksOfflineUseCase {
    private let managedContext = AppDelegate.sharedAppDelegate.coreDataManager.managedContext
    
    func fetch() throws -> [TaskEntity] {
        let tasksFetchRequest: NSFetchRequest<TaskDetailsEntity> = TaskDetailsEntity.fetchRequest()
        tasksFetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(TaskDetailsEntity.task), ascending: true)]
        
        do {
            let results = try managedContext.fetch(tasksFetchRequest)
            return results.map { .init(from: $0) }
        } catch {
            throw error
        }
    }
}
