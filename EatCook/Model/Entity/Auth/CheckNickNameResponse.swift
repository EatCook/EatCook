//
//  CheckNickNameResponse.swift
//  EatCook
//
//  Created by 강신규 on 7/23/24.
//

import Foundation

struct CheckNickNameResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: String?
}
