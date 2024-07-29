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
            "postId": postId,
            "recipeName": recipeName,
            "recipeTime": recipeTime,
            "introduction": introduction,
            "mainFileExtension": mainFileExtension,
            "userId": userId,
            "foodIngredients": foodIngredients,
            "cookingType": cookingType,
            "recipeProcess": recipeProcess.map { $0.toDictionary }
        ]
        return dict
    }
    
    let postId: Int
    let recipeName: String
    let recipeTime: Int
    let introduction, mainFileExtension: String
    let userId: Int
    let foodIngredients, cookingType: [String]
    let recipeProcess: [RecipeProcessDTO]
    
    init(query: RecipeUpdateRequest) {
        self.postId = query.postId
        self.recipeName = query.recipeName
        self.recipeTime = query.recipeTime
        self.introduction = query.introduction
        self.mainFileExtension = query.mainFileExtension
        self.userId = query.userId
        self.foodIngredients = query.foodIngredients
        self.cookingType = query.cookingType
        self.recipeProcess = query.recipeProcess.map { $0.toData() }
    }
    
    init(
        postId: Int,
        recipeName: String,
        recipeTime: Int,
        introduction: String,
        mainFileExtension: String,
        userId: Int,
        foodIngredients: [String],
        cookingType: [String],
        recipeProcess: [RecipeProcessDTO]
    ) {
        self.postId = postId
        self.recipeName = recipeName
        self.recipeTime = recipeTime
        self.introduction = introduction
        self.mainFileExtension = mainFileExtension
        self.userId = userId
        self.foodIngredients = foodIngredients
        self.cookingType = cookingType
        self.recipeProcess = recipeProcess
    }
}
