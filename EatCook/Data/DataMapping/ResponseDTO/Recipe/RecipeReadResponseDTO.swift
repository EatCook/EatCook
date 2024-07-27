//
//  RecipeReadResponseDTO.swift
//  EatCook
//
//  Created by 이명진 on 7/16/24.
//

import Foundation

struct RecipeReadResponseDTO: Codable {
    let success: Bool
    let code, message: String
    let data: RecipeReadResponseDataDTO
}

struct RecipeReadResponseDataDTO: Codable {
    let postID: Int
    let recipeName: String
    let recipeTime: Int
    let introduction, postImagePath: String
    let foodIngredients, cookingType: [String]
    let recipeProcess: [RecipeReadProcessDTO]
    let createdAt, lastModifiedAt: String
    let userID: Int
    let nickName: String
    let profile: String?
    let followerCount, likedCount: Int
    let followCheck, likedCheck, archiveCheck: Bool

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case recipeName, recipeTime, introduction, postImagePath, foodIngredients, cookingType, recipeProcess, createdAt, lastModifiedAt
        case userID = "userId"
        case nickName, profile, followerCount, likedCount, followCheck, likedCheck, archiveCheck
    }
}

struct RecipeReadProcessDTO: Codable {
    let stepNum: Int
    let recipeWriting, recipeProcessImagePath: String
}

extension RecipeReadResponseDTO {
    func toDomain() -> RecipeReadResponse {
        return .init(success: success,
                     code: code,
                     message: message,
                     data: data.toDomain())
    }
}

extension RecipeReadResponseDataDTO {
    func toDomain() -> RecipeReadResponseData {
        return .init(postID: postID,
                     recipeName: recipeName,
                     recipeTime: recipeTime,
                     introduction: introduction,
                     postImagePath: postImagePath,
                     foodIngredients: foodIngredients,
                     cookingType: cookingType,
                     recipeProcess: recipeProcess.map { $0.toDomain() },
                     createdAt: createdAt,
                     lastModifiedAt: lastModifiedAt,
                     userID: userID,
                     nickName: nickName,
                     profile: profile,
                     followerCount: followerCount,
                     likedCount: likedCount,
                     followCheck: followCheck,
                     likedCheck: likedCheck,
                     archiveCheck: archiveCheck)
    }
}

extension RecipeReadProcessDTO {
    func toDomain() -> RecipeReadProcess {
        return .init(stepNum: stepNum,
                     recipeWriting: recipeWriting,
                     recipeProcessImagePath: recipeProcessImagePath)
    }
}
