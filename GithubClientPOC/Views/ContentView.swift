//
//  ContentView.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 26/01/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: GitHubUsersViewModel
    
    @State private var columnVisibility = NavigationSplitViewVisibility.all
    
    var body: some View {
        NavigationSplitView(columnVisibility:  $columnVisibility) {
            UsersListView()
         } detail: {
            UserDetailsView()
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationSplitViewStyle(.balanced)
        .environmentObject(viewModel)
    }
}

#Preview("English") {
    let vm = GitHubUsersViewModel(dataProvider: MockInstantDataProvider())
    return ContentView(viewModel: vm)
}

#Preview("Polish") {
    let vm = GitHubUsersViewModel(dataProvider: MockInstantDataProvider())
    return ContentView(viewModel: vm)
        .environment(\.locale, Locale(identifier: "PL"))
}
