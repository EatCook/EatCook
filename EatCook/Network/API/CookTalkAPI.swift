//
//  CookTalkAPI.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import Foundation

enum CookTalkAPI: EndPoint {
    case cookTalkFeed(_ page: Int)
    case cookTalkFollow(_ page: Int)
    
    var path: String {
        switch self {
        case .cookTalkFeed:
            return "/api/v1/posts/cooktalks/feeds"
        case .cookTalkFollow:
            return "/api/v1/posts/cooktalks/follows"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .cookTalkFeed, .cookTalkFollow:
            return .get
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .cookTalkFeed(let page):
            return .requestWithParameters(
                parameters: ["page": page],
                encoding: .urlEncoding
            )
        case .cookTalkFollow(let page):
            return .requestWithParameters(
                parameters: ["page": page],
                encoding: .urlEncoding
            )
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .cookTalkFeed, .cookTalkFollow:
            return HTTPHeaderField.default
        }
    }
    
    
}
