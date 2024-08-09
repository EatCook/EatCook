//
//  HTTPHeaderField.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import Foundation
import UIKit

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case authorization = "Authorization"
    case authorizationRefresh = "Authorization-refresh"
    case apikey = "api_key"
}

enum ContentType: String {
    case urlEncoded = "application/x-www-form-urlencoded"
    case json = "application/json"
    case jwtToken = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJlYXRjb29rIiwic3ViIjoiYWNjZXNzLXRva2VuIiwiaWF0IjoxNzIzMDQyODIxLCJ1c2VybmFtZSI6Iml0Y29vazFAZ21haWwuY29tIiwiYXV0aG9yaXRpZXMiOlsiUk9MRV9VU0VSIl0sImV4cCI6MTcyMzA0Mjg4MX0.-7vZ05B702Isd1k-31t-bOMcOdMCpfjLTyhkQRnpcuW7VV9RJJ1_Pe0JeKvYGCiV2JBvgHvwAs_TagsImeLmkg"
    case jpg = "image/jpeg" // jpg, jpeg
    case png = "image/png"
}

extension HTTPHeaderField {
    
    static var `default`: [String: String] {
        var dict: [String: String] = [:]
        dict[HTTPHeaderField.contentType.rawValue] = ContentType.json.rawValue
        dict[HTTPHeaderField.authorization.rawValue] = DataStorage.shared.getString(forKey: DataStorageKey.Authorization)
//        dict[HTTPHeaderField.authorization.rawValue] = ContentType.jwtToken.rawValue
        return dict
    }
    
    
    static var `refreshTokenHeader`: [String: String] {
        var dict: [String: String] = [:]
        dict[HTTPHeaderField.contentType.rawValue] = ContentType.json.rawValue
        dict[HTTPHeaderField.authorization.rawValue] = DataStorage.shared.getString(forKey: DataStorageKey.Authorization)
        dict[HTTPHeaderField.authorizationRefresh.rawValue] = DataStorage.shared.getString(forKey: DataStorageKey.Authorization_REFRESH)
        return dict
    }
    
    static var `loginHeader` : [String : String] {
        var dict : [String : String] = [:]
        dict[HTTPHeaderField.contentType.rawValue] = ContentType.json.rawValue
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
