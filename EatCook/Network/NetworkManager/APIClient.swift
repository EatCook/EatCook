//
//  APIClient.swift
//  EatCook
//
//  Created by 강신규 on 5/17/24.
//

import Foundation


enum HTTPStatus: Int {
    // Success Response
    case Ok = 200
    
    // Client Error Response
    case BasRequest = 400
    case Unauthorized = 401
    case Forbidden = 403
    case NotFound = 404
    case RequestTimeout = 408
    case Conflict = 409
    
    // Server Error Response
    case InternalServerError = 500
    case ServiceUnavailable = 503
    
    var errorMessage: String {
        switch self {
        case .Ok: return ""
            
        case .BasRequest: return ""
        case .Unauthorized: return ""
        case .Forbidden: return ""
        case .NotFound: return ""
        case .RequestTimeout: return ""
        case .Conflict: return ""
            
        case .InternalServerError: return ""
        case .ServiceUnavailable: return ""
        }
    }
}

class APIClient {
    
    var baseUrl: URL?
    
    static let shared = { APIClient(baseUrl: "http://52.79.243.219:8080") }()
    
    required init(baseUrl: String) {
        self.baseUrl = URL(string: baseUrl)
    }
    
    func request<T : Decodable>(_ url : String , method : HTTPMethod = .get , parameters : [String : Any]? = nil , responseType : T.Type, successHandler : @escaping (BaseStruct<T>) -> Void , failureHandler : @escaping (BaseError) -> ()) {
        
        guard let url = URL(string: url, relativeTo: self.baseUrl) else {
            print("URL ERROR")
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = addHeader()
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let parameters = parameters {
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
        }

        
        let task = URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
            
            if let responseBody = String(data: data!, encoding: .utf8) {
                print("Response body: \(responseBody)")
            } else {
                print("Failed to convert data to string")
            }
            
            if let error = error {
                
//                DispatchQueue.main.async {
//                    failureHandler(BaseError(code: "500",
//                                             message: error.localizedDescription))
//                }
                return
            }
            
            if let response = response as? HTTPURLResponse {
                self.receiveHeader(response: response)
                
                // HTTPStatus 200 OK
                guard response.statusCode == HTTPStatus.Ok.rawValue else {
                    
                    guard let data = data,
                          let decode = try? JSONDecoder().decode(BaseStruct<T>.self, from: data) else {
                        DispatchQueue.main.async {
                            failureHandler(BaseError(code: "\(response.statusCode)",
                                                 message: "통신중 오류가 발생하였습니다."))
                        }
                        return
                    }
                    
//                    DispatchQueue.main.async {
//                        failureHandler(BaseError(code: "\(response.statusCode)",
//                                                 message: decode.error.message))
//                    }
                    return
                }
                
                guard let data = data else {
//                    DispatchQueue.main.async {
//                        failureHandler(BaseError(code: "\(response.statusCode)",
//                                             message: "Data Error"))
//                    }
                    return
                }
                
                guard let decode = try? JSONDecoder().decode(BaseStruct<T>.self, from: data) else {
//                    DispatchQueue.main.async {
//                        failureHandler(BaseError(code: "\(response.statusCode)",
//                                             message: "Decode Error"))
//                    }
                    return
                }
                
                
                // OK, Failed
                if decode.success {
                    DispatchQueue.main.async {
                        successHandler(decode)
                    }
                } else {
//                    DispatchQueue.main.async {
//                        failureHandler(decode.error)
//                    }
                }
            }
        }
        task.resume()
        
        
        
        
        
    }
    
    
    
    private func addHeader() -> [String: String] {
        var header: [String:String] = [:]
        header["Accept"] = "application/json"
        header["User-Agent"] = "iPhone"
//        TODO : JWT TOKEN SETTING
//        header["Authorization-jwt"] = "Bearer \(JWTUtil.accessToken)"
        return header
    }
  
    
//   TODO : JWT TOKEN SETTING
    private func receiveHeader(response: HTTPURLResponse) {
        
//        if let refreshToken = response.allHeaderFields[DataStorageKey.JWT_REFRESH_TOKEN] as? String {
//            DataStorage.shared.setString(refreshToken, forKey: DataStorageKey.JWT_REFRESH_TOKEN)
//        }
//        
//        if let accessToken = response.allHeaderFields[DataStorageKey.JWT_ACCESS_TOKEN] as? String {
//            DataStorage.shared.setString(accessToken, forKey: DataStorageKey.JWT_ACCESS_TOKEN)
//        }
    }
    
    
    
}
