//
//  SpecificUserInfoSubview.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 28/01/2024.
//

import SwiftUI

/// Shows information only when user details have been downloaded
struct SpecificUserInfoSubview: View {
    let details: UserDetails
    
    var body: some View {
        VStack {
            Text(details.name ?? "")
        }
    }
}
