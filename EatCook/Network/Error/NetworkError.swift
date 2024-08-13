//
//  NetworkError.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import Foundation

enum NetworkError: Error {
    case unknown
    case components
    case urlRequest(Error)
    case notValidURL
    case noResponse
    case server(InternalError)
    case emptyData
    case unauthorized
    case parsing
    case customError(String)
    case decoding(Error)
    
}

enum InternalError: Int {
    case invalidToken = 401
    case noUser = 406
    case internalServerError = 500
    case clientError = 501
    case unknown
}
