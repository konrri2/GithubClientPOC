//
//  UserDetailsView.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 27/01/2024.
//

import SwiftUI

struct UserDetailsView: View {
    @State var user: User
    
    var body: some View {
        Text(user.login)
            .font(.title)
    }
}

#Preview {
    let user = User.readUserFromJson()
    return UserDetailsView(user: user)
}
