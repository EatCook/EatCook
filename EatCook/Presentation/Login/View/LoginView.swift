//
//  LoginView.swift
//  EatCook
//
//  Created by 이명진 on 2/7/24.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser

struct LoginView: View {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height / 2 - 80
    
    func handleKakaLogin() {
        print("KakaoAuthVM - handleKakaoLogin() called")
        
        // 카카오톡 실행 가능 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            // 카카오 앱으로 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    // 카카오 계정으로 로그인
                    print("loginWithKakaoTalk() success.")

                    //do something
                    _ = oauthToken
                }
            }
        }else {// 카카오톡 미설치 상태 -> 웹으로 이동해 로그인
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("loginWithKakaoAccount() success.")

                        //do something
                        _ = oauthToken
                    }
                }
        }
    }
    
    func kakaoLogOut() {
           UserApi.shared.logout {(error) in
               if let error = error {
                   print(error)
               }
               else {
                   print("logout() success.")
               }
           }
       }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                HStack(spacing: 10) {
                    Image(.food)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width / 2 - 24, height: height)
                        .clipped()
                        .cornerRadius(10)
                    
                    VStack(spacing: 10) {
                        Image(.food)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width / 2 - 24, height: (height - 10) * 0.6)
                            .clipped()
                            .cornerRadius(10)
                        
                        Image(.food)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width / 2 - 24, height: (height - 10) * 0.4)
                            .clipped()
                            .cornerRadius(10)
                    }
                }
                
                Image(.whiteGradation)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 150)
                    .offset(y: 35)
                
                VStack {
                    Text("혼밥 레시피 SNS")
                        .font(.title2)
                        .bold()
                    
                    
                    Image(.title)
                        .resizable()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/ , height: 50)
                    

                    
                    
                    
                }.offset(y: 40)
            }.padding(.top, 40)
            
            Spacer()
            
            VStack(spacing: 10) {
                
                
                Button(action: {
                    // 카카오톡 실행 가능 여부 확인
                    handleKakaLogin()

                }, label: {
                    Image(.kakao)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                .padding(.horizontal, 24)
                
                
                AppleSigninButton()

                
                NavigationLink(destination: EmailLoginView().toolbarRole(.editor)) {
                    Image(.email)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .padding(.horizontal, 24)

            }.padding(.top)
            
            HStack(spacing: 10) {
                Button(action: {
                    
                }, label: {
                    Text("계정찾기")
                        .font(.body)
                        .foregroundStyle(.gray)
                })
                
                Divider()
                    .background(Color.gray)
                    .frame(height: 10)
                NavigationLink(destination: EmailAuthView().toolbarRole(.editor)) {
                    Text("회원가입")
                        .font(.body)
                        .foregroundStyle(.gray)
                }
                
 
            }.padding(.vertical, 30)
        }
    }
}

#Preview {
    LoginView()
}
