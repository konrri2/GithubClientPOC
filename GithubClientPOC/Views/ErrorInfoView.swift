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
        VStack {
            Spacer()
            HStack {
                Spacer()
                Image(systemName: imageName)
                
                Text(text)
                    .minimumScaleFactor(0.6)
                Spacer()
            }
            .padding()
            .frame(minHeight: 80)
            .background(ViewsConstants.errorColor)
            .clipShape(RoundedRectangle(cornerRadius: ViewsConstants.cornerRadius))
            .padding()
            
            Spacer()
        }
        .background(ViewsConstants.errorColor.opacity(0.3))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ErrorInfoView(imageName: "wifi.slash", text: "No internet connection")
}
