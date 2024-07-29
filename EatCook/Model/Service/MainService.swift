//
//  MainService.swift
//  EatCook
//
//  Created by 강신규 on 7/15/24.
//

import Foundation

class MainService {
    
    static let shard = { MainService() }()
    
    private let API_HOME_USERINFO = "/api/v1/home"
    private let API_HOME_INTEREST = "/api/v1/home/interest/"
    private let API_HOME_SPECIAL = "/api/v1/home/special/"
    

    // 유저 정보 검색
    func getUserInfo(success: @escaping (MainUserInfo) -> (), failure: @escaping (MainUserInfo) -> ()) {
        APIClient.shared.request(API_HOME_USERINFO, method: .get , responseType: MainUserInfo.self, successHandler: { (result) in
            
            print("getUserInforesult :" ,result)
            
            success(result)
            
        }, failureHandler: { (result) in
            failure(result)
            print("ERROR")
        })
    }
    
    
    // 유저 관심요리 검색
    func getUserInterest(type : String , success: @escaping (MainUserInterestResponse) -> (), failure: @escaping (MainUserInterestResponse) -> ()) {
        APIClient.shared.request(API_HOME_INTEREST+type, method: .get , responseType: MainUserInterestResponse.self, successHandler: { (result) in
            
            print("getUserInterestresult :" ,result)
            
            success(result)
            
        }, failureHandler: { (result) in
            failure(result)
            print("ERROR")
        })
    }
    
    // 유저 생활요리 검색
    func getUserSpecial(success: @escaping (MainUserLifeTypeResponse) -> (), failure: @escaping (MainUserLifeTypeResponse) -> ()) {
        APIClient.shared.request(API_HOME_SPECIAL, method: .get , responseType: MainUserLifeTypeResponse.self, successHandler: { (result) in
            
            print("getUserSpecialresult :" ,result)
            
            success(result)
            
        }, failureHandler: { (result) in
            failure(result)
            print("ERROR")
        })
    }
    
    
    
}
