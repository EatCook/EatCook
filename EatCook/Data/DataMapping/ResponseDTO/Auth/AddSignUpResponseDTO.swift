//
//  AddSignUpResponseDTO.swift
//  EatCook
//
//  Created by 강신규 on 8/12/24.
//

import Foundation

struct AddSignUpResponseDTO: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: AddSignUpResponseDataDTO
}

struct AddSignUpResponseDataDTO : Codable {
    let presignedUrl : String
}


extension AddSignUpResponseDTO {
    func toDomain() -> AddSignUpResponse {
        return .init(success: success, code: code, message: message, data: data.toDomain())
    }
    
}

extension AddSignUpResponseDataDTO  {
    func toDomain() -> AddSignUpResponseData {
        .init(presignedUrl: presignedUrl)
    }
}
