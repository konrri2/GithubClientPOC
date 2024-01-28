//
//  NetworkDataProvider.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 28/01/2024.
//

import Foundation
import Alamofire

final class NetworkDataProvider: DataProviderProtocol {
    private var currentRequest: Alamofire.DataRequest?
    
    /// NOTE: hardcoded token to safe time.
    /// In production app I would use arkana https://github.com/rogerluan/arkana
    private let headers: HTTPHeaders = [
        "Access": "application/json",
        "Authorization": "Bearer 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"
    ]
    
    func getUsersList(byName name: String, page: Int, completion: @escaping (Result<UsersListResponse, Error>) -> Void) {
        currentRequest?.cancel()

        let parameters: Parameters = [
            "page": page,
            "q": name
            ]
        
        let url = "https://api.github.com/search/users"
        
        currentRequest = AF.request(url, method: .get, parameters: parameters, headers: headers)
        currentRequest?.responseDecodable(of: UsersListResponse.self) { response in
            // NOTE: use custom errors messages prepared by UI/UX designer
            completion(response.result.mapError { $0 as Error })
        }
    }
    
    func cancelPreviousListRequest() {
        Log.debug("network data provider cannot cancel previous request")
    }
}
