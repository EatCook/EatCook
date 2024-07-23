//
//  MyPageProfileEditRequestResponseDTO.swift
//  EatCook
//
//  Created by 이명진 on 7/23/24.
//

import Foundation

struct MyPageProfileEditRequestResponseDTO: Codable {
    let success: Bool
    let code, message: String
    let data: [MyPageProfileEditRequestResponseDataDTO]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        success = try container.decode(Bool.self, forKey: .success)
        code = try container.decode(String.self, forKey: .code)
        message = try container.decode(String.self, forKey: .message)
        data = try container.decodeIfPresent([MyPageProfileEditRequestResponseDataDTO].self, forKey: .data) ?? []
    }
}

struct MyPageProfileEditRequestResponseDataDTO: Codable {
    
}

extension MyPageProfileEditRequestResponseDTO {
    func toDomain() -> MyPageProfileEditRequestResponse {
        return .init(success: success,
                     code: code,
                     message: message,
                     data: data?.map { $0.toDomain() } ?? [])
    }
}

extension MyPageProfileEditRequestResponseDataDTO {
    func toDomain() -> MyPageProfileEditRequestResponseData {
        return .init()
    }
}
