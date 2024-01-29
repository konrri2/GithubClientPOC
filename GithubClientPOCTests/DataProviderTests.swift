//
//  DataProviderTests.swift
//  GithubClientPOCTests
//
//  Created by Konrad Leszczyński on 29/01/2024.
//

import XCTest
@testable import GithubClientPOC

final class DataProviderTests: XCTestCase {

    // Must test if user with nil and usual characters in json parse corectly
    func testDetailsParsing() throws {
        let sut = MockInstantDataProvider()
        
        sut.getUserDetails(userUrl: "UserDetails.json") { result in
            switch result {
            case .success(let userDetails):
                XCTAssertEqual(userDetails.login, "octocat")
                XCTAssertEqual(userDetails.name, "monalisa octocat")
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
        }
        
        sut.getUserDetails(userUrl: "UserDetails2.json") { result in
            switch result {
            case .success(let userDetails):
                XCTAssertEqual(userDetails.login, "Srinivas11789")
                XCTAssertEqual(userDetails.name, "Srinivas P G")
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
        }
    }

}
