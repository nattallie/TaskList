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
    
    private var isFirstFetch: Bool = true

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
        if text.isEmpty {
            filteredTasks = allTasks
        } else {
            let lowerCasedText = text.lowercased()
            filteredTasks = allTasks.filter {
                $0.task.lowercased().contains(lowerCasedText) ||
                $0.title.lowercased().contains(lowerCasedText) ||
                $0.description.lowercased().contains(lowerCasedText)
            }            
        }
        view.refreshAllTasks()
    }
    
    public func pullToRefresh() {
        refreshAllTasks()
    }
    
    public func didTapQRButton() {
        router.navigateToQRScanner(capturedTextSaverCall: didCaptureQRMessage(message:))
    }
    
    public func didCaptureQRMessage(message: String) {
        view.setSearchText(message)
        searchTextDidChange(message)
    }
    
    public func didTapAlertActionOK() {
        do {
            let taskEntities: [TaskEntity] = try fetchTasksOfflineUseCase.fetch()
            populateTasks(tasks: taskEntities)
        } catch {
            print("Error occured while fetching tasks offline \(error)")
        }
    }
    
    // MARK: private helpers
    private func refreshAllTasks() {
        Task.init {
            if isFirstFetch {
                view.startLoading()
            }
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
                if isFirstFetch {
                    view.stopLoading()
                    isFirstFetch = false
                }
                if let error = error as? NetworkError, error == .noNetwork {
                    view.showAlertMessage(title: Consts.Scenes.Tasks.noNetwork, message: Consts.Scenes.Tasks.noNetworkMessage)
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
        view.setSearchText("")
        if isFirstFetch {
            view.stopLoading()
            isFirstFetch = false
        }
        view.endRefreshing()
    }
    
    private func syncFetchedTasks() {
        saveTasksLocallyUseCase.sync(parameters: .init(tasks: allTasks))
    }
}
