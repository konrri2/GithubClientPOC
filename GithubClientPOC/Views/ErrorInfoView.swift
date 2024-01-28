//
//  ErrorInfoView.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 28/01/2024.
//

import SwiftUI

struct ErrorInfoView: View {
    let imageName: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
            
            Text(text)
                .minimumScaleFactor(0.6)
        }
        .padding()
        .background(ViewsConstants.errorColor)
        .clipShape(RoundedRectangle(cornerRadius: ViewsConstants.cornerRadius))
    }
}

#Preview {
    ErrorInfoView(imageName: "wifi.slash", text: "No internet conection")
}
