//
//  NetworkClient.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 04.06.23.
//

import Foundation

// MARK: - Network Client
final class NetworkClient {
    // MARK: Properties
    static let shared: NetworkClient = .init()
    
    // MARK: Initializer
    private init() {}
    
    // MARK: Network call
    func send<Entity: Decodable>(request: NetworkRequest) async throws -> Entity {
        let urlRequest: URLRequest = try createURLRequestFrom(request)

        let (data, response): (Data, URLResponse) = try await URLSession.shared.data(for: urlRequest)
        guard
            let httpResponse: HTTPURLResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {
            throw NetworkError.invalidResponse
        }

        do {
            let entity: Entity = try JSONDecoder().decode(Entity.self, from: data)
            return entity
        } catch {
            throw NetworkError.invalidData
        }
    }
    
    // MARK: URL Request builder
    private func createURLRequestFrom(_ networkRequest: NetworkRequest) throws -> URLRequest {
        var endpoint: String = networkRequest.url
        networkRequest.pathParameters.forEach { endpoint.append("/\($0)") }
        
        guard var urlComponents: URLComponents = .init(string: endpoint) else {
            throw NetworkError.invalidEndpoint
        }
        
        urlComponents.queryItems = networkRequest.queryParameters.map { .init(name: $0, value: $1) }
        
        guard let url: URL = urlComponents.url else {
            throw NetworkError.invalidURL
        }

        var urlRequest: URLRequest = .init(url: url)
        urlRequest.httpMethod = networkRequest.method.rawValue
        
        if networkRequest.method == .POST && !networkRequest.bodyParameters.isEmpty {
            do {
                let data = try JSONSerialization.data(withJSONObject: networkRequest.bodyParameters)
                urlRequest.httpBody = data
            } catch {
                throw NetworkError.invalidBodyParameter
            }
        }
        
        networkRequest.headers.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
}
