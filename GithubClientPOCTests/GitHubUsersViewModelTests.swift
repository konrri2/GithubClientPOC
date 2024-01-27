//
//  GitHubUsersViewModelTests.swift
//  GithubClientPOCTests
//
//  Created by Konrad Leszczyński on 27/01/2024.
//

import XCTest
@testable import GithubClientPOC

final class GitHubUsersViewModelTests: XCTestCase {

    @MainActor func testSearchForUsers() {
        let viewModel = GitHubUsersViewModel(dataProvider: MockInstantDataProvider())
        let expectation = XCTestExpectation(description: "Data published")
        let cancellable = viewModel.$users.sink { users in
            if users.count == 2 {
                expectation.fulfill()
            }
        }
        viewModel.searchForUsers(byName: "mock data provider does not care about the name input")
        wait(for: [expectation], timeout: 5.0)
    }

}
