//
//  CheckNickNameResponseDTO.swift
//  EatCook
//
//  Created by 강신규 on 8/12/24.
//

import Foundation

struct CheckNickNameResponseDTO: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: String?
}

extension CheckNickNameResponseDTO {
    func toDomain() -> CheckNickNameResponse {
        return .init(success: success, code: code, message: message, data: data)
    }
    
}
