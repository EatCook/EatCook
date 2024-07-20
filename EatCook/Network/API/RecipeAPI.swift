//
//  RecipeAPI.swift
//  EatCook
//
//  Created by 이명진 on 7/16/24.
//

import Foundation

enum RecipeAPI: EndPoint {
    case recipeCreate(_ query: RecipeCreateRequestDTO)
    case recipeDelete
    case recipeRead(_ postId: Int)
    
    var path: String {
        switch self {
        case .recipeCreate:
            return "/api/v1/recipe/create"
        case .recipeDelete:
            return "/api/v1/recipe/delete"
        case .recipeRead:
            return "/api/v1/recipe/read"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .recipeCreate, .recipeDelete:
            return .post
        case .recipeRead:
            return .get
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .recipeCreate(let query):
            return .requestWithParameters(parameters: query.toDictionary,
                                          encoding: .jsonEncoding)
        case .recipeDelete:
            return .requestWithParameters(parameters: [:], encoding: .urlEncoding)
        case .recipeRead(let postId):
            return .requestWithParameters(
                parameters: ["postId": postId],
                encoding: .urlEncoding)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .recipeCreate, .recipeDelete, .recipeRead:
            return HTTPHeaderField.default
        }
    }
    
    
}
