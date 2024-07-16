//
//  MainUserInfoResponseDTO.swift
//  EatCook
//
//  Created by 강신규 on 7/16/24.
//

import Foundation

struct MainUserInfoResponseDTO : Codable {
    let success: Bool
    let code: String
    let message: String
    let data: UserInfoResponseDataDTO
}

struct UserInfoResponseDataDTO : Codable {
    let nickName: String?
    let userCookingTheme: [String : String]
    let lifeType : [String : String]
}


extension MainUserInfoResponseDTO {
    func toDomain() -> MainUserInfoResponse {
        return .init(success: success, code: code, message: message, data: data.toDomain())
    }
    
}

extension UserInfoResponseDataDTO {
    func toDomain() -> UserInfoResponseData {
        return .init(nickName: nickName, userCookingTheme: userCookingTheme, lifeType: lifeType)
    }
}


