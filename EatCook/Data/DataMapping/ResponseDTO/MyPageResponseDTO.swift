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
    let nickName, badge: String
    let follower, following: Int
    let providerType: String
    let posts: MyPagePostsDTO
}

struct MyPagePostsDTO: Codable {
    let content: [MyPageContentDTO]
    let page, size, totalElements, totalPages: Int
    let hasNextPage: Bool
}

struct MyPageContentDTO: Codable {
    let postId: Int
    let postImagePath, recipeName, introduction: String
    let likeCounts: Int
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
        return .init(userId: userId,
                     nickName: nickName,
                     badge: badge,
                     follower: follower,
                     following: following,
                     providerType: providerType,
                     posts: posts.toDomain())
    }
}

extension MyPagePostsDTO {
    func toDomain() -> MyPagePosts {
        return .init(content: content.map { $0.toDomain() },
                     page: page,
                     size: size,
                     totalElements: totalElements,
                     totalPages: totalPages,
                     hasNextPage: hasNextPage)
    }
}

extension MyPageContentDTO {
    func toDomain() -> MyPageContent {
        return .init(postId: postId,
                     postImagePath: postImagePath,
                     recipeName: recipeName,
                     introduction: introduction,
                     likeCounts: likeCounts)
    }
}
