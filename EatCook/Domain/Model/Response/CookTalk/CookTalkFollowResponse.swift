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
    let hasNextPage: Bool
    let page, size, totalElements, totalPages: Int
    let content: [CookTalkFollowResponseList]
}

struct CookTalkFollowResponseList: Codable, Identifiable, Hashable {
    let writerUserId: Int
    let writerUserEmail: String
    let writerProfile: String?
    let writerNickname: String
    let postId: Int
    let recipeName: String
    let introduction, postImagePath, lastModifiedAt: String
    let likeCounts: Int
    let likedCheck, followCheck: Bool
    
    var id: String = UUID().uuidString
}
