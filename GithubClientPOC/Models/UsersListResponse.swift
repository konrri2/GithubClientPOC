//
//  UsersListResponse.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 27/01/2024.
//

import Foundation

struct UsersListResponse: Decodable {
    let items: [User]
    let totalCount: Int
    let incompleteResults: Bool
    
    enum CodingKeys: String, CodingKey {
        case items = "items"
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
    }
}

// MARK: - mock data for testing and previews
extension UsersListResponse {
    static func readUserFromJson() -> UsersListResponse {
        guard let user = Bundle.main.decode(UsersListResponse.self, from: "UsersList_2users.json") else {
            fatalError("Project is missing mock")
        }
        
        return user
    }
}
