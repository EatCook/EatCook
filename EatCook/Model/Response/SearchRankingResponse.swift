//
//  SearchRankingResponse.swift
//  EatCook
//
//  Created by 강신규 on 7/16/24.
//

import Foundation


struct SearchRankingResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: [SearchRankingResponseData] // 데이터의 타입에 따라 적절히 수정 가능
}

struct SearchRankingResponseData : Codable {
    let searchWord: String
    let searchCount: Int
}
