//
//  UserDetailsView.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 27/01/2024.
//

import SwiftUI

struct UserDetailsView: View {
    enum Layout {
        static let avatarSize: CGFloat = 120
    }
    
    @EnvironmentObject var viewModel: GitHubUsersViewModel
    
    var body: some View {
        HStack {
            if let user = viewModel.selectedUser {
                VStack {
                    BasicUserInfoSubview(user: user)
                    
                    if let user = viewModel.selectedUserDetails {
                        SpecificUserInfoSubview(details: user)
                    } else {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: ViewsConstants.accentColor))
                    }
                }
            } else {
                NoResultsPlaceholder(imageName: "person.fill.viewfinder", text: String(localized: "No user selected"))
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
