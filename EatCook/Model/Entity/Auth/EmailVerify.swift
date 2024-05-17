//
//  EmailVerify.swift
//  EatCook
//
//  Created by 강신규 on 5/17/24.
//

import Foundation

struct EmailVerifyData: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: String? // 데이터의 타입에 따라 적절히 수정 가능
}
