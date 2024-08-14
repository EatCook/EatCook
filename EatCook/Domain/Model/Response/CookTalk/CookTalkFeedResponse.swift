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
    var content: [CookTalkFeedResponseList] = []
}

struct CookTalkFeedResponseList: Codable, Identifiable, Hashable {
    var writerUserId: Int = 0
    var writerUserEmail: String? = ""
    var writerProfile: String? = ""
    var writerNickname: String = ""
    var postId: Int = 0
    var recipeName: String = ""
    var introduction: String = ""
    var postImagePath: String = ""
    var lastModifiedAt: String = ""
    var likeCounts: Int = 0
    var likedCheck: Bool = false
    var followCheck: Bool = false
    
    var id: String = UUID().uuidString
}
