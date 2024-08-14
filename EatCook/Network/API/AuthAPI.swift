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
    case signUp(_ email : String , _ password : String)
    case checkNickName(_ nickName : String)
    case addSignUp(_ email : String , _ fileExtension : String , _ nickName : String , _ cookingType : [String] , _ lifeType : String)
    case findPasswordRequestEmail(_ email : String)
    case findPasswordEmailVerify(_ email : String , _ authCode : String)
    case setNewPassword(_ email : String , _ password : String)
    
    var path: String {
        switch self {
        case .emailRequest:
            return "/api/v1/emails/request"
        case .emailVerify:
            return "/api/v1/emails/verify"
        case .signUp :
            return "/api/v1/users"
        case .checkNickName:
            return "/api/v1/users/add-signup/check-nick"
        case .addSignUp:
            return "/api/v1/users/add-signup"
        case .findPasswordRequestEmail:
            return "/api/v1/users/find"
        case .findPasswordEmailVerify:
            return "/api/v1/users/find/verify"
        case .setNewPassword:
            return "/api/v1/users/find/new-password"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .emailRequest , .emailVerify , .signUp , .checkNickName , .addSignUp , .findPasswordRequestEmail , .findPasswordEmailVerify , .setNewPassword:
            return .post
            
            
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .emailRequest(let email):
            return .requestWithParameters(parameters: ["email": email], encoding: .jsonEncoding)
        
        case .emailVerify(let email, let authCode):
            return .requestWithParameters(parameters: ["email": email , "authCode" : authCode], encoding: .jsonEncoding)
        
        case .signUp(let email, let password):
            return .requestWithParameters(parameters: ["email": email , "password" : password], encoding: .jsonEncoding)
        case .checkNickName(let nickName):
            return .requestWithParameters(parameters: ["nickName": nickName], encoding: .jsonEncoding)
        case .addSignUp(let email, let fileExtension, let nickName, let cookingType, let lifeType):
            return .requestWithParameters(parameters: ["email": email , "fileExtension" : fileExtension , "nickName" : nickName , "cookingType" : cookingType , "lifeType" : lifeType], encoding: .jsonEncoding)
        case .findPasswordRequestEmail(let email):
            return .requestWithParameters(parameters: ["email": email ], encoding: .jsonEncoding)
        
        case .findPasswordEmailVerify(let email, let authCode):
            return .requestWithParameters(parameters: ["email": email , "authCode" : authCode ], encoding: .jsonEncoding)
        
        case .setNewPassword(let email, let password):
            return .requestWithParameters(parameters: ["email": email , "password" : password ], encoding: .jsonEncoding)
        
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .emailRequest , .emailVerify , .signUp , .checkNickName , .addSignUp , .findPasswordRequestEmail , .findPasswordEmailVerify , .setNewPassword : return HTTPHeaderField.loginHeader
            
            
            
            
        }
    }
    
    
}
