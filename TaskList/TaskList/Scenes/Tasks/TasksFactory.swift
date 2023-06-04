//
//  TasksFactory.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 04.06.23.
//

import UIKit

// MARK: - Tasks Factory
public struct TasksFactory {
    // MARK: Initializers
    private init() {}
    
    // MARK: Factory
    public static func create() -> UIViewController {
        let viewController: TasksViewController = .init()
        
        let presenter: TasksPresenter = .init(
            view: viewController,
            authUseCase: AuthUseCaseImpl(),
            fetchTasksUseCase: AllTasksUseCaseImpl()
        )
        
        viewController.presenter = presenter
        
        return viewController
    }
}
