//
//  MyPageMyRecipeResponse.swift
//  EatCook
//
//  Created by 이명진 on 7/25/24.
//

import Foundation

struct MyPageMyRecipeResponse: Codable {
    let success: Bool
    let code, message: String
    let data: MyPageMyRecipePosts
}

struct MyPageMyRecipePosts: Codable {
    var page: Int = 0
    var size: Int = 0
    var totalElements: Int = 0
    var totalPages: Int = 0
    var hasNextPage: Bool = false
    var content: [MyPageMyRecipeContent] = []
}

struct MyPageMyRecipeContent: Codable, Identifiable {
    var postId: Int = 0
    var postImagePath: String = ""
    var recipeName: String = ""
    var introduction: String = ""
    var likeCounts: Int = 0
    
    var id: String = UUID().uuidString
}
