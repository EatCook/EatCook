//
//  MyFavoriteTagRequestDTO.swift
//  EatCook
//
//  Created by 이명진 on 7/28/24.
//

import Foundation

struct MyFavoriteTagRequestDTO: Codable {
    
    var toDictionary: [String: Any] {
        let dict: [String: Any] = [
            "lifeType": lifeType,
            "cookingTypes": cookingTypes
        ]
        return dict
    }
    
    let lifeType: String
    let cookingTypes: [String]
    
    init(query: MyFavoriteTagRequest) {
        self.lifeType = query.lifeType
        self.cookingTypes = query.cookingTypes
    }
    
    init(
        lifeType: String,
        cookingTypes: [String]
    ) {
        self.lifeType = lifeType
        self.cookingTypes = cookingTypes
    }
    
}

