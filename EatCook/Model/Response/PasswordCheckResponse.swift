//
//  PasswordCheckResponse.swift
//  EatCook
//
//  Created by 강신규 on 7/16/24.
//

import Foundation

struct PasswordCheckResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: String?
}
