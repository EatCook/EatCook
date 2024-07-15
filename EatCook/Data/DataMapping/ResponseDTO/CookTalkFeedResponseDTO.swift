//
//  CookTalkFeedResponseDTO.swift
//  EatCook
//
//  Created by 이명진 on 7/15/24.
//

import Foundation

struct CookTalkFeedResponseDTO: Codable {
    let success: Bool
    let code, message: String
    let data: CookTalkFeedResponseDataDTO
}

struct CookTalkFeedResponseDataDTO: Codable {
    let nextPageValid: Bool
    let totalElements, totalPages: Int
    let cookTalkDtoList: [CookTalkFeedResponseListDTO]
}

struct CookTalkFeedResponseListDTO: Codable {
    let postID: Int
    let introduction, postImagePath, createdAt, lastModifiedAt: String
    let userID: Int
    let nickName, profile: String
    let likeCount: Int
    let likedCheck, followCheck: Bool

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case introduction, postImagePath, createdAt, lastModifiedAt
        case userID = "userId"
        case nickName, profile, likeCount, likedCheck, followCheck
    }
}

extension CookTalkFeedResponseDTO {
    func toDomain() -> CookTalkFeedResponse {
        return .init(success: success,
                     code: code,
                     message: message,
                     data: data.toDomain())
    }
}

extension CookTalkFeedResponseDataDTO {
    func toDomain() -> CookTalkFeedResponseData {
        return .init(nextPageValid: nextPageValid,
                     totalElements: totalElements,
                     totalPages: totalPages,
                     cookTalkDtoList: cookTalkDtoList.map { $0.toDomain() })
    }
}

extension CookTalkFeedResponseListDTO {
    func toDomain() -> CookTalkFeedResponseList {
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
