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
    private var filteredTasks: [TaskDetails] = []

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
        return filteredTasks.count
    }
    
    public func viewDidLoad() {
        refreshAllTasks()
    }
    
    public func configure(_ cell: CellViewModel, at row: Int) {
        cell.configure(with: filteredTasks[row])
    }
    
    public func searchTextDidChange(_ text: String) {
        filteredTasks = allTasks.filter {
            $0.task.contains(text) ||
            $0.title.contains(text) ||
            $0.description.contains(text)
        }
        view.refreshAllTasks()
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
                self.filteredTasks = self.allTasks
                
                view.refreshAllTasks()
                view.clearSearchText()
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
