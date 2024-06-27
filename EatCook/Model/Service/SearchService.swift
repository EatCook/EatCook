//
//  SearchService.swift
//  EatCook
//
//  Created by 강신규 on 6/18/24.
//

import Foundation

class SearchService {
    
    static let shard = { SearchService() }()
    
    private let API_SEARCH_RANKING = "/api/v1/posts/search/ranking"
    private let API_SEARCH = "/api/v1/posts/search"
    
    // 검색어 랭킹 순위
    func getSearchRanking(success: @escaping (SearchRanking) -> (), failure: @escaping (SearchRanking) -> ()) {
        APIClient.shared.request(API_SEARCH_RANKING, method: .get, responseType: SearchRanking.self, successHandler: { (result) in
            
            print("result :" ,result)
            
            success(result)
            
        }, failureHandler: { (result) in
            failure(result)
            print("ERROR")
        })
    }
    
    // 음식 검색
    func getSearch(parameters:[String:Any],  success: @escaping (SearchMenu) -> (), failure: @escaping (SearchMenu) -> ()) {
        APIClient.shared.request(API_SEARCH, method: .post, parameters: parameters, responseType: SearchMenu.self, successHandler: { (result) in
            
            print("result :" ,result)
            
            success(result)
            
        }, failureHandler: { (result) in
            failure(result)
            print("ERROR")
        })
    }
    
    
    
}
