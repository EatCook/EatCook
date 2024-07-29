//
//  FollowAPI.swift
//  EatCook
//
//  Created by 이명진 on 7/28/24.
//

import Foundation

enum FollowAPI: EndPoint {
    case follow(_ toUserId: Int)
    case unfollow(_ toUserId: Int)
    
    var path: String {
        switch self {
        case .follow:
            return "/api/v1/follow"
        case .unfollow:
            return "/api/v1/unfollow"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .follow:
            return .post
        case .unfollow:
            return .delete
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .follow(let toUserId):
            return .requestWithParameters(
                parameters: ["toUserId": toUserId],
                encoding: .jsonEncoding
            )
        case .unfollow(let toUserId):
            return .requestWithParameters(
                parameters: ["toUserId": toUserId],
                encoding: .jsonEncoding
            )
        }
    }
    
    var headers: [String : String]? {
        return HTTPHeaderField.default
    }
    
}
