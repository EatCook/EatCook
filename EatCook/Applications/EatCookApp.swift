//
//  EatCookApp.swift
//  EatCook
//
//  Created by 이명진 on 2/6/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import Firebase

@main
struct EatCookApp: App {
    @StateObject private var loginUserInfo = LoginUserInfoManager.shared
    
    init() {
          // Kakao SDK 초기화
          // TODO : API KEY HIDE
          KakaoSDK.initSDK(appKey: "f6e57755979be3cac29156b4ca677fcb")
          FirebaseApp.configure()
        
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
