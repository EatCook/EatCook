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
    
    init() {
        // Kakao SDK 초기화
        let KakaoApiKey = Bundle.main.infoDictionary?["KakaoApiKey"] as? String
        
        if let KakaoApiKey = KakaoApiKey {
            KakaoSDK.initSDK(appKey: "\(String(KakaoApiKey))")
        }else{
            print("API KEY ERROR")
        }
        
        

        
       
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
