//
//  SearchService.swift
//  EatCook
//
//  Created by 강신규 on 7/31/24.
//

import Foundation

class SearchService {
    
    static let shard = { SearchService() }()
    
    private let API_SEARCH_RANKING = "/api/v1/posts/search/ranking"
    private let API_SEARCH = "/api/v1/posts/search"
    
    // 검색어 랭킹 순위
    func getSearchRanking(success: @escaping (SearchRankingResponseDTO) -> (), failure: @escaping (SearchRankingResponseDTO) -> ()) {
        APIClient.shared.request(API_SEARCH_RANKING, method: .get, responseType: SearchRankingResponseDTO.self, successHandler: { (result) in
            
            print("result :" ,result)
            
            success(result)
            
        }, failureHandler: { (result) in
            failure(result)
            print("ERROR")
        })
    }
    
    // 음식 검색
    func getSearch(parameters:[String:Any],  success: @escaping (SearchMenuResponseDTO) -> (), failure: @escaping (SearchMenuResponseDTO) -> ()) {
        APIClient.shared.request(API_SEARCH, method: .post, parameters: parameters, responseType: SearchMenuResponseDTO.self, successHandler: { (result) in
            
            print("result :" ,result)
            
            success(result)
            
        }, failureHandler: { (result) in
            failure(result)
            print("ERROR")
        })
    }
    
    
    
}
