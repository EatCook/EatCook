//
//  LoginPAI.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import Foundation

enum LoginAPI: EndPoint {
    case login(_ email : String , _ password : String , _ deviceToken : String)
    case socialLogin(_ providerType : String , _ token : String , _ email : String , _ deviceToken : String)
    
    var path: String {
        switch self {
        case .login:
            return "/api/v1/auth/login"
        case .socialLogin:
            return "/api/v1/auth/oauth2/login"
            
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login , .socialLogin:
            return .post
            
            
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .login(let email , let password , let deviceToken):
            return .requestWithParameters(parameters: ["email": email , "password" : password , "deviceToken" : deviceToken], encoding: .jsonEncoding)
        case .socialLogin(let providerType, let token, let email, let deviceToken):
            return .requestWithParameters(parameters: ["providerType": providerType , "token" : token , "email" : email , "deviceToken" : deviceToken], encoding: .jsonEncoding)
            
            
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login , .socialLogin: return HTTPHeaderField.loginHeader
            
            
            
            
        }
    }
    
    
}
