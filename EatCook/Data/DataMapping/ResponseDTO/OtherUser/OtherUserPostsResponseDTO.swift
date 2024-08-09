//
//  OtherUserPostsResponseDTO.swift
//  EatCook
//
//  Created by 이명진 on 7/28/24.
//

import Foundation

struct OtherUserPostsResponseDTO: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: OtherUserPostsResponseDataDTO
}

struct OtherUserPostsResponseDataDTO: Codable {
    let content: [OtherUserPostsResponseListDTO]
    let page: Int
    let size: Int
    let totalElements: Int
    let totalPages: Int
    let hasNextPage: Bool
}

struct OtherUserPostsResponseListDTO: Codable {
    let postId: Int
    let postImagePath: String
    let recipeName: String
    let recipeTime: Int
    let writerProfile: String
    let writerNickName: String
    let writerUserId: Int
    let writerUserEmail: String
    let introduction: String
    let likedCounts: Int
    let likedCheck: Bool
    let archiveCheck: Bool
}

extension OtherUserPostsResponseDTO {
    func toDomain() -> OtherUserPostsResponse {
        return .init(
            success: success,
            code: code,
            message: message,
            data: data.toDomain()
        )
    }
}

extension OtherUserPostsResponseDataDTO {
    func toDomain() -> OtherUserPostsResponseData {
        return .init(
            content: content.map { $0.toDomain() },
            page: page,
            size: size,
            totalElements: totalElements,
            totalPages: totalPages,
            hasNextPage: hasNextPage
        )
    }
}

extension OtherUserPostsResponseListDTO {
    func toDomain() -> OtherUserPostsResponseList {
        return .init(
            postId: postId,
            postImagePath: postImagePath,
            recipeName: recipeName,
            recipeTime: recipeTime,
            writerProfile: writerProfile,
            writerNickName: writerNickName,
            writerUserId: writerUserId,
            writerUserEmail: writerUserEmail,
            introduction: introduction,
            likedCounts: likedCounts,
            likedCheck: likedCheck,
            archiveCheck: archiveCheck
        )
    }
}
