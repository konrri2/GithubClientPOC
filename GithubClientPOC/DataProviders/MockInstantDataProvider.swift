//
//  MockInstantDataProvider.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 27/01/2024.
//

import Foundation

/// For unit test and previous
final class MockInstantDataProvider: DataProviderProtocol {
    func getUsers(byName name: String, page: Int, completion: @escaping (Result<UsersListResponse, Error>) -> Void) {
        if page == 1 {
            completion(.success(UsersListResponse.readUserFromJson()))
        } else {
            let empty = UsersListResponse(items: [], totalCount: 0, incompleteResults: false)
            completion(.success(empty))
        }
    }
    
    func cancelPreviousRequest() {
        Log.debug("mock data provider cannot cancel previous request")
    }
}
