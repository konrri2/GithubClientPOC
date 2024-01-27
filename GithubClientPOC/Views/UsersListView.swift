//
//  UsersListView.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 27/01/2024.
//

import SwiftUI

struct UsersListView: View {
    @StateObject var viewModel: GitHubUsersViewModel
    
    var body: some View {
        List(viewModel.users) { user in
            Text(user.login)
        }
        .onAppear {
            viewModel.searchForUsers(byName: "TODO search")
        }
    }
}

#Preview {
    let vm = GitHubUsersViewModel(dataProvider: MockInstantDataProvider())
    return UsersListView(viewModel: vm)
}
