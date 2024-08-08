//
//  NetworkManager.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import Foundation

final class NetworkManager: URLRequestable {
    func makeURLRequest(of endpoint: EndPoint) async throws -> URLRequest {
        guard let url = URL(string: Environment.BaseURL + endpoint.path) else { throw NetworkError.notValidURL }
        var request = URLRequest(url: url)
        
        request.httpMethod = endpoint.httpMethod.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        switch endpoint.httpTask {
        case .requestWithParameters(let parameters, let encoding):
            if encoding == .jsonEncoding {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = jsonData
            } else if encoding == .urlEncoding {
                let queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)")}
                if var urlComponents = URLComponents(string: Environment.BaseURL + endpoint.path) {
                    urlComponents.queryItems = queryItems
                    request.url = urlComponents.url
                }
            }
        case .requestWithHeaders(let headers):
            guard let headers = headers else { throw NetworkError.unknown }
            request.allHTTPHeaderFields = headers as? [String: String]
        }
        return request
    }
    
    func decode<T: Decodable>(_ object: T.Type, _ data: Data) async throws -> T {
        do {
            return try JSONDecoder().decode(object, from: data)
        } catch {
            throw NetworkError.decoding(error)
        }
    }
}
