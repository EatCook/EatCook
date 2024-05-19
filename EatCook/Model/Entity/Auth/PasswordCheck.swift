//
//  PasswordCheck.swift
//  EatCook
//
//  Created by 강신규 on 5/19/24.
//

import Foundation

struct PasswordCheck: Codable {
    let success: Bool
    let code: String
    let message: String
//    let validation : Any?
    let data: String? // 데이터의 타입에 따라 적절히 수정 가능
}
