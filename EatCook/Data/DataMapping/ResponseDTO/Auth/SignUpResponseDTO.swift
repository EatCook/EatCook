//
//  SignUpResponseDTO.swift
//  EatCook
//
//  Created by 강신규 on 8/11/24.
//

import Foundation

struct SignUpResponseDTO: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: String?
}


extension SignUpResponseDTO {
    func toDomain() -> SignUpResponse {
        return .init(success: success, code: code, message: message, data: data)
    }
}
