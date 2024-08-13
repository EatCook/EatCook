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
    var content: [CookTalkFollowResponseList] = []
}

struct CookTalkFollowResponseList: Codable, Identifiable, Hashable {
    var writerUserId: Int = 0
    var writerUserEmail: String = ""
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
