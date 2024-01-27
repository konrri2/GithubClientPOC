//
//  User.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 27/01/2024.
//

import Foundation

struct User: Decodable, Identifiable {
    let login: String
    let id: Int
}

// MARK: - mock data for testing and preview
extension User {
    static func readUserFromJson() -> User {
        guard let user = Bundle.main.decode(User.self, from: "User0.json") else {
            fatalError("Project is missing mock")
        }
        
        return user
    }
}
