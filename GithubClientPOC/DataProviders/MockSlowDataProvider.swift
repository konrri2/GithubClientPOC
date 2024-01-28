//
//  MockSlowDataProvider.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 28/01/2024.
//

import Foundation

/// To test paging returns small batch of data after few seconds
final class MockSlowDataProvider: DataProviderProtocol {
    func getUsersList(byName name: String, page: Int, completion: @escaping (Result<UsersListResponse, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(.success(UsersListResponse.readUserFromJson(forPage: page)))
        }
    }
    
    func getUserDetails(userUrl: String, completion: @escaping (Result<UserDetails, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            completion(.success(UserDetails.readUserFromJson()))
        }
    }
    
    func cancelPreviousListRequest() {
        Log.debug("mock data provider cannot cancel previous request")
    }
}
