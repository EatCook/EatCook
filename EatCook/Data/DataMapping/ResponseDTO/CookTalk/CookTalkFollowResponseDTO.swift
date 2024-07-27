//
//  CookTalkFollowResponseDTO.swift
//  EatCook
//
//  Created by 이명진 on 7/15/24.
//

import Foundation

struct CookTalkFollowResponseDTO: Codable {
    let success: Bool
    let code, message: String
    let data: CookTalkFollowResponseDataDTO
}

struct CookTalkFollowResponseDataDTO: Codable {
    let nextPageValid: Bool
    let totalElements, totalPages: Int
    let cookTalkDtoList: [CookTalkFollowResponseListDTO]
}

struct CookTalkFollowResponseListDTO: Codable {
    let postID: Int
    let introduction, postImagePath, createdAt, lastModifiedAt: String
    let userID: Int
    let nickName: String
    let profile: String?
    let likeCount: Int
    let likedCheck, followCheck: Bool

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case introduction, postImagePath, createdAt, lastModifiedAt
        case userID = "userId"
        case nickName, profile, likeCount, likedCheck, followCheck
    }
}

extension CookTalkFollowResponseDTO {
    func toDomain() -> CookTalkFollowResponse {
        return .init(success: success,
                     code: code,
                     message: message,
                     data: data.toDomain())
    }
}

extension CookTalkFollowResponseDataDTO {
    func toDomain() -> CookTalkFollowResponseData {
        return .init(nextPageValid: nextPageValid,
                     totalElements: totalElements,
                     totalPages: totalPages,
                     cookTalkDtoList: cookTalkDtoList.map { $0.toDomain() })
    }
}

extension CookTalkFollowResponseListDTO {
    func toDomain() -> CookTalkFollowResponseList {
        return .init(postID: postID,
                     introduction: introduction,
                     postImagePath: postImagePath,
                     createdAt: createdAt,
                     lastModifiedAt: lastModifiedAt,
                     userID: userID,
                     nickName: nickName,
                     profile: profile,
                     likeCount: likeCount,
                     likedCheck: likedCheck,
                     followCheck: followCheck)
    }
}
