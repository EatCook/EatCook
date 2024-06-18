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
    
    // 검색어 랭킹 순위
    func getSearchRanking(success: @escaping (BaseStruct<EmailRequestData>) -> (), failure: @escaping (BaseStruct<EmailRequestData>) -> ()) {
        APIClient.shared.request(API_SEARCH_RANKING, method: .get, responseType: EmailRequestData.self, successHandler: { (result) in
            
            print("result :" ,result)
            
            success(result)
            
        }, failureHandler: { (result) in
            failure(result)
            print("ERROR")
        })
    }
    
    
    
}
