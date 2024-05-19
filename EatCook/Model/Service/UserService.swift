//
//  UserService.swift
//  EatCook
//
//  Created by 강신규 on 5/17/24.
//

import Foundation


class UserService {
    
    static let shared = { UserService() }()
    
    private let API_USER_EMAIL_REQUEST = "/api/v1/emails/request"
    private let API_USER_EMAIL_VERIFY = "/api/v1/emails/verify"
    private let API_USER_PASSWORD_CHECK = "/api/v1/users"
    
    
    // 이메일 신청
    func requestEmail(parameters:[String:String], success: @escaping (BaseStruct<EmailRequestData>) -> (), failure: @escaping (BaseError) -> ()) {
        APIClient.shared.request(API_USER_EMAIL_REQUEST, method: .post, parameters: parameters, responseType: EmailRequestData.self, successHandler: { (result) in
            
            print("result :" ,result)
            
//            guard let data = result else {
//                print("Result Data Error")
//                return
//            }
            success(result)
            
        }, failureHandler: { (error) in
            failure(error)
            print("ERROR")
        })
    }
    
    // 이메일 신청
    func requestEmailVerify(parameters:[String:String], success: @escaping (BaseStruct<EmailVerifyData>) -> (), failure: @escaping (BaseError) -> ()) {
        APIClient.shared.request(API_USER_EMAIL_VERIFY, method: .post, parameters: parameters, responseType: EmailVerifyData.self, successHandler: { (result) in
            
            print("result :" ,result)
            
//            guard let data = result else {
//                print("Result Data Error")
//                return
//            }
            success(result)
            
        }, failureHandler: { (error) in
            failure(error)
            print("ERROR")
        })
    }
    
    // 회원가입 신청
    func passwordCheck(parameters:[String:String], success: @escaping (BaseStruct<PasswordCheck>) -> (), failure: @escaping (BaseError) -> ()) {
        APIClient.shared.request(API_USER_PASSWORD_CHECK, method: .post, parameters: parameters, responseType: PasswordCheck.self, successHandler: { (result) in
            
            print("result :" ,result)
            
//            guard let data = result else {
//                print("Result Data Error")
//                return
//            }
            success(result)
            
        }, failureHandler: { (error) in
            failure(error)
            print("ERROR")
        })
    }
    
    
    
    
    
    
}
