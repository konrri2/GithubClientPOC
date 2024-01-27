//
//  UserDetailsView.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 27/01/2024.
//

import SwiftUI

struct UserDetailsView: View {
    @EnvironmentObject var viewModel: GitHubUsersViewModel
    
    var body: some View {
        if let user = viewModel.selectedUser {
            Text(user.login)
                .font(.title)
        } else {
            Text("No user selected")
        }
    }
}

#Preview {
    UserDetailsView()
        .environmentObject(GitHubUsersViewModel(dataProvider: MockInstantDataProvider()))
}
