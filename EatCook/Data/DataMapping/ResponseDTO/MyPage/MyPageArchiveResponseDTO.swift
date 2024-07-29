//
//  MyPageArchiveResponseDTO.swift
//  EatCook
//
//  Created by 이명진 on 7/21/24.
//

import Foundation

struct MyPageArchiveResponseDTO: Codable {
    let success: Bool
    let code, message: String
    let data: [MyPageArchiveDataDTO]
}

struct MyPageArchiveDataDTO: Codable {
    let postId: Int
    let postImagePath: String
}

extension MyPageArchiveResponseDTO {
    func toDomain() -> MyPageArchiveResponse {
        return .init(success: success,
                     code: code,
                     message: message,
                     data: data.map { $0.toDomain() })
    }
}

extension MyPageArchiveDataDTO {
    func toDomain() -> MyPageArchiveData {
        return .init(postId: postId,
                     postImagePath: postImagePath)
    }
}
