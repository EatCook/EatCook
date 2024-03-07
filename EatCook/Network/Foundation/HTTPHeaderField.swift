//
//  HTTPHeaderField.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import Foundation

enum HTTPHeaderField: String{
    case contentType = "Content-Type"
    case idToken = "idtoken"
    case apikey = "api_key"
}

enum ContentType: String {
    case urlEncoded = "application/x-www-form-urlencoded"
    case json = "application/json"
    case multipart = "multipart/form-data"
}

extension HTTPHeaderField {
    
    static var `default`: [String: String] {
        var dict: [String: String] = [:]
        dict[HTTPHeaderField.contentType.rawValue] = ContentType.json.rawValue
//        dict[HTTPHeaderField.idToken.rawValue] = "afsfdfdffAsdf"
//        dict[HTTPHeaderField.apikey.rawValue] = APIKey.TMDB
        return dict
    }
}