//
//  OtherUserPostsResponse.swift
//  EatCook
//
//  Created by 이명진 on 7/28/24.
//

import Foundation

struct OtherUserPostsResponse: Codable {
    var success: Bool = false
    var code: String = ""
    var message: String = ""
    var data = OtherUserPostsResponseData()
}

struct OtherUserPostsResponseData: Codable {
    var content: [OtherUserPostsResponseList] = []
    var page: Int = 0
    var size: Int = 0
    var totalElements: Int = 0
    var totalPages: Int = 0
    var hasNextPage: Bool = false
}

struct OtherUserPostsResponseList: Codable {
    var postId: Int = 0
    var postImagePath: String = ""
    var recipeName: String = ""
    var recipeTime: Int = 0
    var writerProfile: String = ""
    var writerNickName: String = ""
    var writerUserId: Int = 0
    var writerUserEmail: String = ""
    var introduction: String = ""
    var likedCounts: Int = 0
    var likedCheck: Bool = false
    var archiveCheck: Bool = false
    
    var id: String = UUID().uuidString
}
