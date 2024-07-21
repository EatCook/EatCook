//
//  MyPageAPI.swift
//  EatCook
//
//  Created by 이명진 on 7/21/24.
//

import Foundation

enum MyPageAPI: EndPoint {
    case mypage(_ page: Int?)
    case mypageArchive
    
    var path: String {
        switch self {
        case .mypage:
            return "/api/v1/mypage"
        case .mypageArchive:
            return "/api/v1/mypage/archives"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .mypage:
            return .get
        case .mypageArchive:
            return .get
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .mypage(let page):
            return .requestWithParameters(
                parameters: ["page": page ?? 0],
                encoding: .urlEncoding)
        case .mypageArchive:
            return .requestWithParameters(parameters: [:], encoding: .urlEncoding)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .mypage, .mypageArchive:
            return HTTPHeaderField.default
        }
    }
    
    
}
