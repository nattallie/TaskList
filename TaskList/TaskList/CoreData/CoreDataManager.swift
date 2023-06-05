//
//  CoreDataManager.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 05.06.23.
//

import CoreData

// MARK: - Core Data Manager
final class CoreDataManager {
    // MARK: Properties
    lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext

    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Error occured while loading persistent stores \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private let modelName: String

    // MARK: Initializer
    init(modelName: String) {
        self.modelName = modelName
    }

    func saveContext() {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error occured whle saving managed context \(error), \(error.userInfo)")
        }
    }
}
