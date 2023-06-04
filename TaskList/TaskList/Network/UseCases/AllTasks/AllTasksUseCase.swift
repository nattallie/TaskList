//
//  AllTasksUseCase.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 04.06.23.
//

import Foundation

// MARK: - All Tasks Use Case
protocol AllTasksUseCase {
    func fetch(parameters: AllTasksParameters) async throws -> [TaskEntity]
}

// MARK: - All Tasks Use Case Implementation
final class AllTasksUseCaseImpl: AllTasksUseCase {
    func fetch(parameters: AllTasksParameters) async throws -> [TaskEntity] {
        let networkRequest: NetworkRequest = .init(
            url: Consts.API.baseURL,
            method: .GET,
            pathParameters: [
                "dev",
                "index.php",
                "v1",
                "tasks",
                "select"
            ],
            headers: [
                "Authorization": "Bearer \(parameters.accessToken)",
                "Content-Type": "application/json"
            ]
        )
        
        do {
            let entity: [TaskEntity] = try await NetworkClient.shared.send(request: networkRequest)
            return entity
        } catch {
            throw error
        }
    }
}
