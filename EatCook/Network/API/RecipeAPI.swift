//
//  RecipeAPI.swift
//  EatCook
//
//  Created by 이명진 on 7/16/24.
//

import Foundation

enum RecipeAPI: EndPoint {
    case recipeRead(_ postId: Int)
    case recipeCreate(_ query: RecipeCreateRequestDTO)
    case recipeUpdate(_ query: RecipeCreateRequestDTO)
    case recipeDelete(_ postId: Int)
    
    var path: String {
        switch self {
        case .recipeCreate:
            return "/api/v1/recipe/create"
        case .recipeUpdate:
            return "/api/v1/recipe/update"
        case .recipeDelete:
            return "/api/v1/recipe/delete"
        case .recipeRead:
            return "/api/v1/recipe/read"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .recipeCreate, .recipeUpdate, .recipeDelete:
            return .post
        case .recipeRead:
            return .get
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .recipeCreate(let query):
            return .requestWithParameters(
                parameters: query.toDictionary,
                encoding: .jsonEncoding
            )
        case .recipeUpdate(let query):
            return .requestWithParameters(
                parameters: query.toDictionary,
                encoding: .jsonEncoding
            )
        case .recipeDelete(let postId):
            return .requestWithParameters(
                parameters: ["postId": postId],
                encoding: .jsonEncoding
            )
        case .recipeRead(let postId):
            return .requestWithParameters(
                parameters: ["postId": postId],
                encoding: .urlEncoding)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .recipeCreate, .recipeUpdate, .recipeDelete, .recipeRead:
            return HTTPHeaderField.default
        }
    }
    
    
}
