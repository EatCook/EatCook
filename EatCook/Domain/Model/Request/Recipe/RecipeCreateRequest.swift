//
//  RecipeCreateRequest.swift
//  EatCook
//
//  Created by 이명진 on 7/20/24.
//

import Foundation

struct RecipeCreateRequest: Codable {
    var recipeName: String = ""
    var recipeTime: Int = 0
    var introduction: String = ""
    var mainFileExtension: String = ""
    var foodIngredients: [String] = []
    var cookingType: [String] = []
    var lifeType : [String] = []
    var recipeProcess: [RecipeProcess] = []
}

// 레시피 생성, 업데이트 동일
struct RecipeProcess: Codable {
    var stepNum: Int
    var recipeWriting: String
    var fileExtension: String
}

extension RecipeCreateRequest {
    func toData() -> RecipeCreateRequestDTO {
        return .init(
            recipeName: recipeName,
            recipeTime: recipeTime,
            introduction: introduction,
            mainFileExtension: mainFileExtension,
            foodIngredients: foodIngredients,
            cookingType: cookingType,
            lifeType: lifeType,
            recipeProcess: recipeProcess.map { $0.toData() }
        )
    }
}

extension RecipeProcess {
    func toData() -> RecipeProcessDTO {
        return .init(stepNum: stepNum,
                     recipeWriting: recipeWriting,
                     fileExtension: fileExtension)
    }
}

/// 요청 응답값
/// 레시피 생성, 업데이트 동일
struct RecipeCreateResponse: Codable {
    let success: Bool
    let code, message: String
    let data: ResponseData
}

struct ResponseData: Codable {
    var postId: Int = 0
    var mainPresignedUrl: String = ""
    var recipeProcessPresignedUrl: [String] = []
}
