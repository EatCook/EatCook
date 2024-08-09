//
//  SocialLoginResponse.swift
//  EatCook
//
//  Created by 강신규 on 8/9/24.
//

import Foundation

struct SocialLoginResponse : Codable {
    let success: Bool
    let code: String
    let message: String
    let data: String?
}
