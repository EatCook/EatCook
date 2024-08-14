//
//  LoginViewModel.swift
//  EatCook
//
//  Created by 이명진 on 2/7/24.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices
import Combine


final class LoginViewModel : ObservableObject   {
    
    private let loginUseCase : LoginUseCase
    private var cancellables = Set<AnyCancellable>()
    
    @Published var errorMessage : String = ""
    let loginUserInfo: LoginUserInfoManager
    
    init(loginUseCase: LoginUseCase , loginUserInfo: LoginUserInfoManager) {
        self.loginUseCase = loginUseCase
        self.loginUserInfo = loginUserInfo
    }
    
    
    
    
}

extension LoginViewModel {
    
    func socialLogin(providerType : String , token : String , email : String ,completion :  @escaping (Bool) -> Void ) {
        
        let deviceToken =  DataStorage.shared.getString(forKey: DataStorageKey.PUSH_TOKEN)
        print(providerType ,token , email , deviceToken )
        
        loginUseCase.socialLogin(providerType, token, email, deviceToken)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("LoginView  SocialSetting Finished")
                    
                case .failure(let error):
                    print("error:", error)
                    switch error {
                    case .unauthorized:
                        print("소셜 로그인 토큰 에러")
                        
                    default:
                        print("기본 에러처리")
                    }
                    
                    print("LoginView  Social Error: \(error)")
                }
                
            } receiveValue: { response in
                print("LoginView  Social response:" , response)
                if response.success {
                    return completion(true)
                }else{
                    return completion(false)
                }
                
            }
            .store(in: &cancellables)
        
    }
    
    func handleKakaLogin(completion :  @escaping (Bool) -> Void) {
        print("KakaoAuthVM - handleKakaoLogin() called")
        // 카카오톡 실행 가능 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            // 카카오 앱으로 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print("KAKAO LOGIN ERROR:::" , error)
                }
                else {
                    // 카카오 계정으로 로그인
                    print("loginWithKakaoTalk() success.")
                    print("oauthToken :" ,oauthToken)
                    
                    UserApi.shared.me { user, error in
                        
                        
                        guard let user = user , let id = user.id else {
                            print("KAKAO USER 정보 에러")
                            return
                        }
                        
                        guard let email = user.kakaoAccount?.email else {
                            print("KAKAO 계정 이메일 오류")
                            return
                        }
                        
                        guard let token = oauthToken?.accessToken else {
                            print("카카오 oAuth Token 오류")
                            return
                        }
                        
                        print("email :", email)
                        print("token :", "Bearer \(token)")
                        
                        self.socialLogin(providerType: "KAKAO", token: "Bearer \(token)", email: email) { result in
                            if result {
                                completion(true)
                            }else{
                                completion(false)
                            }
                        }


                        
                    }
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
    
    
    
    
    
    
    
}
