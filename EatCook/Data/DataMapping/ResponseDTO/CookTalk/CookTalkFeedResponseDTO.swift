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
    let hasNextPage: Bool
    let page, size, totalElements, totalPages: Int
    let content: [CookTalkFeedResponseListDTO]
}

struct CookTalkFeedResponseListDTO: Codable {
    let writerUserId: Int
    let writerUserEmail: String?
    let writerProfile: String?
    let writerNickname: String
    let postId: Int
    let recipeName: String
    let introduction, postImagePath, lastModifiedAt: String
    let likeCounts: Int
    let likedCheck, followCheck: Bool
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
        return .init(
            hasNextPage: hasNextPage,
            page: page,
            size: size,
            totalElements: totalElements,
            totalPages: totalPages,
            content: content.map { $0.toDomain() }
        )
    }
}

extension CookTalkFeedResponseListDTO {
    func toDomain() -> CookTalkFeedResponseList {
        return .init(
            writerUserId: writerUserId,
            writerUserEmail: writerUserEmail,
            writerProfile: writerProfile,
            writerNickname: writerNickname,
            postId: postId,
            recipeName: recipeName,
            introduction: introduction,
            postImagePath: postImagePath,
            lastModifiedAt: lastModifiedAt,
            likeCounts: likeCounts,
            likedCheck: likedCheck,
            followCheck: followCheck
        )
    }
}
