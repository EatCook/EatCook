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
            return ""
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
            return .requestWithParameters(parameters: <#T##[String : Any]#>, encoding: <#T##ParameterEncoding#>)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login: return nil
        }
    }
    
    
}
