//
//  MainUserInfoResponseDTO.swift
//  EatCook
//
//  Created by 강신규 on 7/30/24.
//

import Foundation

struct MainUserInfoResponseDTO: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: UserInfoData?
}

struct UserInfoData : Codable {
    let nickName: String?
    let userCookingTheme: [String : String]
    let lifeType : [String : String]
}
