//
//  NetworkReachabilityHelper.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 28/01/2024.
//

import Alamofire
import Combine

final class NetworkReachabilityHelper {
    
    private enum Constants {
       static let host = "github.com"
    }
    
    private var reachability = NetworkReachabilityManager(host: Constants.host)
    let networkStatus = PassthroughSubject<NetworkReachabilityManager.NetworkReachabilityStatus, Error>()
    
    init() {
        reachability?.startListening { [weak self] status in
            self?.networkStatus.send(status)
        }
    }
    
    deinit {
        reachability?.stopListening()
    }
    
    var isReachable: Bool? {
        get {
            return reachability?.isReachable
        }
    }
}
