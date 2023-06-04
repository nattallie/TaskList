//
//  AuthUseCase.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 04.06.23.
//

import Foundation

// MARK: - Auth Use Case
protocol AuthUseCase {
    func auth(parameters: AuthParameters) async throws -> AuthEntity
}

// MARK: - Auth Use Case Implementation
final class AuthUseCaseImpl: AuthUseCase {
    func auth(parameters: AuthParameters) async throws -> AuthEntity {
        let networkRequest: NetworkRequest = .init(
            url: Consts.API.baseURL,
            method: .POST,
            pathParameters: [
                "index.php",
                "login"
            ],
            bodyParameters: [
                "username": parameters.username,
                "password": parameters.password
            ],
            headers: [
                "Authorization": "Basic \(parameters.token)",
                "Content-Type": "application/json"
            ]
        )
        
        do {
            let entity: AuthEntity = try await NetworkClient.shared.send(request: networkRequest)
            return entity
        } catch {
            throw error
        }
    }
}
