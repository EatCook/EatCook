//
//  MainService.swift
//  EatCook
//
//  Created by 강신규 on 7/30/24.
//

import Foundation

class MainService {
    
    static let shard = { MainService() }()
    
    private let API_HOME_USERINFO = "/api/v1/home"
    private let API_HOME_INTEREST = "/api/v1/home/interest/"
    private let API_HOME_SPECIAL = "/api/v1/home/special/"
    

    // 유저 정보 검색
    func getUserInfo(success: @escaping (MainUserInfoResponseDTO) -> (), failure: @escaping (MainUserInfoResponseDTO) -> ()) {
        APIClient.shared.request(API_HOME_USERINFO, method: .get , responseType: MainUserInfoResponseDTO.self, successHandler: { (result) in
            
            print("getUserInforesult :" ,result)
            
            success(result)
            
        }, failureHandler: { (result) in
            failure(result)
            print("ERROR")
        })
    }
    
    
    // 유저 관심요리 검색
    func getUserInterest(type : String , success: @escaping (MainUserInfoInterestResponseDTO) -> (), failure: @escaping (MainUserInfoInterestResponseDTO) -> ()) {
        APIClient.shared.request(API_HOME_INTEREST+type, method: .get , responseType: MainUserInfoInterestResponseDTO.self, successHandler: { (result) in
            
            print("getUserInterestresult :" ,result)
            
            success(result)
            
        }, failureHandler: { (result) in
            failure(result)
            print("ERROR")
        })
    }
    
    // 유저 생활요리 검색
    func getUserSpecial(type : String, success: @escaping (MainUserLifeTypeResponseDTO) -> (), failure: @escaping (MainUserLifeTypeResponseDTO) -> ()) {
        APIClient.shared.request(API_HOME_SPECIAL+type, method: .get , responseType: MainUserLifeTypeResponseDTO.self, successHandler: { (result) in
            
            print("getUserSpecialresult :" ,result)
            
            success(result)
            
        }, failureHandler: { (result) in
            failure(result)
            print("ERROR")
        })
    }
    
    
    
}
