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
    public func viewDidLoad() {
        refreshAllTasks()
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
                
                let allTasks = try await fetchTasksUseCase.fetch(
                    parameters: .init(accessToken: authEntity.oauth.accessToken)
                )
                
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
