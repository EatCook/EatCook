//
//  MyFavoriteTagResponseDTO.swift
//  EatCook
//
//  Created by 이명진 on 7/28/24.
//

import Foundation

struct MyFavoriteCookResponseDTO: Codable {
    let success: Bool
    let code, message: String
    let data: MyFavoriteCookResponseDataDTO
}

struct MyFavoriteCookResponseDataDTO: Codable {
    let lifeType: String?
    let cookingTypes: [String]
    
    init(lifeType: String? = nil, cookingTypes: [String]) {
        self.lifeType = lifeType
        self.cookingTypes = cookingTypes
    }
}

extension MyFavoriteCookResponseDTO {
    func toDomain() -> MyFavoriteCookResponse {
        return .init(
            success: success,
            code: code,
            message: message,
            data: data.toDomain()
        )
    }
}

extension MyFavoriteCookResponseDataDTO {
    func toDomain() -> MyFavoriteCookResponseData {
        return .init(
            lifeType: lifeType ?? "",
            cookingTypes: cookingTypes
        )
    }
}
