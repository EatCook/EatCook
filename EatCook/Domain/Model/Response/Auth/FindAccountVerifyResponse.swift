//
//  FindAccountVerifyResponse.swift
//  EatCook
//
//  Created by 강신규 on 8/14/24.
//

import Foundation

struct FindAccountVerifyResponse : Codable {
    let success: Bool
    let code: String
    let message: String
    let data: String?
}

