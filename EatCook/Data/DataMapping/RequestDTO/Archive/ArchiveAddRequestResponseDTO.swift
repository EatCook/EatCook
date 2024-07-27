//
//  ArchiveAddRequestResponseDTO.swift
//  EatCook
//
//  Created by 이명진 on 7/22/24.
//

import Foundation

struct ArchiveAddRequestResponseDTO: Codable {
    let success: Bool
    let code, message: String
    let data: [ArchiveAddRequestResponseDataDTO]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        success = try container.decode(Bool.self, forKey: .success)
        code = try container.decode(String.self, forKey: .code)
        message = try container.decode(String.self, forKey: .message)
        data = try container.decodeIfPresent([ArchiveAddRequestResponseDataDTO].self, forKey: .data) ?? []
    }
}

struct ArchiveAddRequestResponseDataDTO: Codable {
    
}

extension ArchiveAddRequestResponseDTO {
    func toDomain() -> ArchiveAddRequestResponse {
        return .init(success: success,
                     code: code,
                     message: message,
                     data: data?.map { $0.toDomain() } ?? [])
    }
}

extension ArchiveAddRequestResponseDataDTO {
    func toDomain() -> ArchiveAddRequestResponseData {
        return .init()
    }
}
