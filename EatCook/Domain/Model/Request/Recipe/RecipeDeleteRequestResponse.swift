//
//  RecipeDeleteRequestResponse.swift
//  EatCook
//
//  Created by 이명진 on 7/28/24.
//

import Foundation

struct RecipeDeleteRequestResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: String?
    
    init(success: Bool, code: String, message: String, data: String?) {
        self.success = success
        self.code = code
        self.message = message
        self.data = data
    }
}
