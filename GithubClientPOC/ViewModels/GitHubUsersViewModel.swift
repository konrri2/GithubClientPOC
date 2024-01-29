//
//  GitHubUsersViewModel.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 27/01/2024.
//

import Foundation
import Combine

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
    private let reachabilityHelper = NetworkReachabilityHelper()
    private var cancellables = Set<AnyCancellable>()
    
    /// For api pagination
    private var pageNumber: Int = 0

    /// NOTE: The code architecture would be cleaner if only DataProvider check reachability before each call
    /// However user experience is better with error message dynamically shown depending on network status
    /// In my experience bosses usually choose pretty UI/UX over pretty code ;-)
    @Published var isNetworkReachable: Bool = false
    @Published var users: [User] = []
    @Published var selectedUser: User? {
        didSet {
            if selectedUser != oldValue {
                loadUserDetails()
            }
        }
    }
    
    @Published var selectedUserDetails: UserDetails?
    @Published var detailsLoadingErrorMessage: String?
    
    @Published var loadingState: LoadingState = .notStarted {
        didSet {
            if oldValue == .requestedNextPageLoadingButWasBusy && loadingState == .waitAndReady {
                loadPageOfUsers()
            }
        }
    }
    
    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
        
        setupReachabilityBinding()
    }
    
    func initialSetup() {
        dataProvider.cancelPreviousListRequest()
        users = []
        pageNumber = 0
        loadingState = .waitAndReady
    }
    
    func searchForUsers(byName name: String) {
        dataProvider.cancelPreviousListRequest()
        users = []
        userNameToSearch = name
        pageNumber = 0
        loadingState = .waitAndReady
    }
    
    func loadNextPageOfUsers() {
        guard loadingState == .waitAndReady else {
            loadingState = .requestedNextPageLoadingButWasBusy
            return
        }
        pageNumber += 1
        loadPageOfUsers()
    }
    
    /// Makes a request for users (only one page) and adds them to the list
    private func loadPageOfUsers() {
        loadingState = .isLoading
        dataProvider.getUsersList(byName: self.userNameToSearch, page: self.pageNumber) { [weak self] result in
            switch result {
            case .success(let resp):
                self?.users.append(contentsOf: resp.items)
                self?.loadingState = (resp.items.count == 0) ? .finishedAll : .waitAndReady
                
            case .failure(let error):
                // NOTE: use custom errors messages prepared by UI/UX designer
                self?.loadingState = .error(message: error.localizedDescription)
                self?.users = []
            }
        }
    }
    
    private func loadUserDetails() {
        selectedUserDetails = nil
        if let user = selectedUser {
            dataProvider.getUserDetails(userUrl: user.url) { [weak self] result in
                switch result {
                case .success(let resp):
                    self?.detailsLoadingErrorMessage = nil
                    self?.selectedUserDetails = resp
                case .failure(let error):
                    Log.error("Cannot load user details \(error.localizedDescription)")
                    // NOTE: use custom errors messages prepared by UI/UX designer
                    self?.detailsLoadingErrorMessage = error.localizedDescription
                }
            }
        }
    }
    
    private func setupReachabilityBinding() {
        reachabilityHelper.networkStatus
            .removeDuplicates()
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] value in
                self?.isNetworkReachable = self?.reachabilityHelper.isReachable ?? false
            })
            .store(in: &cancellables)
        
        isNetworkReachable = reachabilityHelper.isReachable ?? false
    }
}
