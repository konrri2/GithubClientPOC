//
//  GithubClientPOCApp.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 26/01/2024.
//

import SwiftUI

@main
struct GithubClientPOCApp: App {
    var body: some Scene {
        WindowGroup {
            let vm = GitHubUsersViewModel(dataProvider: MockInstantDataProvider())
            ContentView(viewModel: vm)
        }
    }
}
