//
//  NetworkProvider.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import Foundation

protocol NetworkProvider: AnyObject {
    func excute<T: Decodable>(_ object: T.Type, of endpoint: EndPoint) async throws -> Result<T, NetworkError>
}
