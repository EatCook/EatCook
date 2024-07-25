//
//  MyPageResponseDTO.swift
//  EatCook
//
//  Created by 이명진 on 7/21/24.
//

import Foundation

struct MyPageResponseDTO: Codable {
    let success: Bool
    let code, message: String
    let data: MyPageDataResponseDTO
}

struct MyPageDataResponseDTO: Codable {
    let userId: Int
    let email, nickName, badge: String
    let followerCounts, followingCounts: Int
    let providerType: String
}

extension MyPageResponseDTO {
    func toDomain() -> MyPageResponse {
        return .init(success: success,
                     code: code,
                     message: message,
                     data: data.toDomain())
    }
}

extension MyPageDataResponseDTO {
    func toDomain() -> MyPageDataResponse {
        return .init(
            userId: userId,
            email: email,
            nickName: nickName,
            badge: badge,
            followerCounts: followerCounts,
            followingCounts: followingCounts,
            providerType: providerType
        )
    }
}
