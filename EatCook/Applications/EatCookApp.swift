//
//  EatCookApp.swift
//  EatCook
//
//  Created by 이명진 on 2/6/24.
//

import SwiftUI

@main
struct EatCookApp: App {
    @StateObject private var loginUserInfo = LoginUserInfoManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(NavigationPathFinder.shared)
        }
    }
}
