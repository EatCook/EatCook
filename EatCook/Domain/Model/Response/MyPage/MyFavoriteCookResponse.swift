//
//  MyFavoriteCookResponse.swift
//  EatCook
//
//  Created by 이명진 on 7/28/24.
//

import Foundation

struct MyFavoriteCookResponse: Codable {
    var success: Bool = false
    var code: String = ""
    var message: String = ""
    var data = MyFavoriteCookResponseData()
}

struct MyFavoriteCookResponseData: Codable, Identifiable {
    var lifeType: String = ""
    var cookingTypes: [String] = []
    
    var id: String = UUID().uuidString
}

struct UserWithDrawResponse: Codable {
    var success: Bool = false
    var code: String = ""
    var message: String = ""
    var data = UserWithDrawResponseData()
}

struct UserWithDrawResponseData: Codable {
    
}
