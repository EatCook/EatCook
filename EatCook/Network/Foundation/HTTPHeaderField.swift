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
    case jwtToken = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJlYXRjb29rIiwic3ViIjoiYWNjZXNzLXRva2VuIiwiaWF0IjoxNzIyODY1OTIzLCJ1c2VybmFtZSI6Iml0Y29vazFAZ21haWwuY29tIiwiYXV0aG9yaXRpZXMiOlsiUk9MRV9VU0VSIl0sImV4cCI6MTcyMjk1MjMyM30.JuUaDNNpH0yPMk-SiPDP3etl-VquXTi61Xf-9cXoEIPHjJTDANjU3IIMu1MONGFcHPPmzMOky_uOXIehTPMgog"
    case multipart = "multipart/form-data"
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
