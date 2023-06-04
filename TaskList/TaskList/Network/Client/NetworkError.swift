//
//  NetworkError.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 04.06.23.
//

import Foundation

// MARK: - Network Error
enum NetworkError: LocalizedError {
    case invalidEndpoint
    case invalidURL
    case invalidBodyParameter
    case invalidResponse
    case invalidData
    
    var localizedDescription: String {
        switch self {
        case .invalidEndpoint:
            return Consts.Network.invalidEndpoint
        case .invalidURL:
            return Consts.Network.invalidURL
        case .invalidBodyParameter:
            return Consts.Network.invalidBodyParameter
        case .invalidResponse:
            return Consts.Network.invalidResponse
        case .invalidData:
            return Consts.Network.invalidData
        }
    }
}
