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
    private let dataProvider: DataProviderProtocol
    private var userNameToSearch: String = ""

    /// For api pagination
    private var pageNumber: Int = 0

    @Published var users: [User] = []
    @Published var selectedUser: User?
    @Published var loadingState: LoadingState = .notStarted {
        didSet {
            if oldValue == .requestedNextPageLoadingButWasBusy && loadingState == .waitAndReady {
                Log.debug("===Loading state changed to \(loadingState)")
                loadPageOfUsers()
            }
        }
    }
    
    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    func searchForUsers(byName name: String) {
        dataProvider.cancelPreviousRequest()
        users = []
        Log.debug("Searching for \(name)")
        userNameToSearch = name
        pageNumber = 0
        loadingState = .waitAndReady
    }
    
    internal func loadNextPageOfUsers() {
        guard loadingState == .waitAndReady else {
            loadingState = .requestedNextPageLoadingButWasBusy
            return
        }
        Log.debug("loadNextPageOfUsers called with \(loadingState) curentPage: \(pageNumber)")
        pageNumber += 1
        loadPageOfUsers()
    }
    
    /// Makes a request for users (only one page) and adds them to the list
    private func loadPageOfUsers() {
        loadingState = .isLoading
        Log.debug("Loading page \(pageNumber) ")
        dataProvider.getUsers(byName: self.userNameToSearch, page: self.pageNumber) { [weak self] result in
            switch result {
            case .success(let resp):
                Log.debug("Got \(resp.items.count) users")
                self?.users.append(contentsOf: resp.items)
                self?.loadingState = (resp.items.count == 0) ? .finishedAll : .waitAndReady
                
            case .failure(let error):
                Log.error("Cannot load users \(error.localizedDescription)")
                // NOTE: use custom errors messages prepared by UI/UX designer
                self?.loadingState = .error(message: error.localizedDescription)
                self?.users = []
            }
        }
    }
    
}
