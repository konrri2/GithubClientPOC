//
//  DataProviderProtocol.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 27/01/2024.
//

import Foundation

protocol DataProviderProtocol {
    func getUsers(byName name: String, page: Int, completion: @escaping (Result<UsersListResponse, Error>) -> Void)
    
    /// Stop downloading user list for previous name
    func cancelPreviousRequest()
}
