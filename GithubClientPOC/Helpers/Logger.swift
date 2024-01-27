//
//  Logger.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 27/01/2024.
//

import Foundation

enum Log {
    static func todo(_ str: String) {
        #if DEBUG
        print("⚠️---TODO--- \(str)")
        #endif
    }
    
    static func debug(_ str: String) {
        #if DEBUG
        print(str)
        #endif
    }
    
    static func error(_ str: String) {
        print("🛑 🛑 🛑  \(str)")
    }
}
