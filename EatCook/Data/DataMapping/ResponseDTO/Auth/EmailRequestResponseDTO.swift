//
//  EmailRequestResponseDTO.swift
//  EatCook
//
//  Created by 강신규 on 7/30/24.
//

import Foundation

struct EmailRequestResponseDTO: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: String?
}

