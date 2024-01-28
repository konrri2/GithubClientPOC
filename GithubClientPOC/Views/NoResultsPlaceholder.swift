//
//  NoResultsPlaceholder.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 28/01/2024.
//

import SwiftUI

struct NoResultsPlaceholder: View {
    let imageName: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .imageScale(.large)
            
            Text(text)
                .font(.largeTitle)
                .minimumScaleFactor(0.6)
        }
        .padding()
        .background(ViewsConstants.accentColor)
        .clipShape(RoundedRectangle(cornerRadius: ViewsConstants.cornerRadius))
    }
}

#Preview {
    NoResultsPlaceholder(imageName: "magnifyingglass", text: "No results")
}
