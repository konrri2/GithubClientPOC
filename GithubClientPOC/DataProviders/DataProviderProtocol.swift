//
//  DataProviderProtocol.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 27/01/2024.
//

import Foundation

protocol DataProviderProtocol {
    func getUsersList(byName name: String, page: Int, completion: @escaping (Result<UsersListResponse, Error>) -> Void)
    func getUserDetails(userUrl: String, completion: @escaping (Result<UserDetails, Error>) -> Void)
    
    /// Stop downloading user list for previous name
    func cancelPreviousListRequest()
}
