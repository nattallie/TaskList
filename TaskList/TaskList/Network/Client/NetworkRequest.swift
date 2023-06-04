//
//  NetworkRequest.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 04.06.23.
//

import Foundation

// MARK: - Network Request
struct NetworkRequest {
    var url: String
    var method: NetworkRequestMethod
    var pathParameters: [String] = []
    var queryParameters: [String: String] = [:]
    var bodyParameters: [String: Any] = [:]
    var headers: [String: String] = [:]
}
