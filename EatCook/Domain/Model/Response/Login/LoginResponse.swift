//
//  LoginResponse.swift
//  EatCook
//
//  Created by 강신규 on 8/7/24.
//

import Foundation

struct LoginResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: String?
}
