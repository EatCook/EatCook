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
    let data: MainUserInfoDataDTO?
}

struct MainUserInfoDataDTO : Codable {
    let nickName: String?
    let userCookingTheme: [String : String]
    let lifeType : [String : String]
}


extension MainUserInfoResponseDTO {
    func toDomain() -> MainUserInfoResponse {
        return .init(success: success, code: code, message: message, data: data?.toDomain())
    }
}



extension MainUserInfoDataDTO {
    func toDomain() -> MainUserInfoData {
        return .init(nickName: nickName, userCookingTheme: userCookingTheme, lifeType: lifeType)
    }
    
    
}
