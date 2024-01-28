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
                AsyncImage(url: URL(string: user.avatarURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.secondary
                }
                .frame(width: 200, height: 200)
                    .frame(width: Layout.avatarSize, height: Layout.avatarSize)
                
                Text(user.login)
                    .font(.title)
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
