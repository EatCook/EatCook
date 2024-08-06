//
//  UserService.swift
//  EatCook
//
//  Created by 강신규 on 7/30/24.
//

import Foundation


class UserService {
    
    static let shared = { UserService() }()
    
    private let API_USER_EMAIL_REQUEST = "/api/v1/emails/request"
    private let API_USER_EMAIL_VERIFY = "/api/v1/emails/verify"
    private let API_USER_PASSWORD_CHECK = "/api/v1/users"
    private let API_USER_EMAIL_LOGIN = "/api/v1/auth/login"
    private let API_USER_OAUTH_LOGIN = "/oauth2/login"
    private let API_USER_ADD_SIGNUP = "/api/v1/users/add-signup"
    private let API_USER_NICKNAME_CHECK = "/api/v1/users/add-signup/check-nick"
    private let API_USER_FIND = "/api/v1/users/find"
    private let API_USER_FIND_VERIFY = "/api/v1/users/find/verify"
    private let API_USER_FIND_NEWPASSWORD = "/api/v1/users/find/new-password"
   
    
    
    // 이메일 신청
    func requestEmail(parameters:[String:String], success: @escaping (EmailRequestResponseDTO) -> (), failure: @escaping (EmailRequestResponseDTO) -> ()) {
        APIClient.shared.request(API_USER_EMAIL_REQUEST, method: .post, parameters: parameters, responseType: EmailRequestResponseDTO.self, successHandler: { (result) in
            

            success(result)
            
        }, failureHandler: { (result) in
            failure(result)
            print("ERROR")
        })
    }
    
    // 이메일 신청 코드 검증
    func requestEmailVerify(parameters:[String:String], success: @escaping (EmailVerifyResponseDTO) -> (), failure: @escaping (EmailVerifyResponseDTO) -> ()) {
        APIClient.shared.request(API_USER_EMAIL_VERIFY, method: .post, parameters: parameters, responseType: EmailVerifyResponseDTO.self, successHandler: { (result) in
            
            success(result)
            
        }, failureHandler: { (error) in
            failure(error)
            print("ERROR")
        })
    }
    
    // 회원가입 신청
    func passwordCheck(parameters:[String:String], success: @escaping (PasswordCheckResponseDTO) -> (), failure: @escaping (PasswordCheckResponseDTO) -> ()) {
        APIClient.shared.request(API_USER_PASSWORD_CHECK, method: .post, parameters: parameters, responseType: PasswordCheckResponseDTO.self, successHandler: { (result) in
            
            success(result)
            
        }, failureHandler: { (error) in
            failure(error)
            print("ERROR")
        })
    }
    
    // 로그인
    func login(parameters:[String:String], success: @escaping (LoginResponseDTO) -> (), failure: @escaping (LoginResponseDTO) -> ()) {
        APIClient.shared.request(API_USER_EMAIL_LOGIN, method: .post, parameters: parameters, responseType: LoginResponseDTO.self, successHandler: { (result) in

            success(result)
            
        }, failureHandler: { (error) in
            failure(error)
            print("ERROR")
        })
    }
    
    // oAUTH로그인
    func oAuthlogin(parameters:[String:String], success: @escaping (LoginResponseDTO) -> (), failure: @escaping (LoginResponseDTO) -> ()) {
        APIClient.shared.request(API_USER_OAUTH_LOGIN, method: .post, parameters: parameters, responseType: LoginResponseDTO.self, successHandler: { (result) in

            success(result)
            
        }, failureHandler: { (error) in
            failure(error)
            print("ERROR")
        })
    }
    
    //   회원가입 추가요청
    func addSignUp(parameters:[String:Any], success: @escaping (AddSignUpResponse) -> (), failure: @escaping (AddSignUpResponse) -> ()) {
        print("parameters :", parameters)
        APIClient.shared.request(API_USER_ADD_SIGNUP, method: .post, parameters: parameters, responseType: AddSignUpResponse.self, successHandler: { (result) in
            

            success(result)
            
        }, failureHandler: { (error) in
            failure(error)
            print("ERROR")
        })
    }
    
    
    //   회원가입 닉네임 중복 체크
    func checkNickName(parameters:[String:Any], success: @escaping (CheckNickNameResponse) -> (), failure: @escaping (CheckNickNameResponse) -> ()) {
        print("parameters :", parameters)
        APIClient.shared.request(API_USER_NICKNAME_CHECK, method: .post, parameters: parameters, responseType: CheckNickNameResponse.self, successHandler: { (result) in
            

            success(result)
            
        }, failureHandler: { (error) in
            failure(error)
            print("ERROR")
        })
    }
    
    //   계정찾기 이메일 인증
    func findAccountSendMail(parameters:[String:Any], success: @escaping (FindAccountResponseDTO) -> (), failure: @escaping (FindAccountResponseDTO) -> ()) {
        print("parameters :", parameters)
        APIClient.shared.request(API_USER_FIND, method: .post, parameters: parameters, responseType: FindAccountResponseDTO.self, successHandler: { (result) in
            

            
            success(result)
            
        }, failureHandler: { (error) in
            failure(error)
            print("ERROR")
        })
    }
    
    
    //   계정찾기 이메일 코드 검증
    func findAccountVerify(parameters:[String:Any], success: @escaping (FindAccountVerifyResponseDTO) -> (), failure: @escaping (FindAccountVerifyResponseDTO) -> ()) {
        print("parameters :", parameters)
        APIClient.shared.request(API_USER_FIND_VERIFY, method: .post, parameters: parameters, responseType: FindAccountVerifyResponseDTO.self, successHandler: { (result) in
            
            
            success(result)
            
        }, failureHandler: { (error) in
            failure(error)
            print("ERROR")
        })
    }
    
    
    //  비밀번호 변경
    func findNewPassword(parameters:[String:Any], success: @escaping (FindNewPasswordResponseDTO) -> (), failure: @escaping (FindNewPasswordResponseDTO) -> ()) {
        print("parameters :", parameters)
        APIClient.shared.request(API_USER_FIND_NEWPASSWORD, method: .post, parameters: parameters, responseType: FindNewPasswordResponseDTO.self, successHandler: { (result) in
            
            
            success(result)
            
        }, failureHandler: { (error) in
            failure(error)
            print("ERROR")
        })
    }
    
    
    
}

