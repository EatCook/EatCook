//
//  MainUserInfoInterestResponse.swift
//  EatCook
//
//  Created by 강신규 on 8/8/24.
//

import Foundation

struct MainUserInfoInterestResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: MainUserInterestData
}

struct MainUserInterestData : Codable {
    let nextPageValid : Bool
    let totalElements : Int
    let totalPages : Int
    let homeInterestDtoList : [HomeInterestDtoListData]
}

struct HomeInterestDtoListData : Codable {
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





