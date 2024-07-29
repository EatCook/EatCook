//
//  HTTPHeaderField.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import Foundation

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case authorization = "Authorization"
    case apikey = "api_key"
}

enum ContentType: String {
    case urlEncoded = "application/x-www-form-urlencoded"
    case json = "application/json"
    case jwtToken = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJlYXRjb29rIiwic3ViIjoiYWNjZXNzLXRva2VuIiwiaWF0IjoxNzIyMTczNDQ0LCJ1c2VybmFtZSI6Iml0Y29va0BnbWFpbC5jb20iLCJhdXRob3JpdGllcyI6WyJST0xFX1VTRVIiXSwiZXhwIjoxNzIyMjU5ODQ0fQ.DRf7ULQBeAw3jrG0um8D_BuyG5x8Ptny29ylgx6d9pLHYe9De0XeILFwKuG_0_62ZdY_wj6p1BIBEcNqqHVjKw"
    case multipart = "multipart/form-data"
    case jpg = "image/jpeg" // jpg, jpeg
    case png = "image/png"
}

extension HTTPHeaderField {
    
    static var `default`: [String: String] {
        var dict: [String: String] = [:]
        dict[HTTPHeaderField.contentType.rawValue] = ContentType.json.rawValue
        dict[HTTPHeaderField.authorization.rawValue] = ContentType.jwtToken.rawValue
        return dict
    }
    
    static var jpgImageUpload: [String: String] {
        var dict: [String: String] = [:]
        dict[HTTPHeaderField.contentType.rawValue] = ContentType.jpg.rawValue
        return dict
    }
    
    static var pngImageUpload: [String: String] {
        var dict: [String: String] = [:]
        dict[HTTPHeaderField.contentType.rawValue] = ContentType.png.rawValue
        return dict
    }
}
