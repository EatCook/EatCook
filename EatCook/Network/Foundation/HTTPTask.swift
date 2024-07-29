//
//  HTTPTask.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import Foundation

enum HTTPTask {
    case requestWithParameters(parameters: [String: Any], encoding: ParameterEncoding)
    case requestWithHeaders(headers: [String: Any]?)
}

enum ParameterEncoding {
    case jsonEncoding
    case urlEncoding
}
