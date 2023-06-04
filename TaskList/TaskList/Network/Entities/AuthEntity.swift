//
//  AuthEntity.swift
//  TaskList
//
//  Created by Nata Khurtsidze on 04.06.23.
//

import Foundation

// MARK: - Auth Entity
public struct AuthEntity: Codable {
    let oauth: OAuth
    
    // MARK: OAuth
    struct OAuth: Codable {
        let accessToken: String
        
        enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
        }
    }
}
