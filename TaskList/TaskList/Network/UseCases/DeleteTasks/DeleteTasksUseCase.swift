//
//  DeleteTasksUseCase.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 07.06.23.
//

import Foundation
import CoreData

// MARK: - Delete Tasks Use Case
protocol DeleteTasksUseCase {
    func delete() throws
}

// MARK: - Delete Tasks Use Case Implementation
final class DeleteTasksUseCaseImpl: DeleteTasksUseCase {
    private let managedContext = AppDelegate.sharedAppDelegate.coreDataManager.managedContext
    
    func delete() throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
        fetchRequest = NSFetchRequest(entityName: TaskDetailsEntity.entity().name ?? "")

        let deleteRequest = NSBatchDeleteRequest(
            fetchRequest: fetchRequest
        )
        
        deleteRequest.resultType = .resultTypeObjectIDs
        
        do {
            let batchDelete = try managedContext.execute(deleteRequest) as? NSBatchDeleteResult
            
            guard let deleteResult = batchDelete?.result as? [NSManagedObjectID] else { return }
            
            let deletedObjects: [AnyHashable: Any] = [
                NSDeletedObjectsKey: deleteResult
            ]
            
            NSManagedObjectContext.mergeChanges(
                fromRemoteContextSave: deletedObjects,
                into: [managedContext]
            )
        } catch {
            throw error
        }
    }
}
