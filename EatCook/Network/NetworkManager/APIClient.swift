//
//  APIClient.swift
//  EatCook
//
//  Created by 강신규 on 7/30/24.
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
    var isRefreshingToken = false
    
    static let shared = { APIClient(baseUrl: Environment.BaseURL) }()
    
    required init(baseUrl: String) {
        self.baseUrl = URL(string: baseUrl)
    }
    
    func request<T : Decodable>(_ url : String , method : HTTPMethod = .get , parameters : [String : Any]? = nil , responseType : T.Type, successHandler : @escaping (T) -> Void , failureHandler : @escaping (T) -> ()) {
        let strURL = url
        
        guard let url = URL(string: url, relativeTo: self.baseUrl) else {
            print("URL ERROR")
            return
        }
        
        print(url)
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = addHeader()
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let token = DataStorage.shared.getString(forKey: DataStorageKey.Authorization)
        print("token ::::" , token)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        if let parameters = parameters {
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
        }

        
        let task = URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
            
            if let responseBody = String(data: data ?? Data(), encoding: .utf8) {
                print("Response body: \(responseBody)")
            } else {
                print("Failed to convert data to string")
            }
            
            if let error = error {
               
                
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("response.statusCode::", response.statusCode)
                self.receiveHeader(response: response)
                
                switch response.statusCode {
                case 200 , 400 :
                    guard let data = data else {
                        print("DATA ERROR")
                        return
                    }
                    guard let decode = try? JSONDecoder().decode(T.self, from: data) else {
                        print("DECODE ERROR")
                        return
                    }
                    // OK, Failed
                    successHandler(decode)
                    
                case 401 :
                    self.refreshToken(url: url , parameters: parameters , method: method) { success in
                        if success {
                            self.request(strURL, method: method, parameters: parameters, responseType: responseType, successHandler: successHandler, failureHandler: failureHandler)
                        } else {
                            print("REFRESH ERROR")
//                            TODO : GOTO LOGIN MENU
//                            failureHandler(.Unauthorized)
                        }
                    }
                    
                    
                default:
                    print("토큰 리프레시 상태코드 : \(response)")
                }
                
            }
        }
        task.resume()
        
        
        
        
        
    }
    
    
    
    private func addHeader() -> [String: String] {
        var header: [String:String] = [:]
        header["Accept"] = "application/json"
        header["User-Agent"] = "iPhone"
        return header
    }
  
    
//   TODO : JWT TOKEN SETTING
    private func receiveHeader(response: HTTPURLResponse) {
        
        print("Header Check :",response.allHeaderFields )
        if let refreshToken = response.allHeaderFields[DataStorageKey.Authorization_REFRESH] as? String {
            DataStorage.shared.setString(refreshToken, forKey: DataStorageKey.Authorization_REFRESH)
        }
        
        if let accessToken = response.allHeaderFields[DataStorageKey.Authorization] as? String {
            DataStorage.shared.setString(accessToken, forKey: DataStorageKey.Authorization)
        }
    }
    
    private func refreshToken(url : URL , parameters : [String : Any]? ,  method : HTTPMethod  ,completion: @escaping (Bool) -> Void) {
        guard !isRefreshingToken else {
            completion(false)
            return
        }
        
        print("First Token Refresh")
        isRefreshingToken = true
        
        let refreshToken = DataStorage.shared.getString(forKey: DataStorageKey.Authorization_REFRESH)
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = addHeader()
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let token = DataStorage.shared.getString(forKey: DataStorageKey.Authorization)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization-refresh")
        if let parameters = parameters {
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.isRefreshingToken = false
            
            if let error = error {
                print("Token refresh error: \(error)")
                completion(false)
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                self.receiveHeader(response: response)
                completion(true)
            } else {
                completion(false)
            }
        }
        task.resume()
    }
    
    
    

}
