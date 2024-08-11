//
//  EmailVerifyResponse.swift
//  EatCook
//
//  Created by 강신규 on 8/11/24.
//

import Foundation

struct EmailVerifyResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: String?
}
