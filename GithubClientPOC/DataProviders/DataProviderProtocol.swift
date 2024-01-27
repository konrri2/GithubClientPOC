//
//  DataProviderProtocol.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 27/01/2024.
//

import Foundation

protocol DataProviderProtocol {
    func searchForUsers(byName name: String)
}
