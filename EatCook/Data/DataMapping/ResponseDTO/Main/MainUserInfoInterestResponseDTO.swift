//
//  MainUserInfoInterestResponseDTO.swift
//  EatCook
//
//  Created by 강신규 on 7/30/24.
//

import Foundation


struct MainUserInfoInterestResponseDTO: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: MainUserInterestDataDTO
}

struct MainUserInterestDataDTO : Codable {
    let nextPageValid : Bool
    let totalElements : Int
    let totalPages : Int
    let homeInterestDtoList : [HomeInterestDtoListDataDTO]
}

struct HomeInterestDtoListDataDTO : Codable {
    let postId : Int
    let postImagePath : String
    let recipeName : String
    let recipeTime : Int
    let profile : String
    let nickName : String
    let likedCounts : Int
    let likedCheck : Bool
    let archiveCheck : Bool
}


extension MainUserInfoInterestResponseDTO {
    func toDomain() -> MainUserInfoInterestResponse {
        return .init(success: success, code: code, message: message, data: data.toDomain())
    }
}


extension MainUserInterestDataDTO {
    func toDomain() -> MainUserInterestData {
        return .init(nextPageValid: nextPageValid, totalElements: totalElements, totalPages: totalPages, homeInterestDtoList: homeInterestDtoList.map { $0.toDomain() })
    }
}


extension HomeInterestDtoListDataDTO {
    func toDomain() -> HomeInterestDtoListData {
        return .init(postId: postId, postImagePath: postImagePath, recipeName: recipeName, recipeTime: recipeTime, profile: profile, nickName: nickName, likedCounts: likedCounts, likedCheck: likedCheck, archiveCheck: archiveCheck)
    }
}
