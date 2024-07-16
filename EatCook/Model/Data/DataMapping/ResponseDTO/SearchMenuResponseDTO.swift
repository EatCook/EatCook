//
//  SearchMenuResponseDTO.swift
//  EatCook
//
//  Created by 강신규 on 7/16/24.
//

import Foundation

struct SearchMenuResponseDTO : Codable {
    let success: Bool
    let code: String
    let message: String
    let data: [SearchMenuResponseDataDTO] // 데이터의 타입에 따라 적절히 수정 가능
}

struct SearchMenuResponseDataDTO : Codable {
    let postId: Int
    let recipeName: String
    let introduction : String
    let imageFilePath : String
    let likeCount : Int
    let foodIngredients : [String]
    let userNickName : String?
}


extension SearchMenuResponseDTO {
    func toDomain() -> SearchMenuResponse {
        return .init(success: success, code: code, message: message, data: data.map { $0.toDomain() })
    }
}

extension SearchMenuResponseDataDTO {
    func toDomain() -> SearchMenuResponseData {
        return .init(postId: postId, recipeName: recipeName, introduction: introduction, imageFilePath: imageFilePath, likeCount: likeCount, foodIngredients: foodIngredients, userNickName: userNickName)
    }
}
