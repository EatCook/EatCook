//
//  ModifiableEndPoint.swift
//  EatCook
//
//  Created by 강신규 on 8/7/24.
//

import Foundation

struct ModifiableEndPoint: EndPoint {
    var path: String
    var httpMethod: HTTPMethod
    var httpTask: HTTPTask
    var headers: [String: String]?
    
    init(endpoint: EndPoint, additionalHeaders: [String: String]? = nil) {
        self.path = endpoint.path
        self.httpMethod = endpoint.httpMethod
        self.httpTask = endpoint.httpTask
        var mergedHeaders = endpoint.headers ?? [:]
        if let additionalHeaders = additionalHeaders {
            for (key, value) in additionalHeaders {
                mergedHeaders[key] = value
            }
        }
        self.headers = mergedHeaders
    }
}
