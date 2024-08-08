//
//  MainUserLifeTypeResponseDTO.swift
//  EatCook
//
//  Created by 강신규 on 7/30/24.
//

import Foundation


struct MainUserLifeTypeResponseDTO: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: MainUserLifeTypeDataDTO?
}

struct MainUserLifeTypeDataDTO : Codable {
    let nextPageValid : Bool
    let totalElements : Int
    let totalPages : Int
    let homeInterestDtoList : [HomeLifeTypeDtoListDataDTO]
}

struct HomeLifeTypeDtoListDataDTO : Codable {
    let postId : Int
    let postImagePath : String
    let recipeName : String
    let introduction : String
    let recipeTime : Int
    let likedCounts : Int
    let likedCheck : Bool
    let archiveCheck : Bool
}

extension MainUserLifeTypeResponseDTO {
    func toDomain() -> MainUserLifeTypeResponse {
        return .init(success: success, code: code, message: message, data: data?.toDomain())
    }
    
}

extension MainUserLifeTypeDataDTO {
    func toDomain() -> MainUserLifeTypeData {
        return .init(nextPageValid: nextPageValid, totalElements: totalElements, totalPages: totalPages, homeInterestDtoList: homeInterestDtoList.map { $0.toDomain() })
    }
    
}


extension HomeLifeTypeDtoListDataDTO {
    func toDomain() -> HomeLifeTypeDtoListData {
        return .init(postId: postId, postImagePath: postImagePath, recipeName: recipeName, introduction: introduction, recipeTime: recipeTime, likedCounts: likedCounts, likedCheck: likedCheck, archiveCheck: archiveCheck)
        
    }
}
