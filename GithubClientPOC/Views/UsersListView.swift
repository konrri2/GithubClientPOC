//
//  UsersListView.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 27/01/2024.
//

import SwiftUI

struct UsersListView: View {
    enum Layout {
        static let loadingIndicatorHeight: CGFloat = 160
    }
    
    @EnvironmentObject var viewModel: GitHubUsersViewModel
    
    var body: some View {
        List(selection: $viewModel.selectedUser) {
            ForEach(viewModel.users) { user in
                NavigationLink(user.login, value: user)
            }
            
            if viewModel.loadingState != .finishedAll {
                HStack{
                    Spacer()
                    VStack {
                        Spacer()
                        ProgressView()
                            .id(UUID()) /// must be identifiable on the list (otherwise will be hidden after reload)
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.green))
                        Spacer()
                    }
                    Spacer()
                }
                .frame(height: Layout.loadingIndicatorHeight)
                .onAppear{
                    viewModel.loadNextPageOfUsers()
                }
            }
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
