//
//  OtherUserInfoResponseDTO.swift
//  EatCook
//
//  Created by 이명진 on 7/28/24.
//

import Foundation

struct OtherUserInfoResponseDTO: Codable {
    let success: Bool
    let code, message: String
    let data: OtherUserInfoResponseDataDTO
}

struct OtherUserInfoResponseDataDTO: Codable {
    let userId: Int
    let email, userImagePath, nickName, badge: String
    let followerCounts: Int
    let followCheck: Bool
    let postCounts: Int
}

extension OtherUserInfoResponseDTO {
    func toDomain() -> OtherUserInfoResponse {
        return .init(
            success: success,
            code: code,
            message: message,
            data: data.toDomain()
        )
    }
}

extension OtherUserInfoResponseDataDTO {
    func toDomain() -> OtherUserInfoResponseData {
        return .init(
            userId: userId,
            email: email,
            userImagePath: userImagePath,
            nickName: nickName,
            badge: badge,
            followerCounts: followerCounts,
            followCheck: followCheck,
            postCounts: postCounts
        )
    }
}
