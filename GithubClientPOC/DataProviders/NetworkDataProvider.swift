//
//  NetworkDataProvider.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 28/01/2024.
//

import Foundation
import Alamofire

final class NetworkDataProvider: DataProviderProtocol {
    private var currentListRequest: Alamofire.DataRequest?
    
    /// NOTE: The `SecretSettings.swift` file with `globalApiToken` is not pushed to repo
    /// Please provide github api token
    /// I've hardcoded token to safe time.
    /// In production app I would use arkana https://github.com/rogerluan/arkana
    private let headers: HTTPHeaders = [
        "Access": "application/json",
        "Authorization": "Bearer \(globalApiToken)"
    ]
    
    func getUsersList(byName name: String, page: Int, completion: @escaping (Result<UsersListResponse, Error>) -> Void) {
        let parameters: Parameters = [
            "page": page,
            "q": name
        ]
        
        let url = "https://api.github.com/search/users"
        
        currentListRequest = AF.request(url, method: .get, parameters: parameters, headers: headers)
        currentListRequest?.responseDecodable(of: UsersListResponse.self) { response in
            // NOTE: use custom errors messages prepared by UI/UX designer
            completion(response.result.mapError { $0 as Error })
        }
    }
    
    func getUserDetails(userUrl: String, completion: @escaping (Result<UserDetails, Error>) -> Void) {
        Log.debug("===== getUserDetails(userUrl \(userUrl)")
        AF.request(userUrl, method: .get, headers: headers)
            .responseDecodable(of: UserDetails.self) { response in
                // NOTE: use custom errors messages prepared by UI/UX designer
                completion(response.result.mapError { $0 as Error })
            }
    }
    
    /// We don't want to mix results from current and previous response, if the user type fast and/or the network is slow
    func cancelPreviousListRequest() {
        currentListRequest?.cancel()
    }
}
