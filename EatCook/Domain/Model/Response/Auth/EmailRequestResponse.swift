//
//  EmailRequestResponse.swift
//  EatCook
//
//  Created by 강신규 on 8/11/24.
//

import Foundation

struct EmailRequestResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: String?
}

