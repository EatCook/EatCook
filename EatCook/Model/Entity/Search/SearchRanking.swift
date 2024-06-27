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
    let data: [SearchRankingData] // 데이터의 타입에 따라 적절히 수정 가능
}

struct SearchRankingData : Codable {
    let searchWord: String
    let searchCount: Int
}
