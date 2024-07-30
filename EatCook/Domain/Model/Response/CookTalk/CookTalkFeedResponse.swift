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
    let nextPageValid: Bool
    let page, size, totalElements, totalPages: Int
    let cookTalkDtoList: [CookTalkFeedResponseList]
}

struct CookTalkFeedResponseList: Codable, Identifiable, Hashable {
    let writerUserId: Int
    let writerUserEmail: String
    let writerProfile: String?
    let writerNickName: String
    let postId: Int
    let introduction, postImagePath, lastModifiedAt: String
    let likeCounts: Int
    let likedCheck, followCheck: Bool
    
    var id: String = UUID().uuidString
}
