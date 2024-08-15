//
//  RecipeAPI.swift
//  EatCook
//
//  Created by 이명진 on 7/16/24.
//

import Foundation

enum RecipeAPI: EndPoint {
    case recipeRead(_ recipeId: Int)
    case recipeCreate(_ query: RecipeCreateRequestDTO)
    case recipeUpdate(_ query: RecipeCreateRequestDTO, _ recipeId: Int)
    case recipeDelete(_ recipeId: Int)
    
    var path: String {
        switch self {
        case .recipeRead(let recipeId):
            return "/api/v1/recipes/\(recipeId)"
        case .recipeCreate:
            return "/api/v1/recipes"
        case .recipeUpdate(_, let recipeId):
            return "/api/v1/recipes/\(recipeId)"
        case .recipeDelete(let recipeId):
            return "/api/v1/recipes/\(recipeId)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .recipeRead:
            return .get
        case .recipeCreate:
            return .post
        case .recipeUpdate:
            return .patch
        case .recipeDelete:
            return .delete
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .recipeRead(let recipeId):
            return .requestWithParameters(
                parameters: ["recipeId": recipeId],
                encoding: .urlEncoding)
        case .recipeCreate(let query):
            return .requestWithParameters(
                parameters: query.toDictionary,
                encoding: .jsonEncoding
            )
        case .recipeUpdate(let query, _):
            return .requestWithParameters(
                parameters: query.toDictionary,
                encoding: .jsonEncoding
            )
        case .recipeDelete(let recipeId):
            return .requestWithParameters(
                parameters: ["recipeId": recipeId],
                encoding: .jsonEncoding
            )
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .recipeCreate, .recipeUpdate, .recipeDelete, .recipeRead:
            return HTTPHeaderField.default
        }
    }
    
    
}
