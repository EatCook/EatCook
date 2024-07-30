//
//  EatCookApp.swift
//  EatCook
//
//  Created by 이명진 on 2/6/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth


@main
struct EatCookApp: App {
    @StateObject private var loginUserInfo = LoginUserInfoManager.shared
    
    init() {
          // Kakao SDK 초기화
          KakaoSDK.initSDK(appKey: "f6e57755979be3cac29156b4ca677fcb")
      }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(NavigationPathFinder.shared)
                .onOpenURL(perform: { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        AuthController.handleOpenUrl(url: url)
                    }
                })
        }
    }
}
