//
//  SearchRankingResponseDTO.swift
//  EatCook
//
//  Created by 강신규 on 7/16/24.
//

import Foundation

struct SearchRankingResponseDTO : Codable {
    let success: Bool
    let code: String
    let message: String
    let data: [SearchRankingResponseDataDTO] // 데이터의 타입에 따라 적절히 수정 가능
}

struct SearchRankingResponseDataDTO : Codable {
    let searchWord: String
    let searchCount: Int
}

extension SearchRankingResponseDTO {
    func toDomain() -> SearchRankingResponse {
        return .init(success: success, code: code, message: message, data: data.map { $0.toDomain() })
    }
}

extension SearchRankingResponseDataDTO {
    func toDomain() -> SearchRankingResponseData {
        return .init(searchWord: searchWord, searchCount: searchCount)
    }
}
