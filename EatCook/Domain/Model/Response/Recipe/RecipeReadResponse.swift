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
    var postId: Int = 0
    var recipeName: String = ""
    var recipeTime: Int = 0
    var introduction: String = ""
    var postImagePath: String = ""
    var foodIngredients: [String] = []
    var cookingType: [String] = []
    var lifeTypes : [String] = []
    var recipeProcess: [RecipeReadProcess] = []
    var lastModifiedAt: String = ""
    var writerUserId: Int = 0
    var writerUserEmail: String? = ""
    var writerNickName: String = ""
    var writerProfile: String? = ""
    var likedCount: Int = 0
    var followCheck: Bool = false
    var likedCheck: Bool = false
    var archiveCheck: Bool = false
    
    var id: String = UUID().uuidString

}

struct RecipeReadProcess: Codable, Identifiable, Hashable {
    var stepNum: Int = 0
    var recipeWriting: String = ""
    var recipeProcessImagePath: String = ""
    
    var id: String = UUID().uuidString
}
