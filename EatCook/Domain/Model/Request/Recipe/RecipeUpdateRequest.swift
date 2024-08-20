//
//  RecipeUpdateRequest.swift
//  EatCook
//
//  Created by 이명진 on 7/27/24.
//

import Foundation

struct RecipeUpdateRequest: Codable {
    var recipeName: String = ""
    var recipeTime: Int = 0
    var introduction: String = ""
    var mainFileExtension: String = ""
//    var postId: Int = 0
    var foodIngredients: [String] = []
    var cookingType: [String] = []
    var recipeProcess: [RecipeProcess] = []
}

extension RecipeUpdateRequest {
    func toData() -> RecipeUpdateRequestDTO {
        return .init(
            recipeName: recipeName,
            recipeTime: recipeTime,
            introduction: introduction,
            mainFileExtension: mainFileExtension,
//            postId: postId,
            foodIngredients: foodIngredients,
            cookingType: cookingType,
            recipeProcess: recipeProcess.map { $0.toData() }
        )
    }
}

