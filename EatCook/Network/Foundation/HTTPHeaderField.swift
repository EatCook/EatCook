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
    case jwtToken = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJlYXRjb29rIiwic3ViIjoiYWNjZXNzLXRva2VuIiwiaWF0IjoxNzIxMTMzODUyLCJ1c2VybmFtZSI6Iml0Y29vazFAZ21haWwuY29tIiwiYXV0aG9yaXRpZXMiOlsiUk9MRV9VU0VSIl0sImV4cCI6MTcyMTEzNTY1Mn0.hW_4imV_djEXJiKz7k4CNF0W3MmCMVMNUBbFDkv2_lvWK0L6xrz6HILLRxcJlNcPkmBEyQAXFWW1qFdm9CmHZw"
    case multipart = "multipart/form-data"
}

extension HTTPHeaderField {
    
    static var `default`: [String: String] {
        var dict: [String: String] = [:]
        dict[HTTPHeaderField.contentType.rawValue] = ContentType.json.rawValue
        dict[HTTPHeaderField.authorization.rawValue] = ContentType.jwtToken.rawValue
        return dict
    }
}
