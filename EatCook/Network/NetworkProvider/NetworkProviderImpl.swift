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
            let (data, _) = try await self.loadData(of: endpoint)
            
            if data.isEmpty {
                if let emptyResponse = EmptyResponse() as? T {
                    return .success(emptyResponse)
                } else {
                    throw NetworkError.emptyData
                }
            }
            
            let decodedData = try await requestManager.decode(object, data)
            return .success(decodedData)
        } catch let error as NetworkError {
            throw error
        } catch let error {
            throw NetworkError.decoding(error)
        }
    }
    
    private func loadData(of endpoint: EndPoint , retrying: Bool = false) async throws -> (Data, HTTPURLResponse) {
        do {
            let urlRequest = try await requestManager.makeURLRequest(of: endpoint)
            let (data, response) = try await session.data(for: urlRequest)
            
            
            
            
            guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.noResponse }
            

            
            
            //          Error 400 처리
            
            
            
            
            //          Error 401 리프래시 토큰
            if httpResponse.statusCode == 401 {
                if !retrying {
                    try await refreshToken(endpoint: endpoint)
                    return try await loadData(of: endpoint, retrying: true)
                } else {
                    // 리프래시 토큰 세팅후 안되었다면은 로그인 다시하도록
                    throw NetworkError.unauthorized
                }
            }
            
            
            
            
            
            guard 200..<300 ~= httpResponse.statusCode else { throw httpResponseError(httpResponse) }
            //          JWT Access Token, Refesh Token Setting
            self.receiveHeader(response: httpResponse)
            return (data, httpResponse)
        } catch let error as NetworkError {
            throw error
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
    
    private func receiveHeader(response: HTTPURLResponse) {
        
//        print("Header Check :",response.allHeaderFields )
        if let refreshToken = response.allHeaderFields[DataStorageKey.Authorization_REFRESH] as? String {
            DataStorage.shared.setString(refreshToken, forKey: DataStorageKey.Authorization_REFRESH)
        }
        
        if let accessToken = response.allHeaderFields[DataStorageKey.Authorization] as? String {
            DataStorage.shared.setString(accessToken, forKey: DataStorageKey.Authorization)
        }
    }
    
    private func refreshToken(endpoint : EndPoint) async throws {
        let refreshEndpoint = ModifiableEndPoint(endpoint: endpoint, additionalHeaders: HTTPHeaderField.refreshTokenHeader)
        
        let urlRequest = try await requestManager.makeURLRequest(of: refreshEndpoint)
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            print("리프래쉬 실패 로그인 페이지로 넘겨")
            throw NetworkError.unauthorized
        }
        print("리프레쉬 토큰 성공!!!!!!!!!!")
        self.receiveHeader(response: httpResponse)
    }
    
    
}




struct EmptyResponse: Codable { }
