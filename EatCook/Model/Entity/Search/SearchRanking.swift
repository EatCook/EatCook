//
//  SearchRanking.swift
//  EatCook
//
//  Created by 강신규 on 6/27/24.
//

import Foundation

struct SearchRanking: Codable {
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

