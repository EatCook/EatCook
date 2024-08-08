//
//  SearchMenuResponseDTO.swift
//  EatCook
//
//  Created by 강신규 on 7/31/24.
//

import Foundation

struct SearchMenuResponseDTO: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: [SearchMenuData] // 데이터의 타입에 따라 적절히 수정 가능
}

struct SearchMenuData : Codable {
    
    let postId: Int
    let recipeName: String
    let introduction : String
    let imageFilePath : String
    let likeCount : Int
    let foodIngredients : [String]
    let userNickName : String?
}
