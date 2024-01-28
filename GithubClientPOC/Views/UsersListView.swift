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
    @StateObject var searchText = SearchTextDebounce()
    
    var body: some View {
        if viewModel.isNetworkReachable {
            content
        } else {
            ErrorInfoView(imageName: "wifi.slash", text: String(localized: "No internet connection"))
        }
    }
    
    @ViewBuilder
    private var content: some View {
        ZStack {
            List(selection: $viewModel.selectedUser) {
                ForEach(viewModel.users) { user in
                    NavigationLink(user.login, value: user)
                }
                
                if viewModel.loadingState != .finishedAll && !searchText.debouncedText.isEmpty {
                    HStack{
                        Spacer()
                        VStack {
                            Spacer()
                            ProgressView()
                                .id(UUID()) /// must be identifiable on the list (otherwise will be hidden after reload)
                                .progressViewStyle(CircularProgressViewStyle(tint: ViewsConstants.accentColor))
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
                // TODO: remove debug
                searchText.text = "Debug test"
            }
            .searchable(text: $searchText.text, prompt: "Search for users")
            .onChange(of: searchText.debouncedText) { searchTerm in
                if !searchTerm.isEmpty  {
                    viewModel.searchForUsers(byName: searchTerm)
                } else {
                    Log.todo("empty view")
                }
            }
            
            if searchText.text.isEmpty {
                NoResultsPlaceholder(imageName: "rectangle.and.text.magnifyingglass", text: String(localized: "Enter name in search bar"))
                    .padding()
            }
        }
        .navigationTitle("List")
        
    }
}

#Preview {
    UsersListView()
        .environmentObject(GitHubUsersViewModel(dataProvider: MockInstantDataProvider()))
}
