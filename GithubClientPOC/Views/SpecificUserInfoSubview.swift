//
//  SpecificUserInfoSubview.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 28/01/2024.
//

import SwiftUI

/// Shows information only when user details have been downloaded
struct SpecificUserInfoSubview: View {
    enum Layout {
        static let padding: CGFloat = 12
        static let gridSpacing: CGFloat = 12
    }
    
    let details: UserDetails
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: ViewsConstants.cornerRadius)
                .strokeBorder(ViewsConstants.accentColor, lineWidth: 1)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Name:")
                        .font(.title)
                    Text(details.name)
                        .font(.title)
                        .bold()
                }
                
                if let company = details.company {
                    HStack {
                        Text("Company name:")
                        Text(company)
                            .bold()
                    }
                }
                
                if let twitter = details.twitterUsername {
                    HStack {
                        Text("Twitter name:")
                            .font(.footnote)
                        Text(twitter)
                            .font(.footnote)
                            .bold()
                    }
                }
                
                if let bio = details.bio {
                    HStack(alignment: .top) {
                        Text("Biography:")
                            .font(.footnote)
                        Text(bio)
                            .font(.footnote)
                            .bold()
                    }
                }
                
                Grid(alignment: .topLeading,
                     horizontalSpacing: Layout.gridSpacing,
                     verticalSpacing: Layout.gridSpacing) {
                    Divider()
                    GridRow {
                        InfoCard(details.type, "person.crop.circle.badge.questionmark", title: String(localized: "Type"))
                    }
                    GridRow {
                        InfoCard(details.location, "location.circle", title: String(localized: "Location"))
                            .gridCellColumns(2)
                    }
                    Divider()
                    GridRow {
                        InfoCard(details.followers, "person.line.dotted.person.fill", title: String(localized: "Followers"))
                        InfoCard(details.following, "person.2.wave.2.fill", title: String(localized: "Following"))
                    }
                    GridRow {
                        InfoCard(details.publicRepos, "externaldrive.badge.icloud", title: String(localized: "Public repos"))
                        InfoCard(details.totalPrivateRepos, "lock.icloud", title: String(localized: "Private repos"))
                    }
                }
                .padding(Layout.padding)
            
            }
            .padding(Layout.padding)
        }
        .padding(Layout.padding)
        .frame(maxWidth: .infinity)
    }
}

struct InfoCard: View {
    let title: String
    let imageName: String
    let text: String
    let color: Color
    
    init(_ number: Int?, _ imageName: String, title: String = "") {
        self.imageName = imageName
        if let int = number {
            self.text = String(int)
            if int > 0 {
                color = ViewsConstants.accentColor
            } else {
                color = Color.orange
            }
        } else {
            self.text = "-"
            color = ViewsConstants.errorColor
        }
        self.title = title
    }
    
    init(_ text: String?, _ imageName: String, title: String = "") {
        self.imageName = imageName
        self.text = text ?? "-"
        self.title = title
        
        color = Color.teal
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            HStack {
                Image(systemName: imageName)
                    .imageScale(.large)
                
                Text(text)
                    .font(.largeTitle)
                    .minimumScaleFactor(0.6)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(color)
        .clipShape(RoundedRectangle(cornerRadius: ViewsConstants.cornerRadius))
    }
}

#Preview {
    let details = UserDetails.readUserFromJson(forFile: "UserDetails.json")
    return SpecificUserInfoSubview(details: details)
}
