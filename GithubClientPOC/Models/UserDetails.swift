//
//  UserDetails.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 28/01/2024.
//

import Foundation

struct UserDetails: Decodable {
    let login: String?
    let id: Int?
    let nodeID: String?
    let avatarURL: String?
    let gravatarID: String?
    let url, htmlURL, followersURL: String?
    let followingURL, gistsURL, starredURL: String?
    let subscriptionsURL, organizationsURL, reposURL: String?
    let eventsURL: String?
    let receivedEventsURL: String?
    let type: String?
    let siteAdmin: Bool?
    let name: String
    let company: String?
    let blog: String?
    let location, email: String?
    let hireable: Bool?
    let bio, twitterUsername: String?
    let publicRepos, publicGists, followers, following: Int?
    let privateGists, totalPrivateRepos, ownedPrivateRepos, diskUsage: Int?
    let collaborators: Int?
    let twoFactorAuthentication: Bool?

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
        case name, company
        case blog, location, email, hireable, bio
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
        case privateGists = "private_gists"
        case totalPrivateRepos = "total_private_repos"
        case ownedPrivateRepos = "owned_private_repos"
        case diskUsage = "disk_usage"
        case collaborators
        case twoFactorAuthentication = "two_factor_authentication"
    }
    
    // NOTE: This app is using only some important data, so I left most of the model's field optional
    // If we need all the data, I would provide some placeholders, e.g.:
    //    init(from decoder: Decoder) throws {
    //          ...
    //          company =  (try? values.decodeIfPresent(String.self,    forKey: .company    )) ?? "[No company]"
}

// MARK: - mock data for testing and preview
extension UserDetails {
    static func readUserFromJson(forFile file: String = "UserDetails.json") -> UserDetails {
        guard let user = Bundle.main.decode(UserDetails.self, from: file) else {
            fatalError("Project is missing mock (or badly formatted)")
        }
        
        return user
    }
}
