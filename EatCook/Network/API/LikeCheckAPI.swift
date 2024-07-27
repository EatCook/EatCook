//
//  LikeCheckAPI.swift
//  EatCook
//
//  Created by 이명진 on 7/28/24.
//

import Foundation

enum LikeCheckAPI: EndPoint {
    case likeAdd(_ postId: Int)
    case likeDelete(_ postId: Int)
    
    var path: String {
        switch self {
        case .likeAdd:
            return "/api/v1/liked/add"
        case .likeDelete:
            return "/api/v1/liked/del"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .likeAdd:
            return .post
        case .likeDelete:
            return .delete
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .likeAdd(let postId):
            return .requestWithParameters(
                parameters: ["postId": postId],
                encoding: .jsonEncoding
            )
        case .likeDelete(let postId):
            return .requestWithParameters(
                parameters: ["postId": postId],
                encoding: .jsonEncoding
            )
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .likeAdd, .likeDelete:
            return HTTPHeaderField.default
        }
    }
    
    
}
