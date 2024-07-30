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
    let page, size, totalElements, totalPages: Int
    let cookTalkDtoList: [CookTalkFollowResponseList]
}

struct CookTalkFollowResponseList: Codable, Identifiable, Hashable {
    let writerUserId: Int
    let writerUserEmail: String
    let writerProfile: String?
    let writerNickName: String
    let postId: Int
    let introduction, postImagePath, lastModifiedAt: String
    let profile: String?
    let likeCounts: Int
    let likedCheck, followCheck: Bool
    
    var id: String = UUID().uuidString
}
