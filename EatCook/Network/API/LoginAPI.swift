//
//  LoginPAI.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import Foundation

enum LoginAPI: EndPoint {
    case login
    
    var path: String {
        switch self {
        case .login:
            return "login"
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
        case .login:
            return .requestWithParameters(parameters: [:], encoding: .urlEncoding)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login: return ["Content-Type" : "application/json"]
        }
    }
    
    
}
