//
//  MockInstantDataProvider.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 27/01/2024.
//

import Foundation

final class MockInstantDataProvider: DataProviderProtocol {
    func searchForUsers(byName name: String, completion: @escaping (Result<UsersListResponse, Error>) -> Void) {
        completion(.success(UsersListResponse.readUserFromJson()))
    }
}
