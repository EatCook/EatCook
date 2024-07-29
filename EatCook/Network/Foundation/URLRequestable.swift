//
//  URLRequestable.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import Foundation

protocol URLRequestable: AnyObject {
    func makeURLRequest(of: EndPoint) async throws -> URLRequest
    func decode<T: Decodable>(_ object: T.Type, _ data: Data) async throws -> T
}

