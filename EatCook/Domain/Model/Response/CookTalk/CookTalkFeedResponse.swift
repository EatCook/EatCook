//
//  CookTalkFeedResponse.swift
//  EatCook
//
//  Created by 이명진 on 7/15/24.
//

import Foundation

struct CookTalkFeedResponse: Codable {
    let success: Bool
    let code, message: String
    let data: CookTalkFeedResponseData
}

struct CookTalkFeedResponseData: Codable {
    let hasNextPage: Bool
    let page, size, totalElements, totalPages: Int
    let content: [CookTalkFeedResponseList]
}

struct CookTalkFeedResponseList: Codable, Identifiable, Hashable {
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
