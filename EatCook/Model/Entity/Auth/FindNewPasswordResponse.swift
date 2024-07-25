//
//  FindNewPasswordResponse.swift
//  EatCook
//
//  Created by 강신규 on 7/25/24.
//

import Foundation

struct FindNewPasswordResponse : Codable {
    let success: Bool
    let code: String
    let message: String
    let data: String?
}
