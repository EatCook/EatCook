//
//  AuthAPI.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import Foundation

enum AuthAPI: EndPoint {
    case emailRequest(_ email : String)
    case emailVerify(_ email : String , _ authCode : String)
    
    var path: String {
        switch self {
        case .emailRequest:
            return "/api/v1/emails/request"
        case .emailVerify:
            return "/api/v1/emails/verify"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .emailRequest , .emailVerify :
            return .post
            
            
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .emailRequest(let email):
            return .requestWithParameters(parameters: ["email": email], encoding: .jsonEncoding)
        
        case .emailVerify(let email, let authCode):
            return .requestWithParameters(parameters: ["email": email , "authCode" : authCode], encoding: .jsonEncoding)
            
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .emailRequest , .emailVerify : return HTTPHeaderField.loginHeader
            
            
            
            
        }
    }
    
    
}
