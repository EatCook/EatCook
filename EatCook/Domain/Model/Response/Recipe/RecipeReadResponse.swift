//
//  RecipeReadResponse.swift
//  EatCook
//
//  Created by 이명진 on 7/16/24.
//

import Foundation

struct RecipeReadResponse: Codable {
    let success: Bool
    let code, message: String
    let data: RecipeReadResponseData
}

struct RecipeReadResponseData: Codable, Identifiable, Hashable {
    let postID: Int
    let recipeName: String
    let recipeTime: Int
    let introduction, postImagePath: String
    let foodIngredients, cookingType: [String]
    let recipeProcess: [RecipeReadProcess]
    let createdAt, lastModifiedAt: String
    let userID: Int
    let nickName: String
    let profile: String?
    let followerCount, likedCount: Int
    let followCheck, likedCheck, archiveCheck: Bool
    
    var id: String = UUID().uuidString

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case recipeName, recipeTime, introduction, postImagePath, foodIngredients, cookingType, recipeProcess, createdAt, lastModifiedAt
        case userID = "userId"
        case nickName, profile, followerCount, likedCount, followCheck, likedCheck, archiveCheck
    }
}

struct RecipeReadProcess: Codable, Identifiable, Hashable {
    let stepNum: Int
    let recipeWriting, recipeProcessImagePath: String
    
    var id: String = UUID().uuidString
}
