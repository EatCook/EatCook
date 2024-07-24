//
//  MyPageAPI.swift
//  EatCook
//
//  Created by 이명진 on 7/21/24.
//

import Foundation

enum MyPageAPI: EndPoint {
    case mypageMyRecipe(_ page: Int?)
    case mypageArchive
    case mypageProfileEdit(_ nickName: String)
    case mypageProfileImageEdit(_ fileExtension: String)
    case mypageUserInfo
    
    var path: String {
        switch self {
        case .mypageMyRecipe:
            return "/api/v1/mypage/mypage/my-recipe"
        case .mypageArchive:
            return "/api/v1/mypage/archives"
        case .mypageProfileEdit, .mypageProfileImageEdit:
            return "/api/v1/mypage/profile"
        case .mypageUserInfo:
            return "/api/v1/mypage/user-info"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .mypageMyRecipe:
            return .get
        case .mypageArchive:
            return .get
        case .mypageProfileEdit:
            return .patch
        case .mypageProfileImageEdit:
            return .post
        case .mypageUserInfo:
            return .get
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .mypageMyRecipe(let page):
            return .requestWithParameters(
                parameters: ["page": page ?? 0],
                encoding: .urlEncoding
            )
        case .mypageArchive:
            return .requestWithParameters(
                parameters: [:],
                encoding: .urlEncoding
            )
        case .mypageProfileEdit(let nickName):
            return .requestWithParameters(
                parameters: ["nickName": nickName],
                encoding: .jsonEncoding
            )
        case .mypageProfileImageEdit(let fileExtension):
            return .requestWithParameters(
                parameters: ["fileExtension": fileExtension],
                encoding: .jsonEncoding
            )
        case .mypageUserInfo:
            return .requestWithParameters(
                parameters: [:],
                encoding: .urlEncoding
            )
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .mypageMyRecipe,
                .mypageArchive,
                .mypageProfileEdit,
                .mypageProfileImageEdit,
                .mypageUserInfo:
            return HTTPHeaderField.default
        }
    }
    
    
}
