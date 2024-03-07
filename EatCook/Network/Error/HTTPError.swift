//
//  HTTPError.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import Foundation

enum HTTPError: Error {
    case specific(Error)
    case unknown
    case noResponse
    case unauthorized
    case noUser
    case serverError
    case badRequest
    case decodingError
    case requestFail
}
