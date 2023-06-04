//
//  Consts.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 04.06.23.
//

import Foundation

// MARK: - Consts
struct Consts {
    // MARK: - API
    struct API {}
    
    // MARK: - Common
    struct Common {}
    
    // MARK: - Network
    struct Network {
        static let networkError: String = "Network error"
        static let invalidEndpoint: String = "Error is caused because of invalid endpoint"
        static let invalidURL: String = "Error is caused because of invalid URL"
        static let invalidBodyParameter: String = "Error is caused because of body parameters"
        static let invalidResponse: String = "Error is caused because of invalid network response"
        static let invalidData: String = "Error is caused because of invalid data"
    }
    
    // MARK: - Scenes
    struct Scenes {
        // MARK: Tasks
        struct Tasks {}
    }
}
