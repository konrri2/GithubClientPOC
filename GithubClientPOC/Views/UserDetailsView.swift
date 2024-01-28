//
//  UserDetailsView.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 27/01/2024.
//

import SwiftUI

struct UserDetailsView: View {
    enum Layout {
        static let avatarSize: CGFloat = 80
    }
    
    @EnvironmentObject var viewModel: GitHubUsersViewModel
    
    var body: some View {
        VStack {
            if let user = viewModel.selectedUser {
                AsyncImage(url: URL(string: user.avatarURL))
                // TODO: resizable
                    .frame(width: Layout.avatarSize, height: Layout.avatarSize)
                Text(user.login)
                    .font(.title)
            } else {
                Text("No user selected")
            }
        }
        .navigationTitle("User details")
    }
}

#Preview {
    let vm = GitHubUsersViewModel(dataProvider: MockInstantDataProvider())
    vm.selectedUser = User.readUserFromJson()
    return UserDetailsView()
        .environmentObject(vm)
}
