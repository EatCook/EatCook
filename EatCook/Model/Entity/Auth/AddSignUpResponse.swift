//
//  AddSignUpResponse.swift
//  EatCook
//
//  Created by 강신규 on 7/22/24.
//

import Foundation

struct AddSignUpResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: AddSignUpResponseData
}

struct AddSignUpResponseData : Codable {
    let presignedUrl : String
}
