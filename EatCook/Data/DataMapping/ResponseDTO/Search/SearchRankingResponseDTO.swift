//
//  SearchRankingResponseDTO.swift
//  EatCook
//
//  Created by 강신규 on 7/31/24.
//

import Foundation

struct SearchRankingResponseDTO: Codable {
    let success: Bool
    let code: String
    let message: String
    let data : DataClass
}

struct DataClass : Codable {
    let lastUpdateTime : String
    let rankings : [SearchRankingData]
}

struct SearchRankingData : Codable, Identifiable {
    let id = UUID()
    let searchWord: String
    let searchCount: Int
    let rank : Int
    let rankChange : Int
}
