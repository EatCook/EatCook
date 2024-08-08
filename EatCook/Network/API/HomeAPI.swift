//
//  HomeAPI.swift
//  EatCook
//
//  Created by 강신규 on 8/8/24.
//

import Foundation

enum HomeAPI: EndPoint {
    case userInfo
    case cookingTheme(_ cookingTheme : String)
    case lifeType(_ lifeType : String)
    
    var path: String {
        switch self {
        case .userInfo:
            return "/api/v1/home"
        
        case .cookingTheme(let cookingTheme) :
            return "/api/v1/home/interest/\(cookingTheme)"
        
        case .lifeType(let lifeType) :
            return "/api/v1/home/special/\(lifeType)"
            
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .userInfo , .cookingTheme , .lifeType:
            return .get
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .userInfo :
            return .requestWithParameters(parameters: [:], encoding: .urlEncoding)
            
        case .cookingTheme:
            return .requestWithParameters(parameters: [:], encoding: .urlEncoding)
        
        case .lifeType:
            return .requestWithParameters(parameters: [:], encoding: .urlEncoding)
            
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .userInfo , .cookingTheme , .lifeType : return HTTPHeaderField.default
            
            
            
            
        }
    }
    
    
}

