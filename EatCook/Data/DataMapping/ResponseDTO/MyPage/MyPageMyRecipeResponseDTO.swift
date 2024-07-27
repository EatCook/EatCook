//
//  MyPageMyRecipeResponseDTO.swift
//  EatCook
//
//  Created by 이명진 on 7/25/24.
//

import Foundation

struct MyPageMyRecipeResponseDTO: Codable {
    let success: Bool
    let code, message: String
    let data: MyPageMyRecipePostsDTO
}

struct MyPageMyRecipePostsDTO: Codable {
    let page: Int
    let size: Int
    let totalElements: Int
    let totalPages: Int
    let hasNextPage: Bool
    let content: [MyPageMyRecipeContentDTO]
}

struct MyPageMyRecipeContentDTO: Codable {
    let postId: Int
    let postImagePath: String
    let recipeName: String
    let introduction: String
    let likeCounts: Int
}

extension MyPageMyRecipeResponseDTO {
    func toDomain() -> MyPageMyRecipeResponse {
        return .init(
            success: success,
            code: code,
            message: message,
            data: data.toDomain()
        )
    }
}

extension MyPageMyRecipePostsDTO {
    func toDomain() -> MyPageMyRecipePosts {
        return .init(
            page: page,
            size: size,
            totalElements: totalElements,
            totalPages: totalPages,
            hasNextPage: hasNextPage,
            content: content.map { $0.toDomain() }
        )
    }
}

extension MyPageMyRecipeContentDTO {
    func toDomain() -> MyPageMyRecipeContent {
        return .init(
            postId: postId,
            postImagePath: postImagePath,
            recipeName: recipeName,
            introduction: introduction,
            likeCounts: likeCounts
        )
    }
}
