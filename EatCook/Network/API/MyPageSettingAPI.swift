//
//  MyPageSettingAPI.swift
//  EatCook
//
//  Created by 이명진 on 7/25/24.
//

import Foundation

enum MyPageSettingAPI: EndPoint {
    case leaveEatCook
    case updatePassword
    case alarm
    case updateAlarm
    case interestCook
    case updateInterestCook(_ query: MyFavoriteTagRequestDTO)
    
    var path: String {
        switch self {
        case .leaveEatCook:
            return "/api/v1/mypage/profile/leave"
        case .updatePassword:
            return "/api/v1/mypage/profile/password"
        case .alarm, .updateAlarm:
            return "/api/v1/mypage/setting"
        case .interestCook, .updateInterestCook:
            return "/api/v1/mypage/setting/interest-cook"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .leaveEatCook:
            return .delete
        case .alarm, .interestCook:
            return .get
        case .updatePassword, .updateAlarm, .updateInterestCook:
            return .patch
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .leaveEatCook:
            return .requestWithParameters(
                parameters: [:],
                encoding: .urlEncoding
            )
        case .updatePassword:
            return .requestWithParameters(
                parameters: [:],
                encoding: .jsonEncoding
            )
        case .alarm:
            return .requestWithParameters(
                parameters: [:],
                encoding: .urlEncoding
            )
        case .updateAlarm:
            return .requestWithParameters(
                parameters: [:],
                encoding: .jsonEncoding
            )
        case .interestCook:
            return .requestWithParameters(
                parameters: [:],
                encoding: .urlEncoding
            )
        case .updateInterestCook(let query):
            return .requestWithParameters(
                parameters: query.toDictionary,
                encoding: .jsonEncoding
            )
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .leaveEatCook, .updatePassword, .alarm, .updateAlarm, .interestCook, .updateInterestCook:
            return HTTPHeaderField.default
            
        }
    }
    
}
