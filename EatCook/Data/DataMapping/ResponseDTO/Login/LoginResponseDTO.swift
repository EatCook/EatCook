//
//  LoginResponseDTO.swift
//  EatCook
//
//  Created by 강신규 on 7/30/24.
//

import Foundation

struct LoginResponseDTO: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: String?
}


extension LoginResponseDTO {
    func toDomain() -> LoginResponse {
        return .init(success: success, code: code, message: message, data: data)
    }
}
