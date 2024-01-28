//
//  GitHubUsersViewModelTests.swift
//  GithubClientPOCTests
//
//  Created by Konrad Leszczyński on 27/01/2024.
//

import XCTest
@testable import GithubClientPOC

final class GitHubUsersViewModelTests: XCTestCase {

    @MainActor func testInitialState() {
        let viewModel = GitHubUsersViewModel(dataProvider: MockSlowDataProvider())
        XCTAssertEqual(viewModel.users.count, 0)
        
        let expectation0 = XCTestExpectation(description: "ViewModel setup")
        
        let cancelable = viewModel.$users.sink { users in
            print("===Got \(users.count) users")
            if users.count == 0 {
                expectation0.fulfill()
            }
        }
        viewModel.searchForUsers(byName: "mock data provider does not care about the name input")
        wait(for: [expectation0], timeout: 7.0)

    }
    
    /// Simulates user scrolling and data is slowly loading  page by page
    @MainActor func testLoadNextPage() {
        /// ViewModel is using test data from static json files
        let viewModel = GitHubUsersViewModel(dataProvider: MockSlowDataProvider())
        XCTAssertEqual(viewModel.users.count, 0)
        
        let expectation0 = XCTestExpectation(description: "ViewModel setup")
        let expectation1 = XCTestExpectation(description: "ViewModel load first page")
        let expectation2 = XCTestExpectation(description: "ViewModel load second page")
        let expectation3 = XCTestExpectation(description: "ViewModel load third page")
        
        let cancelable = viewModel.$users.sink { users in
            if users.count == 0 {
                expectation0.fulfill()
            } else if users.count == 10 {
                expectation1.fulfill()
            }
        }
        viewModel.searchForUsers(byName: "mock data provider does not care about the name input")
        viewModel.loadNextPageOfUsers()
        wait(for: [expectation0, expectation1], timeout: 10.0)
        XCTAssertEqual(viewModel.users.first?.login, "ingenious")
        XCTAssertEqual(viewModel.users.last?.login, "nos1609") // last user on the first page
        
        let cancelable2 = viewModel.$users.sink { users in
            if users.count == 20 {
                expectation2.fulfill()
            }
        }
        viewModel.loadNextPageOfUsers()
        wait(for: [expectation2], timeout: 10.0)        
        XCTAssertEqual(viewModel.users.first?.login, "ingenious") // first user cannot be moved when new page is loaded
        XCTAssertEqual(viewModel.users.last?.login, "harshjk") // last user on the second page
        
        let cancelable3 = viewModel.$users.sink { users in
            if users.count == 30 {
                expectation3.fulfill()
            }
        }
        viewModel.loadNextPageOfUsers()
        wait(for: [expectation3], timeout: 10.0)
        
        XCTAssertEqual(viewModel.users.first?.login, "ingenious")
        XCTAssertEqual(viewModel.users.last?.login, "Ingeniously-git") // last user on the last page
    }
}
