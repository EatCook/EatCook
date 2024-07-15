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
    case jwtToken = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJlYXRjb29rIiwic3ViIjoiYWNjZXNzLXRva2VuIiwiaWF0IjoxNzIxMDU5NjU1LCJ1c2VybmFtZSI6Iml0Y29va0BnbWFpbC5jb20iLCJhdXRob3JpdGllcyI6WyJST0xFX1VTRVIiXSwiZXhwIjoxNzIxMDYxNDU1fQ.yyR7QZTxH_6c7XfjFmtKNatHQQFwS-bbF1E7FzPxa0Zb3NdQz83V53j3GsUB9ANWmTb6YIZ9uG7PQd06460KMQ"
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
