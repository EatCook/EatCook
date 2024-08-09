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
    let postId: Int
    let recipeName: String
    let recipeTime: Int
    let introduction, postImagePath: String
    let foodIngredients, cookingType: [String]
    let recipeProcess: [RecipeReadProcess]
    let lastModifiedAt: String
    let writerUserId: Int
    let writerUserEmail: String
    let writerNickName: String
    let writerProfile: String?
    let likedCount: Int
    let followCheck, likedCheck, archiveCheck: Bool
    
    var id: String = UUID().uuidString

}

struct RecipeReadProcess: Codable, Identifiable, Hashable {
    let stepNum: Int
    let recipeWriting, recipeProcessImagePath: String
    
    var id: String = UUID().uuidString
}
