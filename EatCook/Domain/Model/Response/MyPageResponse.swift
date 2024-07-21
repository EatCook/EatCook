//
//  MyPageResponse.swift
//  EatCook
//
//  Created by 이명진 on 7/21/24.
//

import Foundation

struct MyPageResponse: Codable {
    let success: Bool
    let code, message: String
    let data: MyPageDataResponse
}

struct MyPageDataResponse: Codable {
    var userId: Int = 0
    var nickName: String = ""
    var badge: String = ""
    var follower: Int = 0
    var following: Int = 0
    var providerType: String = ""
    var posts: MyPagePosts = MyPagePosts()
}

struct MyPagePosts: Codable {
    var content: [MyPageContent] = []
    var page: Int = 0
    var size: Int = 0
    var totalElements: Int = 0
    var totalPages: Int = 0
    var hasNextPage: Bool = false
}

struct MyPageContent: Codable, Identifiable {
    var postId: Int = 0
    var postImagePath: String = ""
    var recipeName: String = ""
    var introduction: String = ""
    var likeCounts: Int = 0
    
    var id: String = UUID().uuidString
}
