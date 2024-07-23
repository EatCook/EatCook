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
    case mypageProfileEdit(_ nickName: String)
    
    var path: String {
        switch self {
        case .mypage:
            return "/api/v1/mypage"
        case .mypageArchive:
            return "/api/v1/mypage/archives"
        case .mypageProfileEdit:
            return "/api/v1/mypage/profile"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .mypage:
            return .get
        case .mypageArchive:
            return .get
        case .mypageProfileEdit:
            return .patch
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .mypage(let page):
            return .requestWithParameters(
                parameters: ["page": page ?? 0],
                encoding: .urlEncoding
            )
        case .mypageArchive:
            return .requestWithParameters(parameters: [:], encoding: .urlEncoding)
        case .mypageProfileEdit(let nickName):
            return .requestWithParameters(
                parameters: ["nickName": nickName],
                encoding: .jsonEncoding
            )
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .mypage, .mypageArchive, .mypageProfileEdit:
            return HTTPHeaderField.default
        }
    }
    
    
}
