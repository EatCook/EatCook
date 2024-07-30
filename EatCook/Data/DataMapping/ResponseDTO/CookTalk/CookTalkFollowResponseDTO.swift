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
    let page, size, totalElements, totalPages: Int
    let cookTalkDtoList: [CookTalkFollowResponseListDTO]
}

struct CookTalkFollowResponseListDTO: Codable {
    let writerUserId: Int
    let writerUserEmail: String
    let writerProfile: String?
    let writerNickName: String
    let postId: Int
    let introduction, postImagePath, lastModifiedAt: String
    let profile: String?
    let likeCounts: Int
    let likedCheck, followCheck: Bool
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
        return .init(
            nextPageValid: nextPageValid,
            page: page,
            size: size,
            totalElements: totalElements,
            totalPages: totalPages,
            cookTalkDtoList: cookTalkDtoList.map { $0.toDomain() }
        )
    }
}

extension CookTalkFollowResponseListDTO {
    func toDomain() -> CookTalkFollowResponseList {
        return .init(
            writerUserId: writerUserId,
            writerUserEmail: writerUserEmail,
            writerProfile: writerProfile,
            writerNickName: writerNickName,
            postId: postId,
            introduction: introduction,
            postImagePath: postImagePath,
            lastModifiedAt: lastModifiedAt,
            profile: profile,
            likeCounts: likeCounts,
            likedCheck: likedCheck,
            followCheck: followCheck
        )
    }
}
