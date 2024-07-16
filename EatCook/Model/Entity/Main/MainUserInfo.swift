//
//  MainUserInfo.swift
//  EatCook
//
//  Created by 강신규 on 7/15/24.
//

import Foundation

struct MainUserInfo: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: UserInfoData
}

struct UserInfoData : Codable {
    let nickName: String?
    let userCookingTheme: [String : String]
    let lifeType : [String : String]
}
