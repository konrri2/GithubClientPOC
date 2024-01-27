//
//  GitHubUsersViewModel.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 27/01/2024.
//

import Foundation

@MainActor
final class GitHubUsersViewModel: ObservableObject {
    @Published var users: [User] = []
    
    private let dataProvider: DataProviderProtocol
    
    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    func searchForUsers(byName name: String) {
        dataProvider.searchForUsers(byName: name) { result in
            switch result {
            case .success(let response):
                self.users = response.items
            case .failure(let error):
                Log.error(error.localizedDescription)
            }
        }
    }
}
