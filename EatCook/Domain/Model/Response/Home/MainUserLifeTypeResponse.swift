//
//  MainUserLifeTypeResponse.swift
//  EatCook
//
//  Created by 강신규 on 8/8/24.
//

import Foundation

struct MainUserLifeTypeResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: MainUserLifeTypeData?
}

struct MainUserLifeTypeData : Codable {
    let nextPageValid : Bool
    let totalElements : Int
    let totalPages : Int
    let homeInterestDtoList : [HomeLifeTypeDtoListData]
}

struct HomeLifeTypeDtoListData : Codable {
    let postId : Int
    let postImagePath : String
    let recipeName : String
    let introduction : String
    let recipeTime : Int
    let likedCounts : Int
    let likedCheck : Bool
    let archiveCheck : Bool
}
