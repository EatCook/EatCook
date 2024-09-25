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
    let postId: Int
    let recipeName: String
    let recipeTime: Int
    let introduction, postImagePath: String
    let foodIngredients, cookingType, lifeTypes : [String]
    let recipeProcess: [RecipeReadProcessDTO]
    let lastModifiedAt: String
    let writerUserId: Int
    let writerUserEmail: String
    let writerNickName: String
    let writerProfile: String?
    let likedCount: Int
    let followCheck, likedCheck, archiveCheck: Bool
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
        return .init(postId: postId,
                     recipeName: recipeName,
                     recipeTime: recipeTime,
                     introduction: introduction,
                     postImagePath: postImagePath,
                     foodIngredients: foodIngredients,
                     cookingType: cookingType,
                     lifeTypes : lifeTypes,
                     recipeProcess: recipeProcess.map { $0.toDomain() },
                     lastModifiedAt: lastModifiedAt,
                     writerUserId: writerUserId,
                     writerUserEmail: writerUserEmail,
                     writerNickName: writerNickName,
                     writerProfile: writerProfile,
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
