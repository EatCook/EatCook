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
<<<<<<< HEAD
    
    init() {
        // Kakao SDK 초기화
        let KakaoApiKey = Bundle.main.infoDictionary?["KakaoApiKey"] as? String
        
        if let KakaoApiKey = KakaoApiKey {
            KakaoSDK.initSDK(appKey: "\(String(KakaoApiKey))")
        }else{
            print("API KEY ERROR")
        }

    }
=======
    @StateObject private var loginUserInfo = LoginUserInfoManager.shared
>>>>>>> feature/roar
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(NavigationPathFinder.shared)
                .onOpenURL(perform: { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        AuthController.handleOpenUrl(url: url)
                    }
                })
        }
    }
}
