//
//  LoginPAI.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import Foundation

enum LoginAPI: EndPoint {
    case login(_ email : String , _ password : String , _ deviceToken : String)
//    case socialLogin
    
    var path: String {
        switch self {
        case .login:
            return "/api/v1/auth/login"
            
        
            
            
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .login(let email , let password , let deviceToken):
            return .requestWithParameters(parameters: ["email": email , "password" : password , "deviceToken" : deviceToken], encoding: .jsonEncoding)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login: return HTTPHeaderField.default
            
            
            
            
        }
    }
    
    
}
