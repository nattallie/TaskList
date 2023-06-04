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
        Task.init {
            let entity = try await authUseCase.auth(
                parameters: .init(
                    username: "365",
                    password: "1",
                    token: Consts.API.authToken
                )
            )
            
            let tasksEntity = try await fetchTasksUseCase.fetch(parameters: .init(accessToken: entity.oauth.accessToken))
        }
    }
}
