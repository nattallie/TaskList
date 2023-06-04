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
    
    // MARK: initializer
    init(
        view: TasksViewable,
        authUseCase: AuthUseCase
    ) {
        self.view = view
        self.authUseCase = authUseCase
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
        }
    }
}
