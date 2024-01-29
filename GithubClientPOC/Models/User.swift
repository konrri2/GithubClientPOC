//
//  User.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 27/01/2024.
//

import Foundation

/// User info from list
struct User: Decodable, Identifiable, Hashable {
    let login: String
    let id: Int
    let nodeID: String?
    let avatarURL: String
    let gravatarID: String?
    let url: String
    let htmlURL, followersURL: String?
    let followingURL, gistsURL, starredURL: String?
    let subscriptionsURL, organizationsURL, reposURL: String?
    let eventsURL: String?
    let receivedEventsURL: String?
    let type: String?
    let siteAdmin: Bool?
    let score: Int?

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        case score
    }
}

// MARK: - mock data for testing and preview
extension User {
    static func readUserFromJson() -> User {
        guard let user = Bundle.main.decode(User.self, from: "User0.json") else {
            fatalError("Project is missing mock (or badly formatted)")
        }
        
        return user
    }
}
