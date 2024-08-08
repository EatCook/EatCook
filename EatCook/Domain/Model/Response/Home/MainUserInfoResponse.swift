//
//  MainUserInfoResponse.swift
//  EatCook
//
//  Created by 강신규 on 8/8/24.
//

import Foundation

struct MainUserInfoResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: MainUserInfoData?
}

struct MainUserInfoData : Codable {
    let nickName: String?
    let userCookingTheme: [String : String]
    let lifeType : [String : String]
}
