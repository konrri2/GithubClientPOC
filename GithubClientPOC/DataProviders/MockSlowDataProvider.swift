//
//  MockSlowDataProvider.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 28/01/2024.
//

import Foundation

/// To test paging returns small batch of data after few seconds
final class MockSlowDataProvider: DataProviderProtocol {
    func getUsers(byName name: String, page: Int, completion: @escaping (Result<UsersListResponse, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            completion(.success(UsersListResponse.readUserFromJson(forPage: page)))
        }
    }
    
    func cancelPreviousRequest() {
        Log.debug("mock data provider cannot cancel previous request")
    }
}
