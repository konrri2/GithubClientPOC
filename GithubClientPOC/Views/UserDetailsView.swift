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
        ScrollView {
            HStack {
                if let message = viewModel.detailsLoadingErrorMessage {
                    ErrorInfoView(imageName: "exclamationmark.icloud", text: message)
                }
                
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
        }
        .clipped()
        .navigationTitle("User details")
    }
}
