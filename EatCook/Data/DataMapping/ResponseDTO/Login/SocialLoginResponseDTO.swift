//
//  SocialLoginResponseDTO.swift
//  EatCook
//
//  Created by 강신규 on 8/9/24.
//

import Foundation

struct SocialLoginResponseDTO : Codable {
    let success: Bool
    let code: String
    let message: String
    let data: String?
}


extension SocialLoginResponseDTO {
    func toDomain() -> SocialLoginResponse {
        return .init(success: success, code: code, message: message, data: data)
    }
}
