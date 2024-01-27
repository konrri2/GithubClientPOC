//
//  UsersListView.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 27/01/2024.
//

import SwiftUI

struct UsersListView: View {
    @EnvironmentObject var viewModel: GitHubUsersViewModel
    
    var body: some View {
        List(viewModel.users, selection: $viewModel.selectedUser) { user in
            NavigationLink(user.login, value: user)
        }
        .onAppear {
            viewModel.searchForUsers(byName: "TODO search")
        }
    }
}

#Preview {
    UsersListView()
        .environmentObject(GitHubUsersViewModel(dataProvider: MockInstantDataProvider()))
}
