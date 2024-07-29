//
//  MyFavoriteTagRequest.swift
//  EatCook
//
//  Created by 이명진 on 7/28/24.
//

import Foundation

struct MyFavoriteTagRequest: Codable {
    var lifeType: String = ""
    var cookingTypes: [String] = []
}

extension MyFavoriteTagRequest {
    func toData() -> MyFavoriteTagRequestDTO {
        return .init(
            lifeType: lifeType,
            cookingTypes: cookingTypes
        )
    }
}

struct MyFavoriteTagRequestResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: String?
    
    init(success: Bool, code: String, message: String, data: String? = nil) {
        self.success = success
        self.code = code
        self.message = message
        self.data = data
    }
}
