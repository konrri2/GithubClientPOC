//
//  ContentView.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 26/01/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview("English") {
    ContentView()
}

#Preview("Polish") {
    ContentView()
        .environment(\.locale, Locale(identifier: "PL"))
}
