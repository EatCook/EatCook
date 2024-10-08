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
import FirebaseMessaging


@main
struct EatCookApp: App {
    @StateObject private var loginUserInfo = LoginUserInfoManager.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var isSplashVisible = true
    
    
    init() {
          // Kakao SDK 초기화
          // TODO : API KEY HIDE
          KakaoSDK.initSDK(appKey: "f6e57755979be3cac29156b4ca677fcb")
//          FirebaseApp.configure()
//        DataStorage.shared.setString("Bearer eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJlYXRjb29rIiwic3ViIjoiYWNjZXNzLXRva2VuIiwiaWF0IjoxNzIzMDM0MTk4LCJ1c2VybmFtZSI6Iml0Y29vazFAZ21haWwuY29tIiwiYXV0aG9yaXRpZXMiOlsiUk9MRV9VU0VSIl0sImV4cCI6MTcyMzAzNDI1OH0.axrTR5Uk1vHUiRkbHS7B8zWRQAcmgG3g1sBo1aMj05eSiolGNpwwCNLCJmmbyBFrCbeGJLCillhNV4e2QOrWhQ", forKey: DataStorageKey.Authorization)
      }
    
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if isSplashVisible {
                    SplashView() // Add your splash screen view here
                } else {
                    ContentView()
                        .environmentObject(NavigationPathFinder.shared)
                        .onOpenURL(perform: { url in
                            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                                AuthController.handleOpenUrl(url: url)
                            }
                        })
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isSplashVisible = false
                    }
                }
            }
        }
    }
}


// Firebase Push Notification

class AppDelegate: NSObject, UIApplicationDelegate{
    
    let gcmMessageIDKey = "gcm.message_id"
    
    // 앱이 켜졌을 때
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // 파이어베이스 설정
        FirebaseApp.configure()
        
        // Setting Up Notifications...
        // 원격 알림 등록
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOption: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOption,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        
        // Setting Up Cloud Messaging...
        // 메세징 델리겟
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    // fcm 토큰이 등록 되었을 때
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
}

// Cloud Messaging...
extension AppDelegate: MessagingDelegate{
    
    // fcm 등록 토큰을 받았을 때
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        if let fcmToken = fcmToken as? String {
            DataStorage.shared.setString(fcmToken, forKey: DataStorageKey.PUSH_TOKEN)
        }
     
    }
}


// User Notifications...[AKA InApp Notification...]

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
  
    // 푸시 메세지가 앱이 켜져있을 때 나올떄
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
      
    let userInfo = notification.request.content.userInfo

    
    // Do Something With MSG Data...
    if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
    }
    
    
    print(userInfo)

    completionHandler([[.banner, .badge, .sound]])
  }

    // 푸시메세지를 받았을 떄
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo

    // Do Something With MSG Data...
    if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
    }
      
    print(userInfo)

    completionHandler()
  }
}


