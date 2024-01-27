//
//  GitHubUsersViewModel.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 27/01/2024.
//

import Foundation

// TODO: paging with loading indicator
enum LoadingState: Equatable {
    case notStarted
    case waitAndReady
    case isLoading
    case requestedNextPageLoadingButWasBusy /// this will happen if the user scrolls very fast - faster than the data is being loaded
    case finishedAll
    case error(message: String)
}

@MainActor
final class GitHubUsersViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var selectedUser: User?
    @Published var loadingState: LoadingState = .notStarted
    
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
