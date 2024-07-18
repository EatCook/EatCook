//
//  LoginView.swift
//  EatCook
//
//  Created by 이명진 on 2/7/24.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices

struct LoginView: View {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height / 2 - 80
    
    @State var navigate = false
    @EnvironmentObject private var naviPathFinder: NavigationPathFinder
    
    
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

                        UserService.shared.oAuthlogin(parameters: ["email": email , "providerType" : "KAKAO", "token" : "Bearer \(token)"], success: { (data) in
                            
                            print("data : " , data)
                            
                            if data.success {
                                self.navigate = true
                                naviPathFinder.addPath(.main(""))
                            }
                        
                            
                        }, failure: { (error) in
                            
                            print(error)
                        })
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
                
                
                NavigationLink(destination: ContentView() , isActive: $navigate) {
                    Button(action: {
                        // 카카오톡 실행 가능 여부 확인
                        handleKakaLogin()

                    }, label: {
                        ZStack {
                            Image(.kakao1).resizable() .frame(width: 20, height: 20).offset(x: -125,y: 0)
                            Text("카카오 로그인").offset(x : 10 , y : 0)
                        }  .frame(width : 300, height : 52)
                            .background{
                                Color.kakaoBackground
                            }.cornerRadius(10)
                    })
                    .frame(width : 300, height : 52)
                    .padding(.horizontal, 24)
                }
                
                
                Button(action: {

                }, label: {
                    ZStack {
                        Image(.apple1).resizable() .frame(width: 20, height: 20).offset(x: -125,y: 0)
                        Text("Apple 로그인").foregroundColor(.white).offset(x : 10 , y : 0)
                    }  .frame(width : 300, height : 52)
                        .background{
                            Color.black
                        }.cornerRadius(10)
                })
                .frame(width : 300, height : 52)
                .padding(.horizontal, 24)
                .overlay {
                    SignInWithAppleButton(
                        onRequest: { request in
                            request.requestedScopes = [.fullName, .email]
                        },
                        onCompletion: { result in
                            switch result {
                            case .success(let authResults):
                                print("Apple Login Successful")
                                print("authResults : " , authResults)
                                switch authResults.credential{
                                case let appleIDCredential as ASAuthorizationAppleIDCredential:
                                    // 계정 정보 가져오기
                                    
                                    var email = appleIDCredential.email ?? ""
                                    let user = appleIDCredential.user
                                    

                                    if email.isEmpty { /// 2번째 애플 로그인부터는 email이 identityToken에 들어있음.
                                        if let tokenString = String(data: appleIDCredential.identityToken ?? Data(), encoding: .utf8) {
                                            email = decode(jwtToken: tokenString)["email"] as? String ?? ""
                                        }
                                    }
                                    
                                    print("email : " , email)
                                    
                                    UserService.shared.oAuthlogin(parameters: ["email": email ?? ""  , "providerType" : "APPLE"], success: { (data) in
                                        
                                        print("data : " , data)
                                        self.navigate = true
                                        
                                    }, failure: { (error) in
                                        
                                        print(error)
                                    })

                                default:
                                    break
                                }
                            case .failure(let error):
                                print(error.localizedDescription)
                                print("error")
                            }
                        }
                    ).blendMode(.overlay)
                }
    

 

                
                NavigationLink(destination: EmailLoginView().toolbarRole(.editor)) {
                    ZStack {
                        Image(.email1).resizable() .frame(width: 20, height: 20).offset(x: -125,y: 0)
                        Text("이메일 로그인").offset(x : 10 , y : 0)
                    }  .frame(width : 300, height : 52)
                        .background{
                            Color.bgPrimary
                        }.cornerRadius(10)
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
            
            NavigationLink(destination: ContentView() , isActive: $navigate) {
                EmptyView()
            }
            
        }
    }
}

#Preview {
    LoginView()
}

/// JWTToken -> dictionary
private func decode(jwtToken jwt: String) -> [String: Any] {
    
    func base64UrlDecode(_ value: String) -> Data? {
        var base64 = value
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")

        let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length
        if paddingLength > 0 {
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            base64 = base64 + padding
        }
        return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }

    func decodeJWTPart(_ value: String) -> [String: Any]? {
        guard let bodyData = base64UrlDecode(value),
              let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: Any] else {
            return nil
        }

        return payload
    }
    
    let segments = jwt.components(separatedBy: ".")
    return decodeJWTPart(segments[1]) ?? [:]
}
