//
//  RecipeCreateRequestDTO.swift
//  EatCook
//
//  Created by 이명진 on 7/20/24.
//

import Foundation

struct RecipeCreateRequestDTO: Codable {
    
    var toDictionary: [String: Any] {
        let dict: [String: Any] = [
            "email": email,
            "recipeName": recipeName,
            "recipeTime": recipeTime,
            "introduction": introduction,
            "mainFileExtension": mainFileExtension,
            "foodIngredients": foodIngredients,
            "cookingType": cookingType,
            "recipeProcess": recipeProcess
        ]
        return dict
    }
    
    let email, recipeName: String
    let recipeTime: Int
    let introduction, mainFileExtension: String
    let foodIngredients, cookingType: [String]
    let recipeProcess: [RecipeProcessDTO]
    
    init(query: RecipeCreateRequest) {
        self.email = query.email
        self.recipeName = query.recipeName
        self.recipeTime = query.recipeTime
        self.introduction = query.introduction
        self.mainFileExtension = query.mainFileExtension
        self.foodIngredients = query.foodIngredients
        self.cookingType = query.cookingType
        self.recipeProcess = query.recipeProcess.map { $0.toData() }
    }
    
    init(
        email: String,
        recipeName: String,
        recipeTime: Int,
        introduction: String,
        mainFileExtension: String,
        foodIngredients: [String],
        cookingType: [String],
        recipeProcess: [RecipeProcessDTO]
    ) {
        self.email = email
        self.recipeName = recipeName
        self.recipeTime = recipeTime
        self.introduction = introduction
        self.mainFileExtension = mainFileExtension
        self.foodIngredients = foodIngredients
        self.cookingType = cookingType
        self.recipeProcess = recipeProcess
    }
}

struct RecipeProcessDTO: Codable {
    
    var toDictionary: [String: Any] {
        let dict: [String: Any] = [
            "stepNum": stepNum,
            "recipeWriting": recipeWriting,
            "fileExtension": fileExtension
        ]
        return dict
    }
    
    let stepNum: Int
    let recipeWriting, fileExtension: String
    
    init(query: RecipeProcess) {
        self.stepNum = query.stepNum
        self.recipeWriting = query.recipeWriting
        self.fileExtension = query.fileExtension
    }
    
    init(stepNum: Int, recipeWriting: String, fileExtension: String) {
        self.stepNum = stepNum
        self.recipeWriting = recipeWriting
        self.fileExtension = fileExtension
    }
}
