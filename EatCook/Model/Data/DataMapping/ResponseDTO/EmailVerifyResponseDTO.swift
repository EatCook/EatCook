//
//  EmailVerifyResponseDTO.swift
//  EatCook
//
//  Created by 강신규 on 7/16/24.
//

import Foundation

struct EmailVerifyResponseDTO : Codable {
    let success: Bool
    let code: String
    let message: String
    let data: String?
}

extension EmailVerifyResponseDTO {
    func toDomain() -> EmailVerifyResponse {
        return .init(success: success, code: code, message: message, data: data)
    }
}
 
