//
//  BaseStruct.swift
//  EatCook
//
//  Created by 강신규 on 5/17/24.
//

import Foundation

/**
 Codable
 http://minsone.github.io/programming/swift-codable-and-exceptions-extension
*/
struct BaseStruct<T: Decodable>: Decodable {
    
    var success : Bool
    var code : String
    var message : String
//    var error: BaseError
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case code = "code"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let valeus = try decoder.container(keyedBy: CodingKeys.self)

        success = try valeus.decode(Bool.self, forKey: .success)
        code = try valeus.decode(String.self, forKey: .code)
        message = try valeus.decode(String.self, forKey: .message)
        data = try valeus.decodeIfPresent(T.self, forKey: .data)
//        error = try valeus.decode(BaseError.self, forKey: .error)

    }
}

struct BaseError: Decodable {
    var code: String
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case message = "message"
    }
    
    init(code: String, message: String) {
        self.code = code
        self.message = message
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        code = try values.decode(String.self, forKey: .code)
        message = try values.decode(String.self, forKey: .message)
    }
}
