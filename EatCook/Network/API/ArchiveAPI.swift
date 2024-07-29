//
//  ArchiveAPI.swift
//  EatCook
//
//  Created by 이명진 on 7/22/24.
//

import Foundation

enum ArchiveAPI: EndPoint {
    case archiveAdd(_ postId: Int)
    case archiveDelete(_ postId: Int)
    
    var path: String {
        switch self {
        case .archiveAdd:
            return "/api/v1/archive/add"
        case .archiveDelete:
            return "/api/v1/archive/del"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .archiveAdd:
            return .post
        case .archiveDelete:
            return .delete
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .archiveAdd(let postId):
            return .requestWithParameters(
                parameters: ["postId": postId],
                encoding: .jsonEncoding)
        case .archiveDelete(let postId):
            return .requestWithParameters(
                parameters: ["postId": postId],
                encoding: .jsonEncoding
            )
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .archiveAdd, .archiveDelete:
            return HTTPHeaderField.default
        }
    }
    
    
}
