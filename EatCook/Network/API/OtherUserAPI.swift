//
//  OtherUserAPI.swift
//  EatCook
//
//  Created by 이명진 on 7/28/24.
//

import Foundation

enum OtherUserAPI: EndPoint {
    case otherUserInfo(_ userId: Int)
    case otherUserPosts(_ userId: Int, _ page: Int)
    
    var path: String {
        switch self {
        case .otherUserInfo(let userId):
            return "/api/v1/other-page/user-info/\(userId)"
        case .otherUserPosts(let userId, _):
            return "/api/v1/other-page/user-info/\(userId)/posts"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .otherUserInfo, .otherUserPosts:
            return .get
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .otherUserInfo(let userId):
            return .requestWithParameters(
                parameters: ["otherUserId": userId],
                encoding: .urlEncoding
            )
        case .otherUserPosts(let userId , let page):
            return .requestWithParameters(
                parameters: ["pageNum": page,
                             "otherUserId": userId],
                encoding: .urlEncoding
            )
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .otherUserInfo, .otherUserPosts:
            return HTTPHeaderField.default
        }
    }
    
}
