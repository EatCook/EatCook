//
//  CookTalkFollowResponse.swift
//  EatCook
//
//  Created by 이명진 on 7/15/24.
//

import Foundation

struct CookTalkFollowResponse: Codable {
    let success: Bool
    let code, message: String
    let data: CookTalkFollowResponseData
}

struct CookTalkFollowResponseData: Codable {
    let nextPageValid: Bool
    let totalElements, totalPages: Int
    let cookTalkDtoList: [CookTalkFollowResponseList]
}

struct CookTalkFollowResponseList: Codable, Identifiable, Hashable {
    let postID: Int
    let introduction, postImagePath, createdAt, lastModifiedAt: String
    let userID: Int
    let nickName, profile: String
    let likeCount: Int
    let likedCheck, followCheck: Bool
    
    var id: String = UUID().uuidString

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case introduction, postImagePath, createdAt, lastModifiedAt
        case userID = "userId"
        case nickName, profile, likeCount, likedCheck, followCheck
    }
}
