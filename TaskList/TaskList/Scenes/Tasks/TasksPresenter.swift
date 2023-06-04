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
    private let authUseCase: AuthUseCase
    private let fetchTasksUseCase: AllTasksUseCase
    private var allTasks: [TaskDetails] = []

    // MARK: initializer
    init(
        view: TasksViewable,
        authUseCase: AuthUseCase,
        fetchTasksUseCase: AllTasksUseCase
    ) {
        self.view = view
        self.authUseCase = authUseCase
        self.fetchTasksUseCase = fetchTasksUseCase
    }
    
    // MARK: Task Presentable
    public var numberOfTasks: Int {
        return allTasks.count
    }
    
    public func viewDidLoad() {
        refreshAllTasks()
    }
    
    public func configure(_ cell: CellViewModel, at row: Int) {
        cell.configure(with: allTasks[row])
    }
    
    // MARK: private helpers
    private func refreshAllTasks() {
        Task.init {
            do {
                let authEntity = try await authUseCase.auth(
                    parameters: .init(
                        username: Consts.API.constUsername,
                        password: Consts.API.constPassword,
                        token: Consts.API.authToken
                    )
                )
                
                let taskEntities: [TaskEntity] = try await fetchTasksUseCase.fetch(
                    parameters: .init(accessToken: authEntity.oauth.accessToken)
                )
                
                self.allTasks = taskEntities.map { .init(from: $0) }
                
                view.refreshAllTasks()
                syncFetchedTasks()
            } catch {
                // handle no network case
            }
        }
    }
    
    private func syncFetchedTasks() {
        // handle core data saving
    }
}
