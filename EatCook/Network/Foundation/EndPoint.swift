//
//  EndPoint.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import Foundation

protocol EndPoint {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var httpTask: HTTPTask { get }
    var headers: [String: String]? { get }
}
