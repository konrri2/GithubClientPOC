//
//  BasicUserInfoSubview.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 28/01/2024.
//

import SwiftUI

/// Shows information when user is selected but details may not have been downloaded yet
struct BasicUserInfoSubview: View {
    let user: User
    
    var body: some View {
        AsyncImage(url: URL(string: user.avatarURL)) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            Color.secondary
        }
        .frame(width: UserDetailsView.Layout.avatarSize, height: UserDetailsView.Layout.avatarSize)
        .clipShape(RoundedRectangle(cornerRadius: ViewsConstants.cornerRadius))
        .padding()
    }
}
