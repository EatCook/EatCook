//
//  NetworkProviderImpl.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import Foundation

final class NetworkProviderImpl: NetworkProvider {
    
    private let session: URLSession
    private let requestManager: URLRequestable
    
    init(
        session: URLSession = .shared,
        requestManager: URLRequestable
    ) {
        self.session = session
        self.requestManager = requestManager
    }
    
    func excute<T: Decodable>(_ object: T.Type, of endpoint: EndPoint) async throws -> Result<T, NetworkError> {
        do {
            let data = try await self.loadData(of: endpoint)
            let decodedData = try await requestManager.decode(object, data)
            return .success(decodedData)
        } catch let error {
            throw NetworkError.decoding(error)
        }
    }
    
    private func loadData(of endpoint: EndPoint) async throws -> Data {
        do {
            let urlRequest = try await requestManager.makeURLRequest(of: endpoint)
            let (data, response) = try await session.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.noResponse }
            
            guard 200..<300 ~= httpResponse.statusCode else { throw httpResponseError(httpResponse) }
            
            return data
        } catch {
            throw HTTPError.requestFail
        }
        
    }
    
    private func httpResponseError(_ response: HTTPURLResponse) -> HTTPError {
        switch response.statusCode {
        case 401: return .unauthorized
        case 406: return .noUser
        case 500: return .serverError
        case 501: return .badRequest
        default: return .unknown
        }
    }
}
