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
    case jwtToken = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJlYXRjb29rIiwic3ViIjoiYWNjZXNzLXRva2VuIiwiaWF0IjoxNzIxOTA0MDcyLCJ1c2VybmFtZSI6Iml0Y29vazFAZ21haWwuY29tIiwiYXV0aG9yaXRpZXMiOlsiUk9MRV9VU0VSIl0sImV4cCI6MTcyMTk5MDQ3Mn0.4_xuvp46zyR2ZrGWm9pb_jBBrqHfE90wByrA1SsKfJQo4otr3dzrL_cMVVCLfkcyPxPkS10Zj1woEGk363aUKw"
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
