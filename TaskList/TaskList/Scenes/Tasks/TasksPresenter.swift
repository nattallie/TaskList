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
    private var router: TasksRoutable
    private let authUseCase: AuthUseCase
    private let fetchTasksUseCase: AllTasksUseCase
    private let saveTasksLocallyUseCase: SaveTasksLocallyUseCase
    private let fetchTasksOfflineUseCase: AllTasksOfflineUseCase
    private var allTasks: [TaskDetails] = []
    private var filteredTasks: [TaskDetails] = []

    // MARK: initializer
    init(
        view: TasksViewable,
        router: TasksRoutable,
        authUseCase: AuthUseCase,
        fetchTasksUseCase: AllTasksUseCase,
        saveTasksLocallyUseCase: SaveTasksLocallyUseCase,
        fetchTasksOfflineUseCase: AllTasksOfflineUseCase
    ) {
        self.view = view
        self.router = router
        self.authUseCase = authUseCase
        self.fetchTasksUseCase = fetchTasksUseCase
        self.saveTasksLocallyUseCase = saveTasksLocallyUseCase
        self.fetchTasksOfflineUseCase = fetchTasksOfflineUseCase
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
    
    public func pullToRefresh() {
        refreshAllTasks()
    }
    
    public func didTapQRButton() {
        router.navigateToQRScanner()
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
                
                populateTasks(tasks: taskEntities)
                syncFetchedTasks()
            } catch {
                if let error = error as? NetworkError, error == .noNetwork {
                    let taskEntities: [TaskEntity] = try fetchTasksOfflineUseCase.fetch()
                    populateTasks(tasks: taskEntities)
                } else {
                    view.endRefreshing()
                }
            }
        }
    }
    
    private func populateTasks(tasks: [TaskEntity]) {
        allTasks = tasks.map { .init(from: $0) }
        filteredTasks = allTasks
        
        view.refreshAllTasks()
        view.clearSearchText()
        view.endRefreshing()
    }
    
    private func syncFetchedTasks() {
        saveTasksLocallyUseCase.sync(parameters: .init(tasks: allTasks))
    }
}
