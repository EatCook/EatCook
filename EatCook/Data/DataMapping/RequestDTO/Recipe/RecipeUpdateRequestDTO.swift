//
//  RecipeUpdateRequestDTO.swift
//  EatCook
//
//  Created by 이명진 on 7/28/24.
//

import Foundation

struct RecipeUpdateRequestDTO: Codable {
    
    var toDictionary: [String: Any] {
        let dict: [String: Any] = [
            "recipeName": recipeName,
            "recipeTime": recipeTime,
            "introduction": introduction,
            "mainFileExtension": mainFileExtension,
//            "postId": postId,
            "foodIngredients": foodIngredients,
            "cookingType": cookingType,
            "recipeProcess": recipeProcess.map { $0.toDictionary }
        ]
        return dict
    }
    
    let recipeName: String
    let recipeTime: Int
    let introduction, mainFileExtension: String
//    let postId: Int
    let foodIngredients, cookingType: [String]
    let recipeProcess: [RecipeProcessDTO]
    
    init(query: RecipeUpdateRequest) {
        self.recipeName = query.recipeName
        self.recipeTime = query.recipeTime
        self.introduction = query.introduction
        self.mainFileExtension = query.mainFileExtension
//        self.postId = query.postId
        self.foodIngredients = query.foodIngredients
        self.cookingType = query.cookingType
        self.recipeProcess = query.recipeProcess.map { $0.toData() }
    }
    
    init(
        recipeName: String,
        recipeTime: Int,
        introduction: String,
        mainFileExtension: String,
//        postId: Int,
        foodIngredients: [String],
        cookingType: [String],
        recipeProcess: [RecipeProcessDTO]
    ) {
        self.recipeName = recipeName
        self.recipeTime = recipeTime
        self.introduction = introduction
        self.mainFileExtension = mainFileExtension
//        self.postId = postId
        self.foodIngredients = foodIngredients
        self.cookingType = cookingType
        self.recipeProcess = recipeProcess
    }
}
