//
//  AppDelegate.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 04.06.23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var coreDataManager: CoreDataManager = .init(modelName: Consts.CoreData.tasksEntityName)

    static let sharedAppDelegate: AppDelegate = {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Error occured while getting delegate \(String(describing: UIApplication.shared.delegate))")
        }
        return delegate
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}

