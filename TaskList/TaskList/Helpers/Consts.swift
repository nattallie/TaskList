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
    struct API {
        static let baseURL: String = "https://api.baubuddy.de"
        static let authToken: String = "QVBJX0V4cGxvcmVyOjEyMzQ1NmlzQUxhbWVQYXNz"
        static let constUsername: String = "365"
        static let constPassword: String = "1"
    }
    
    // MARK: - Common
    struct Common {
        static let OK: String = "OK"
    }
    
    // MARK: - Core Data
    struct CoreData {
        static let tasksEntityName: String = "Tasks"
    }
    
    // MARK: - Network
    struct Network {
        static let networkError: String = "Network error"
        static let invalidEndpoint: String = "Error is caused because of invalid endpoint"
        static let invalidURL: String = "Error is caused because of invalid URL"
        static let invalidBodyParameter: String = "Error is caused because of body parameters"
        static let invalidResponse: String = "Error is caused because of invalid network response"
        static let invalidData: String = "Error is caused because of invalid data"
        static let noNetwork: String = "Not connected to Network or network connection lost"
    }
    
    // MARK: - Scenes
    struct Scenes {
        // MARK: Tasks
        struct Tasks {
            static let title: String = "Task List"
            static let pullToRefresh: String = "Pull to refresh"
        }
        
        // MARK: QR Scanner
        struct QRScanner {
            static let qrScanSuccess: String = "Message detected"
            static let qrScanSuccessMessage: String = "QR captured successfully. Detected message: "
        }
    }
}
