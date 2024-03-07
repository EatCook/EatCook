//
//  LoginResponseDTO.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import Foundation

struct LoginResponseDTO: Decodable {
    
}

extension LoginResponseDTO {
    
    func toDomain() -> LoginResponse {
        return .init()
    }
}
