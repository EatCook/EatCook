//
//  MainUserInfoResponse.swift
//  EatCook
//
//  Created by 강신규 on 7/16/24.
//

import Foundation

struct MainUserInfoResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: UserInfoResponseData
}

struct UserInfoResponseData : Codable {
    let nickName: String?
    let userCookingTheme: [String : String]
    let lifeType : [String : String]
}
