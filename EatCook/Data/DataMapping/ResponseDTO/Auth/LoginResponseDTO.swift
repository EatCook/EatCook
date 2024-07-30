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
